import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/core/types.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class Categories
    implements FutureUseCase<DataPagination<Category>, GetCategoriesParams> {
  @override
  Future<Either<Failure, DataPagination<Category>>> call(
      GetCategoriesParams params) {
    return sl<ProductsRepository>().categories(params);
  }
}

class ProductsByCategory
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            ProductsByCategoryParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      ProductsByCategoryParams params) {
    return sl<ProductsRepository>().productsByCategory(params);
  }
}

class ProductsByPerformance
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            ProductByPerformanceParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      ProductByPerformanceParams params) {
    return sl<ProductsRepository>().productsByPerformance(params);
  }
}

class GetProduct implements FutureUseCase<ProductDetails, String> {
  @override
  Future<Either<Failure, ProductDetails>> call(String id) async {
    return sl<ProductsRepository>().product(id);
  }
}

class GetProductMap implements FutureUseCase<List<Map2>, ProductMapParams> {
  @override
  Future<Either<Failure, List<Map2>>> call(ProductMapParams params) async {
    return sl<ProductsRepository>().productMap(params);
  }
}
