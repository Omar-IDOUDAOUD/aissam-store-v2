import 'package:aissam_store_v2/app/buisness/user/domain/repositories/addresses.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/payment.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  @override
  Future<Either<Failure, int>> count() {
    // TODO: implement count
    throw UnimplementedError();
  }
}
