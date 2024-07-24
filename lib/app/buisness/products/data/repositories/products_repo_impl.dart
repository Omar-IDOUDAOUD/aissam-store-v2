import 'package:aissam_store_v2/app/buisness/products/data/data_source/products/local_products_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/products/remote_product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDatasource _productsDatasource;
  final ProductsLocalDatasource _productsLocalDatasource;

  ProductsRepositoryImpl(
      this._productsDatasource, this._productsLocalDatasource);

  @override
  Future<Either<Failure, DataPagination<Category>>> categories(
      GetCategoriesParams params) async {
    try {
      final res = await _productsDatasource.categories(params);
      _productsLocalDatasource.cacheCategories(params, res.items);
      return Right(res);
    } on NetworkException {
      return await _productsLocalDatasource
          .categories(params)
          .then<Either<Failure, DataPagination<Category>>>((res) => Right(res))
          .catchError(
            (e, _) => Left<Failure, DataPagination<Category>>(
                Failure.fromExceptionOrFailure(e)),
          );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByCategory(
      ProductsByCategoryParams params) async {
    try {
      final res = await _productsDatasource.productsByCategory(params);
      _productsLocalDatasource.cacheProductsByCategory(params, res.items);
      return Right(res);
    } on NetworkException {
      return await _productsLocalDatasource
          .productsByCategory(params)
          .then<Either<Failure, DataPagination<ProductPreview>>>(
              (res) => Right(res))
          .catchError(
            (e, _) => Left<Failure, DataPagination<ProductPreview>>(
                Failure.fromExceptionOrFailure(e)),
          );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByPerformance(
      ProductByPerformanceParams params) async {
    try {
      final res = await _productsDatasource.productsByPerformance(params);
      _productsLocalDatasource.cacheProductsByPerformance(params, res.items);
      return Right(res);
    } on NetworkException {
      return await _productsLocalDatasource
          .productsByPerformance(params)
          .then<Either<Failure, DataPagination<ProductPreview>>>(
              (res) => Right(res))
          .catchError(
            (e, _) => Left<Failure, DataPagination<ProductPreview>>(
                Failure.fromExceptionOrFailure(e)),
          );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductDetails>> product(String id) async {
    try {
      final res = await _productsDatasource.product(id);
      _productsLocalDatasource.cacheProduct(id, res);
      return Right(res);
    } on NetworkException {
      return await _productsLocalDatasource
          .product(id)
          .then<Either<Failure, ProductDetailsModel>>((res) => Right(res))
          .catchError(
            (e, _) => Left<Failure, ProductDetailsModel>(
                Failure.fromExceptionOrFailure(e)),
          );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }
}
