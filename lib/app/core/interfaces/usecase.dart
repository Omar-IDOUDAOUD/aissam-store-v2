import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

abstract interface class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract interface class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams{}
