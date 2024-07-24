import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/search/local_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/search/remote_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/search_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/products_usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<SearchProductsParams>>> history() async {
    try {
      final res = await _localDataSource.history();
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> popularSuggestions() async {
    try {
      final res = await _remoteDataSource.suggestions();
      _localDataSource.cachePopularSuggestions(res);
      return right(res);
    } catch (e) {
      try {
        final res = await _localDataSource.popularSuggestions();
        return Right(res);
      } catch (e) {
        return Left(Failure.fromExceptionOrFailure(e));
      }
    }
  }

  @override
  Future<Either<Failure, List<PopularProductSearchType>>>
      popularProducts() async {
    try {
      final res = await _remoteDataSource.popularProducts();
      _localDataSource.cachePopularProducts(res);

      return right(res);
    } catch (e) {
      try {
        final res = await _localDataSource.popularProducts();
        return Right(res);
      } catch (e) {
        return Left(Failure.fromExceptionOrFailure(e));
      }
    }
  }

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> searchProducts(
      SearchProductsParams params) async {
    try {
      final res = await _remoteDataSource.searchProducts(params);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSuggestions(String terms) async {
    try {
      final res = await _remoteDataSource.suggestions(terms);
      return right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductDetails>> product(String id) async {
    try {
      final either = await Product().call(id);
      final res = either.fold((l) => throw l, (r) => r);
      _remoteDataSource.markFirstProductClick(id).catchError((_) => null);
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> handleSuggestionClick(String terms) async {
    try {
      await _remoteDataSource.markSeachSuggestionClick(terms);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToHistory(
      SearchProductsParams params) async {
    try {
      await _localDataSource.saveHistory(params);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteHistoryItem(int index) async {
    try {
      await _localDataSource.deleteHistoryItem(index);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(e));
    }
  }
}
