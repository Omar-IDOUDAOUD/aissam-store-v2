import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';

abstract class _DataPaginationParamsProperty {
  final DataPaginationParams paginationParams;

  _DataPaginationParamsProperty({required this.paginationParams});
}

class GetCategoriesParams extends _DataPaginationParamsProperty {
  final String? parentCategory;

  GetCategoriesParams({required super.paginationParams, this.parentCategory});
}

class GetProductsByCategoryParams extends _DataPaginationParamsProperty {
  final String category;

  GetProductsByCategoryParams(
      {required super.paginationParams, required this.category});
}

class GetProductByPerformanceParams extends _DataPaginationParamsProperty {
  final ProductsPerformance performance;

  GetProductByPerformanceParams(
      {required super.paginationParams, required this.performance});
}

class SearchProductsParams extends _DataPaginationParamsProperty {
  final String keywords;
  final List<String>? categories;
  final List<String>? colorName;
  final List<String>? sizes;
  final double? minPrice;
  final double? maxPrice;

  SearchProductsParams({
    required super.paginationParams,
    required this.keywords,
    this.categories,
    this.colorName,
    this.sizes,
    this.minPrice,
    this.maxPrice,
  });
}
