import 'package:aissam_store_v2/app/buisness/products/data/data_source/product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource _productsDatasource;

  ProductsRepositoryImpl(this._productsDatasource);

  @override
  Future<Either<Failure, DataPagination<Category>>> categories(
      GetCategoriesParams params) async {
    try {
      final res = await _productsDatasource.categories(params);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByCategory(
      GetProductsByCategoryParams params) async {
    try {
      final res = await _productsDatasource.productsByCategory(params);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByPerformance(
      GetProductByPerformanceParams params) async {
    try {
      final res = await _productsDatasource.productsByPerformance(params);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> searchProducts(
      SearchProductsParams params) async {
    try {
      final res = await _productsDatasource.searchProducts(params);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }
  
  @override
  Future<Either<Failure, ProductDetailsModel>> product(String id) async {
    try {
      final res = await _productsDatasource.product(id);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }
}
