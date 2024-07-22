import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class GetCategories
    implements FutureUseCase<DataPagination<Category>, GetCategoriesParams> {
  @override
  Future<Either<Failure, DataPagination<Category>>> call(
      GetCategoriesParams params) {
    return sl<ProductsRepository>().categories(params);
  }
}

class GetProductsByCategory
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductsByCategoryParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductsByCategoryParams params) {
    return sl<ProductsRepository>().productsByCategory(params);
  }
}

class GetProductsByPerformance
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductByPerformanceParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductByPerformanceParams params) {
    return sl<ProductsRepository>().productsByPerformance(params);
  }
}

class SearchProducts
    implements
        FutureUseCase<DataPagination<ProductPreview>, SearchProductsParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      SearchProductsParams params) {
    return sl<ProductsRepository>().searchProducts(params);
  }
}

class GetProduct implements FutureUseCase<ProductDetails, String> {
  @override
  Future<Either<Failure, ProductDetails>> call(String id) async {
    return sl<ProductsRepository>().product(id);
  }
}
