import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';

abstract class ProductsRemoteDatasource {
  Future<DataPagination<CategoryModel>> categories(GetCategoriesParams params);
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      GetProductByPerformanceParams params);
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params);
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params);
  Future<ProductDetailsModel> product(String id);
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final MongoDb _mongodb;

  ProductsRemoteDatasourceImpl(this._mongodb);

  Future<MongoCollection> _getCollection(String collactionName) async {
    final db = await _mongodb.db;
    return db.collection(collactionName);
  }

  Future<MongoCollection> get _productsCollection => _getCollection('products');
  Future<MongoCollection> get _categoriesCollection =>
      _getCollection('categories');

  QueryExpression _buildQuery(DataPaginationParams paginationParams,
      {List<String>? fields}) {
    var builder = where
      ..limit(paginationParams.pageSize)
      ..skip(paginationParams.indexIdentifierObj ?? 0);
    if (fields != null) builder.selectFields(fields);
    return builder;
  }

  DataPagination<T> _buildPagination<T>(
      List<Map<String, dynamic>> data,
      T Function(Map<String, dynamic>) fromMap,
      DataPaginationParams paginationParams) {
    final convertedData = data.map((e) {
      return fromMap(e);
    }).toList();
    final pagination = DataPagination<T>(
      items: convertedData,
      hasNextPage: data.length == paginationParams.pageSize,
      indexIdentifier: (paginationParams.indexIdentifierObj ?? 0) + data.length,
    );
    return pagination;
  }

  @override
  Future<DataPagination<CategoryModel>> categories(
      GetCategoriesParams params) async {
    final coll = await _categoriesCollection;
    final res =
        await coll.find(filter: _buildQuery(params.paginationParams)).toList();
    return _buildPagination<CategoryModel>(
        res, CategoryModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params) async {
    final coll = await _productsCollection;
    final res = await coll
        .find(
          filter: _buildQuery(params.paginationParams,
              fields: ProductPreviewModel.fields)
            ..$eq('categories', params.category),
        )
        .toList();

    return _buildPagination<ProductPreviewModel>(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      GetProductByPerformanceParams params) async {
    final coll = await _productsCollection;
    final SortExpression sort = switch (params.performance) {
      ProductsPerformance.bestSellers => SortExpression()
        ..addField('sales', descending: true),
      ProductsPerformance.newArrivals => SortExpression()
        ..addField('created_at', descending: true),
      ProductsPerformance.trending => SortExpression()
        ..addField('views', descending: true),
      _ => SortExpression()..addField('average_rating', descending: true),
    };
    final res = await coll
        .find(filter: _buildQuery(params.paginationParams), sort: sort)
        .toList();
    return _buildPagination<ProductPreviewModel>(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params) async {
    final coll = await _productsCollection;
    final query = _buildQuery(params.paginationParams);
    if (params.categories != null && params.categories!.isNotEmpty)
      query.$in('categories', params.categories!);
    if (params.sizes != null && params.sizes!.isNotEmpty)
      query.$in('sizes', params.sizes!);
    if (params.colorNames != null && params.colorNames!.isNotEmpty)
      query.$in('available_colors', params.colorNames!);
    query.inRange(
        'price', params.minPrice ?? 0, params.maxPrice ?? double.infinity);
    return _buildPagination(
      await coll.find(filter: query).toList(),
      ProductPreviewModel.fromJson,
      params.paginationParams,
    );
  }

  @override
  Future<ProductDetailsModel> product(String id) async {
    final coll = await _productsCollection;
    final Map<String, dynamic>? res = await coll
        .findOneAndUpdate(
          where..id(ObjectId.fromHexString(id)),
          UpdateExpression()..$inc('views', 1),
        )
        .then((v) => v.$2);
    if (res == null) throw ProductNotFoundFailure();
    return ProductDetailsModel.fromJson(res);
  }
}
