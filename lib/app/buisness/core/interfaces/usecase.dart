import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';

abstract interface class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}


abstract interface class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract interface class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}


class NoParams{}
