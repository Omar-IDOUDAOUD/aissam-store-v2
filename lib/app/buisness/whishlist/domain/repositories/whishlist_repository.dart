import 'package:aissam_store_v2/app/buisness/whishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

abstract class WishlistRepository {
  Future<Either<Failure, DataPagination<WishlistItem>>> wishlist(
      DataPaginationParams params);
  Either<Failure, Unit> addItem(String id);
  Either<Failure, Unit> deleteItems(List<String> ids);
}
