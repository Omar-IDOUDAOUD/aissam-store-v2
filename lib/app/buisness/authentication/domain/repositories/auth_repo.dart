import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<AuthenticationFailure, User>> signIn(
      SignInParams params);
  Future<Either<AuthenticationFailure, User>> signInGoogle();
  Future<Either<AuthenticationFailure, User>> signUp(
      SignUpParams params);
  Future<Either<Failure, Unit>> logOut();
  Either<Failure, Stream<User?>> get stateChanges;
  Either<Failure, User> get currentUser; 
}