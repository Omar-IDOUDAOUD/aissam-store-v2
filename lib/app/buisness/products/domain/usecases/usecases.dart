import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class GetCategories
    implements FutureUseCase<DataPagination<Category>, GetCategoriesParams> {
  final   repository = sl.getAsyncOnce<ProductsRepository>();

  @override
  Future<Either<Failure, DataPagination<Category>>> call(
      GetCategoriesParams params) async {
    return (await repository).categories(params);
  }
}

class GetProductsByCategory
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductsByCategoryParams> {
  final   _repository = sl.getAsyncOnce<ProductsRepository>();
              

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductsByCategoryParams params) async {
    return (await _repository).productsByCategory(params);
  }
}

class GetProductsByPerformance
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductByPerformanceParams> {
  final  _repository = sl.getAsyncOnce<ProductsRepository>();

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductByPerformanceParams params) async {
    return (await _repository).productsByPerformance(params);
  }
}

class SearchProducts
    implements
        FutureUseCase<DataPagination<ProductPreview>, SearchProductsParams> {
  final   _repository = sl.getAsyncOnce<ProductsRepository>();


  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      SearchProductsParams params) async {
    return (await _repository).searchProducts(params);
  }
}



class GetProduct
    implements
        FutureUseCase<ProductDetails, String> {
  final   _repository = sl.getAsyncOnce<ProductsRepository>();


  @override
  Future<Either<Failure, ProductDetails>> call(
      String id) async {
    return (await _repository).product(id);
  }
}
