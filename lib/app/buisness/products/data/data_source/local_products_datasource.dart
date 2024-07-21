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
      GetProductByPerformanceParams params);
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params);
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params);
  Future<ProductDetailsModel> product(String id);
  ////////// Cache Data
  Future<void> cacheCategories(
      GetCategoriesParams params, List<CategoryModel> res);
  Future<void> cacheProductsByPerformance(
      GetProductByPerformanceParams params, List<ProductPreviewModel> res);
  Future<void> cacheProductsByCategory(
      GetProductsByCategoryParams params, List<ProductPreviewModel> res);
  Future<void> cacheSearchProducts(
      SearchProductsParams params, List<ProductPreviewModel> res);
  Future<void> cacheProduct(String id, ProductDetailsModel product);
}

class ProductsLocalDatasourceImpl extends ProductsLocalDatasource {
  final CacheManager _cacheManager;

  ProductsLocalDatasourceImpl(this._cacheManager);

  get _defPath => <String>['products'];
  T _defFromMap<T>(e) => e as T;
  Map2 _defToMap<T>(e) => e as Map2;

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

  String get _categories => 'categories';
  @override
  Future<void> cacheCategories(
      GetCategoriesParams params, List<CategoryModel> res) {
    return _cacheManager.commitNewCache(
      key: params.buildCacheKey(),
      collection: 'categories',
      path: _defPath,
      data: res.map((elem) => elem.toJson()).toList(),
    );
  }

  String get _productDetails => 'product_details';
  @override
  Future<void> cacheProduct(String id, ProductDetailsModel product) {
    return _cacheManager.commitNewCache(
      key: id,
      collection: _productDetails,
      path: _defPath,
      data: product.toJson(),
    );
  }

  String get _productByCategory => 'products_by_category';
  @override
  Future<void> cacheProductsByCategory(
      GetProductsByCategoryParams params, List<ProductPreviewModel> data) {
    return _cacheManager.commitNewCache(
      key: params.buildCacheKey(),
      collection: _productByCategory,
      path: _defPath,
      data: data.map((elem) => elem.toJson()).toList(),
    );
  }

  String get _productByPerformance => 'products_by_performance';

  @override
  Future<void> cacheProductsByPerformance(
      GetProductByPerformanceParams params, List<ProductPreviewModel> data) {
    return _cacheManager.commitNewCache(
      key: params.buildCacheKey(),
      collection: _productByPerformance,
      path: _defPath,
      data: data.map((elem) => elem.toJson()).toList(),
    );
  }

  String get _productSearch => 'products_search';

  @override
  Future<void> cacheSearchProducts(
      SearchProductsParams params, List<ProductPreviewModel> data) {
    return _cacheManager.commitNewCache(
      key: params.buildCacheKey(),
      collection: _productSearch,
      path: _defPath,
      data: data.map((elem) => elem.toJson()).toList(),
    );
  }

  @override
  Future<DataPagination<CategoryModel>> categories(
      GetCategoriesParams params) async {
    final res = await _cacheManager.getListCaches<Map2>(
      key: params.buildCacheKey(),
      collection: _categories,
      path: _defPath,
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(
        res, CategoryModel.fromJson, params.paginationParams);
  }

  @override
  Future<ProductDetailsModel> product(String id) async {
    final res = await _cacheManager.getCacheObject<Map2>(
      key: id,
      collection: _productDetails,
      path: _defPath,
    );
    if (res == null) throw NoCachedDataException();
    return ProductDetailsModel.fromJson(res);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params) async {
    final res = await _cacheManager.getListCaches<Map2>(
      key: params.buildCacheKey(),
      collection: _productByCategory,
      path: _defPath,
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      GetProductByPerformanceParams params) async {
    final res = await _cacheManager.getListCaches<Map2>(
      key: params.buildCacheKey(),
      collection: _productByPerformance,
      path: _defPath,
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params) async {
    final res = await _cacheManager.getListCaches<Map2>(
      key: params.buildCacheKey(),
      collection: _productSearch,
      path: _defPath,
    );
    if (res == null) throw NoCachedDataException();
    return _buildPagination(
        res, ProductPreviewModel.fromJson, params.paginationParams);
  }
}
