import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/addresses.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/payment.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:dartz/dartz.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  @override
  Future<Either<Failure, int>> count() {
    // TODO: implement count
    throw UnimplementedError();
  }
}
