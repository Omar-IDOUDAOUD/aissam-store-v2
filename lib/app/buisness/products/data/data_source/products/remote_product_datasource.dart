import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';
import 'package:aissam_store_v2/utils/extensions.dart';

abstract class ProductsRemoteDatasource {
  Future<DataPagination<CategoryModel>> categories(GetCategoriesParams params);
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      ProductByPerformanceParams params);
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      ProductsByCategoryParams params);

  Future<ProductDetailsModel> product(String id);
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final MongoDb _mongodb;

  ProductsRemoteDatasourceImpl(this._mongodb);

  Future<DbCollection> _getCollection(String collactionName) async {
    final db = await _mongodb.db;
    return db.collection(collactionName);
  }

  Future<DbCollection> get _productsCollection => _getCollection('products');
  Future<DbCollection> get _categoriesCollection =>
      _getCollection('categories');

  SelectorBuilder _buildQuery(DataPaginationParams paginationParams,
      {List<String>? fields}) {
    final builder = where
      ..limit(paginationParams.pageSize)
      ..skip(paginationParams.tokenObj ?? 0);
    if (fields != null) builder.fields(fields);

    return builder;
  }

  DataPagination<T> _buildPagination<T>(
      List<Map<String, dynamic>> data,
      T Function(Map<String, dynamic>) fromMap,
      DataPaginationParams paginationParams) {
    final convertedData = data.map((e) {
      return fromMap(e);
    }).toList();
    final pagination = DataPagination<T>.ready(
      params: paginationParams,
      items: convertedData,
      tokenObj: (paginationParams.tokenObj ?? 0) + data.length,
    );
    return pagination;
  }

  @override
  Future<DataPagination<CategoryModel>> categories(
      GetCategoriesParams params) async {
    final coll = await _categoriesCollection;
    final res = await coll
        .find(
          _buildQuery(params.paginationParams).eq(
            'parent_category',
            null,
          ),
        )
        .toList();
    return _buildPagination<CategoryModel>(
        res, CategoryModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      ProductsByCategoryParams params) async {
    final coll = await _productsCollection;
    final res = await coll
        .find(
          _buildQuery(params.paginationParams,
                  fields: ProductPreviewModel.fields)
              .eq('categories', params.category),
        )
        .toList();

    return _buildPagination<ProductPreviewModel>(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      ProductByPerformanceParams params) async {
    final coll = await _productsCollection;
    final s = _buildQuery(params.paginationParams);

    switch (params.performance) {
      case ProductsPerformance.bestSellers:
        s.sortBy('sales', descending: true);
      case ProductsPerformance.newArrivals:
        s.sortBy('created_at', descending: true);
      case ProductsPerformance.trending:
        s.sortBy('views', descending: true);
      default:
        s.sortBy('average_rating', descending: true);
    }
    final res = await coll.find(s).toList();
    return _buildPagination<ProductPreviewModel>(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<ProductDetailsModel> product(String id) async {
    final coll = await _productsCollection;
    final Map<String, dynamic>? res = await coll.findAndModify(
      query: where..id2(id),
      update: modify.inc('views', 1),
    );
    if (res == null) throw ProductNotFoundFailure();
    return ProductDetailsModel.fromJson(res);
  }
}
