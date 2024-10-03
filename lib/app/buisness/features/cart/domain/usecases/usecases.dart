import 'package:aissam_store_v2/app/buisness/features/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/domain/repositories/cart_repository.dart';
import 'package:aissam_store_v2/app/buisness/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/buisness/core/interfaces/usecase.dart';

class GetCart
    implements FutureUseCase<DataPagination<CartItem>, DataPaginationParams> {
  @override
  Future<Either<Failure, DataPagination<CartItem>>> call(
      DataPaginationParams params) {
    return sl<CartRepository>().cart(params);
  }
}

class AddToCart implements FutureUseCase<Unit, AddAndModifyCartItemParams> {
  @override
  Future<Either<Failure, Unit>> call(AddAndModifyCartItemParams params) {
    return sl<CartRepository>().addItem(params);
  }
}

class RemoveCartItems implements FutureUseCase<Unit, List<String>> {
  @override
  Future<Either<Failure, Unit>> call(List<String> itemsIds) {
    return sl<CartRepository>().removeItem(itemsIds);
  }
}

class IncrementCartItemQuantity implements FutureUseCase<Unit, String> {
  @override
  Future<Either<Failure, Unit>> call(String id) {
    return sl<CartRepository>().incrementQuantity(id);
  }
}

class DecrementCartItemQuantity implements FutureUseCase<Unit, String> {
  @override
  Future<Either<Failure, Unit>> call(String id) {
    return sl<CartRepository>().decrementQuantity(id);
  }
}

class ModifyCartItemQ
    implements FutureUseCase<Unit, AddAndModifyCartItemParams> {
  @override
  Future<Either<Failure, Unit>> call(AddAndModifyCartItemParams params) {
    return sl<CartRepository>().saveModifications(params);
  }
}
