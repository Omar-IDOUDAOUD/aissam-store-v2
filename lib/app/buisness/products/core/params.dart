import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/core/interfaces/cache_identifier.dart';

abstract class _DataPaginationParamsProperty {
  final DataPaginationParams paginationParams;

  _DataPaginationParamsProperty({required this.paginationParams});
}

class GetCategoriesParams extends _DataPaginationParamsProperty
    with CacheIdentifier {
  final String? parentCategory;

  GetCategoriesParams({required super.paginationParams, this.parentCategory});

  @override
  String buildCacheIdentifier() {
    return paginationParams.buildCacheIdentifier() + parentCategory.toString();
  }
}

class GetProductsByCategoryParams extends _DataPaginationParamsProperty
    with CacheIdentifier {
  final String category;

  GetProductsByCategoryParams(
      {required super.paginationParams, required this.category});

  @override
  String buildCacheIdentifier() {
    return paginationParams.buildCacheIdentifier() + category;
  }
}

class GetProductByPerformanceParams extends _DataPaginationParamsProperty
    with CacheIdentifier {
  final ProductsPerformance performance;

  GetProductByPerformanceParams(
      {required super.paginationParams, required this.performance});

  @override
  String buildCacheIdentifier() {
    return paginationParams.buildCacheIdentifier() + performance.toString();
  }
}

class SearchProductsParams extends _DataPaginationParamsProperty
    with CacheIdentifier {
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
  String buildCacheIdentifier() {
    return '${paginationParams.buildCacheIdentifier()}$keywords${categories?.length}${colorNames?.length}${sizes?.length}$minPrice$maxPrice';
  }
}
