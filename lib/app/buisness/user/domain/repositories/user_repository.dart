import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

abstract interface class UserRepository {
  Future<Either<Failure, Unit>> createUser(User user);
  Future<Either<Failure, User>> getUser(String userId);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, Unit>> deleteUser(String userId);
}
