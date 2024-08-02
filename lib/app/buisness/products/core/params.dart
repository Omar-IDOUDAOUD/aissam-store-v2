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

class ProductsByCategoryParams extends _DataPaginationParamsProperty {
  final String category;

  ProductsByCategoryParams(
      {required super.paginationParams, required this.category});
}

class ProductByPerformanceParams extends _DataPaginationParamsProperty {
  final ProductsPerformance performance;

  ProductByPerformanceParams(
      {required super.paginationParams, required this.performance});
}

class SearchProductsParams extends _DataPaginationParamsProperty {
  final SearchProductFilterParams filterParams;
  SearchProductsParams({
    required super.paginationParams,
    required this.filterParams,
  });
}

class SearchProductFilterParams {
  final String keywords;
  final List<String>? categories;
  final List<String>? colorNames;
  final List<String>? sizes;
  final double? minPrice;
  final double? maxPrice;

  SearchProductFilterParams({
    required this.keywords,
    this.categories,
    this.colorNames,
    this.sizes,
    this.minPrice,
    this.maxPrice,
  });
}

class ProductMapParams {
  final List<String> fields;
  final List<String> ids;

  ProductMapParams({required this.fields, required this.ids});
}
