import 'package:aissam_store_v2/app/buisness/wishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/domain/repositories/whishlist_repository.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class AddToWishlist implements FutureUseCase<Unit, String> {
  @override
  Future<Either<Failure, Unit>> call(String productId) async {
    final WishlistRepository repository = sl();
    return repository.addItem(productId);
  }
}

class RemoveWishlistItems implements FutureUseCase<Unit, List<String>> {
  @override
  Future<Either<Failure, Unit>> call(List<String> productsIds) async {
    final WishlistRepository repository = sl();
    return repository.deleteItems(productsIds);
  }
}

class GetWishlist
    implements
        FutureUseCase<DataPagination<WishlistItem>, DataPaginationParams> {
  @override
  Future<Either<Failure, DataPagination<WishlistItem>>> call(
      DataPaginationParams params) {
    final WishlistRepository repository = sl();

    return repository.wishlist(params);
  }
}
