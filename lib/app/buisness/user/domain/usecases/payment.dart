import 'package:aissam_store_v2/app/buisness/user/domain/repositories/payment.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';

class CountPaymentCards implements FutureUseCase<int, NoParams> {
  final PaymentRepository _repo = sl();

  @override
  Future<Either<Failure, int>> call([NoParams? params]) async {
    return await _repo.countCards();
  }
}

