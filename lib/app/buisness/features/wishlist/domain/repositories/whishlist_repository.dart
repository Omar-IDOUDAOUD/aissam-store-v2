import 'package:aissam_store_v2/app/buisness/features/wishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, DataPagination<WishlistItem>>> wishlist(
      DataPaginationParams params);
  Either<Failure, Unit> addItem(String id);
  Either<Failure, Unit> deleteItems(List<String> ids);
}
