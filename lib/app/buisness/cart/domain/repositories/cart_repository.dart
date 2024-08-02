import 'package:aissam_store_v2/app/buisness/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, DataPagination<CartItem>>> cart(
      DataPaginationParams params);
  Future<Either<Failure, Unit>> addItem(AddAndModifyCartItemParams item);
  Future<Either<Failure, Unit>> removeItem(List<String> itemsIds);
  Future<Either<Failure, Unit>> incrementQuantity(String itemId);
  Future<Either<Failure, Unit>> decrementQuantity(String itemId);
  Future<Either<Failure, Unit>> saveModifications(
      AddAndModifyCartItemParams params);
}
