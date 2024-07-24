import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/core/interfaces/cache_key_builder.dart';

abstract class _DataPaginationParamsProperty {
  final DataPaginationParams paginationParams;

  _DataPaginationParamsProperty({required this.paginationParams});
}

class GetCategoriesParams extends _DataPaginationParamsProperty
    with CacheKeyBuilder {
  final String? parentCategory;

  GetCategoriesParams({required super.paginationParams, this.parentCategory});

  @override
  String buildCacheKey() {
    return paginationParams.buildCacheKey() + parentCategory.toString();
  }
}

class ProductsByCategoryParams extends _DataPaginationParamsProperty
    with CacheKeyBuilder {
  final String category;

  ProductsByCategoryParams(
      {required super.paginationParams, required this.category});

  @override
  String buildCacheKey() {
    return paginationParams.buildCacheKey() + category;
  }
}

class ProductByPerformanceParams extends _DataPaginationParamsProperty
    with CacheKeyBuilder {
  final ProductsPerformance performance;

  ProductByPerformanceParams(
      {required super.paginationParams, required this.performance});

  @override
  String buildCacheKey() {
    return paginationParams.buildCacheKey() + performance.toString();
  }
}

class SearchProductsParams extends _DataPaginationParamsProperty
    with CacheKeyBuilder {
  final String keywords;
  final List<String>? categories;
  final List<String>? colorNames;
  final List<String>? sizes;
  final double? minPrice;
  final double? maxPrice;

  SearchProductsParams({
    required super.paginationParams,
    required this.keywords,
    this.categories,
    this.colorNames,
    this.sizes,
    this.minPrice,
    this.maxPrice,
  });

  @override
  String buildCacheKey() {
    return '$keywords${categories?.length}${colorNames?.length}${sizes?.length}$minPrice$maxPrice';
  }
}
