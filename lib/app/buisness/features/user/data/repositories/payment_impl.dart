import 'package:aissam_store_v2/app/buisness/features/user/data/data_source/payment/remote.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/payment.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _datasource;

  PaymentRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, int>> countCards() async {
    try {
      final resp = await _datasource.countCards();
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-1542', e));
    }
  }
}
