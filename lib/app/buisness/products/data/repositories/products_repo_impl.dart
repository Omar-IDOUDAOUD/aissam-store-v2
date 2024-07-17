import 'package:aissam_store_v2/app/buisness/products/data/data_source/local_products_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/remote_product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
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
      _productsLocalDatasource
          .saveAll<CategoryModel>(params,
              collection: 'categories',
              data: res.items,
              toMap: (e) => e.toJson())
          .catchError((e) => null);
      return Right(res);
    } on NetworkException {
      return await _productsLocalDatasource
          .getAll<CategoryModel>(
            (params, params.paginationParams),
            collection: 'categories',
            fromMap: CategoryModel.fromJson,
          )
          .then<Either<Failure, DataPagination<Category>>>((res) => Right(res))
          .catchError(
            (e, _) => Left<Failure, DataPagination<Category>>(
                Failure.fromExceptionOrFailure(e)),
          );
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
