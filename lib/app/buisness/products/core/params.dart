import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:equatable/equatable.dart';

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

class SearchProductsParams {
  final SearchProductFilterParams filterParams;
  final DataPaginationParams? paginationParams;
  SearchProductsParams({
    this.paginationParams,
    required this.filterParams,
  });
}

class SearchProductFilterParams {
  String keywords;
  List<Category> categories = [];
  List<int> colorNames;
  List<String> sizes;
  double minPrice;
  double maxPrice;
  ProductsPerformance performance;
  bool suggestionClick;

  SearchProductFilterParams({
    this.keywords = '',
    required this.categories,
    required this.colorNames,
    required this.sizes,
    required this.minPrice,
    required this.maxPrice,
    this.performance = ProductsPerformance.best_sellers,
    this.suggestionClick = false,
  });
  factory SearchProductFilterParams.empty() {
    return SearchProductFilterParams(
      categories: [],
      colorNames: [],
      sizes: [],
      minPrice: 0,
      maxPrice: double.infinity,
    );
  }

  factory SearchProductFilterParams.suggestion(String keywords) {
    return SearchProductFilterParams.empty()
      ..keywords = keywords
      ..suggestionClick = true;
  }

  bool get isEmpty {
    return categories.isEmpty &&
        colorNames.isEmpty &&
        sizes.isEmpty &&
        minPrice == 0 &&
        maxPrice.isInfinite;
  }

  SearchProductFilterParams copyWith({
    String? keywords,
    List<Category>? categories,
    List<int>? colorNames,
    List<String>? sizes,
    double? minPrice,
    double? maxPrice,
    ProductsPerformance? performance,
  }) {
    return SearchProductFilterParams(
      keywords: keywords ?? this.keywords,
      categories: List.from(categories ?? this.categories),
      colorNames: List.from(colorNames ?? this.colorNames),
      sizes: List.from(sizes ?? this.sizes),
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      performance: performance ?? this.performance,
    );
  }
}

class ProductMapParams {
  final List<String> fields;
  final List<String> ids;

  ProductMapParams({required this.fields, required this.ids});
}
