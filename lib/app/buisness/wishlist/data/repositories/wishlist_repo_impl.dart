import 'package:aissam_store_v2/app/buisness/wishlist/data/data_source/wishlist_local_datasource.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/data/data_source/wishlist_remote_datasource.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/data/models/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/domain/repositories/whishlist_repository.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart'; 
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource _wishlistDataSource;
  final WishlistLocalDataSource _localWishlistDataSource;

  WishlistRepositoryImpl(
      this._wishlistDataSource, this._localWishlistDataSource);
  @override
  Either<Failure, Unit> addItem(String id) {
    try {
      _wishlistDataSource.addItem(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9851', e));
    }
  }

  @override
  Either<Failure, Unit> deleteItems(List<String> ids) {
    try {
      _wishlistDataSource.deleteItems(ids);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9852', e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<WishlistItem>>> wishlist(
      DataPaginationParams params) async {
    try {
      final res = await _wishlistDataSource.wishList(params);
      _localWishlistDataSource.cacheWishList(
          params, res.items.map((e) => e.productPreviewModel!).toList());
      return Right(res);
    } on NetworkFailure {
      return await _localWishlistDataSource
          .wishList(params)
          .then<Either<Failure, DataPagination<WishlistItemModel>>>(
            (res) => Right(res),
          )
          .catchError(
            (e, _) => Left<Failure, DataPagination<WishlistItemModel>>(
                Failure.fromExceptionOrFailure('E-9853', e)),
          );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9854', e));
    }
  }
}
