import 'package:aissam_store_v2/app/buisness/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/cart/data/data_source/cart_data_source.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/repositories/cart_repository.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource;

  CartRepositoryImpl(this._cartDataSource);

  @override
  Future<Either<Failure, Unit>> addItem(AddAndModifyCartItemParams item) async {
    try {
      await _cartDataSource.addItem(item);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9870',e));
    }
  }

  @override
  Future<Either<Failure, DataPagination<CartItem>>> cart(
      DataPaginationParams params) async {
    try {
      final res = await _cartDataSource.cart(params);
      final itemsNeedDataUpdate = res.items.where((e) => e.needDataUpdate);
      if (itemsNeedDataUpdate.isNotEmpty)
        _cartDataSource.updateData(
          itemsNeedDataUpdate
              .map((e) => (itemId: e.id!, productId: e.productId))
              .toList(),
        );
      return Right(res);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9871',e));
    }
  }

  @override
  Future<Either<Failure, Unit>> decrementQuantity(String itemId) async {
    try {
      await _cartDataSource.setQuantity(itemId, false);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9872',e));
    }
  }

  @override
  Future<Either<Failure, Unit>> incrementQuantity(String itemId) async {
    try {
      await _cartDataSource.setQuantity(itemId, true);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9873',e));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem(List<String> itemsIds) async {
    try {
      await _cartDataSource.removeItem(itemsIds);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9874',e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveModifications(
      AddAndModifyCartItemParams params) async {
    try {
      await _cartDataSource.saveModifications(params);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9875',e));
    }
  }
}
