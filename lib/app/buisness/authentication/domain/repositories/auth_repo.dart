import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {

  Future<Either<AuthenticationFailure, Unit>> signIn(
      String email, String password);
  Future<Either<AuthenticationFailure, AuthUser>> signUp(
      String email, String password, String username);
  Future<Either<Failure, Unit>> logOut();
  Either<Failure, Stream<AuthUser?>> get stateChanges;

}
