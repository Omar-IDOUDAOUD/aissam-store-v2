import 'package:aissam_store_v2/app/buisness/user/domain/repositories/payment.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<Either<Failure, int>> countCards() {
    throw UnimplementedError();
  }
}
