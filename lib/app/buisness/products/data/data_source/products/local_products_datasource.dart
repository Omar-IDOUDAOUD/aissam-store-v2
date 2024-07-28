import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/services/caching/cache_manager.dart';
import 'package:aissam_store_v2/core/types.dart';

abstract class ProductsLocalDatasource {
  ////////// Get Data
  Future<DataPagination<CategoryModel>> categories(GetCategoriesParams params);
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      DataPaginationParams params);
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      DataPaginationParams params);

  Future<ProductDetailsModel> product(String id);
  ////////// Cache Data
  Future<void> cacheCategories(
      GetCategoriesParams params, List<CategoryModel> res);
  Future<void> cacheProductsByPerformance(
      DataPaginationParams params, List<ProductPreviewModel> res);
  Future<void> cacheProductsByCategory(
      DataPaginationParams params, List<ProductPreviewModel> res);

  Future<void> cacheProduct(String id, ProductDetailsModel product);
}

class ProductsLocalDatasourceImpl extends ProductsLocalDatasource {
  final CacheManager _cacheManager;

  ProductsLocalDatasourceImpl(this._cacheManager);

  List<String> get _defPath => ['products/interfaces'];
  T _defFromMap<T>(e) => e as T;
  Map2 _defToMap<T>(e) => e as Map2;

  DataPagination<T> _buildPagination<T>(
      List<Map<String, dynamic>> data,
      T Function(Map<String, dynamic>) fromMap,
      DataPaginationParams paginationParams) {
    final convertedData = data.map((e) {
      return fromMap(e);
    }).toList();
    final pagination = DataPagination<T>.ready(
      items: convertedData,
      params: paginationParams,
      tokenObj: (paginationParams.tokenObj ?? 0) + data.length,
    );
    return pagination;
  }

  List<String> _categories(String? subCategory) =>
      ['categories', subCategory ?? 'main'];
  @override
  Future<void> cacheCategories(
      GetCategoriesParams params, List<CategoryModel> res) {
    return _cacheManager.addToDocument(
      cleanUpFirst: true,
      document: params.paginationParams.page.toString(),
      path: _defPath..addAll(_categories(params.parentCategory)),
      data: res.map((elem) => elem.toCacheJson()).toList(),
    );
  }

  String get _productDetails => 'product_details';
  @override
  Future<void> cacheProduct(String id, ProductDetailsModel product) {
    return _cacheManager.addToDocument(
      document: id,
      path: _defPath..add(_productDetails),
      data: product.toCacheJson(),
    );
  }

  String get _productByCategory => 'products_by_category';
  @override
  Future<void> cacheProductsByCategory(
      DataPaginationParams params, List<ProductPreviewModel> res) {
    return _cacheManager.addToDocument(
      cleanUpFirst: true,
      document: params.page.toString(),
      path: _defPath..add(_productByCategory),
      data: res.map((elem) => elem.toCacheJson()).toList(),
    );
  }

  String get _productByPerformance => 'products_by_performance';

  @override
  Future<void> cacheProductsByPerformance(
      DataPaginationParams params, List<ProductPreviewModel> res) {
    return _cacheManager.addToDocument(
      cleanUpFirst: true,
      document: params.page.toString(),
      path: _defPath..add(_productByPerformance),
      data: res.map((elem) => elem.toCacheJson()).toList(),
    );
  }

  @override
  Future<DataPagination<CategoryModel>> categories(
      GetCategoriesParams params) async {
    final res = await _cacheManager.getDocument(
      document: params.paginationParams.page.toString(),
      path: _defPath..addAll(_categories(params.parentCategory)),
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(List.from(res.values.map((e) => Map2.from(e))),
        CategoryModel.fromCache, params.paginationParams);
  }

  @override
  Future<ProductDetailsModel> product(String id) async {
    final res = await _cacheManager.getDocumentEntry(
      document: id,
      path: _defPath..add(_productDetails),
      key: 0,
    );
    if (res == null) throw NoCachedDataException();
    return ProductDetailsModel.fromCache(Map2.from(res as Map));
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      DataPaginationParams params) async {
    final res = await _cacheManager.getDocument(
      document: params.page.toString(),
      path: _defPath..add(_productByCategory),
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(List.from(res.values.map((e) => Map2.from(e))),
        ProductPreviewModel.fromCache, params);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      DataPaginationParams params) async {
    final res = await _cacheManager.getDocument(
      document: params.page.toString(),
      path: _defPath..add(_productByPerformance),
    );

    if (res == null) throw NoCachedDataException();
    return _buildPagination(List.from(res.values.map((e) => Map2.from(e))),
        ProductPreviewModel.fromCache, params);
  }
}
