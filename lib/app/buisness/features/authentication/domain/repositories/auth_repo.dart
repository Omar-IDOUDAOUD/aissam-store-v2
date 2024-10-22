import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/core/services/connection_checker.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<AuthenticationFailure, User>> signIn(SignInParams params);
  Future<Either<AuthenticationFailure, User>> signInAsGuest();
  Future<Either<AuthenticationFailure, User>> signInGoogle();
  Future<Either<AuthenticationFailure, User>> signUp(SignUpParams params);
  Future<Either<Failure, Unit>> updateUserEmail(UpdateAuthEmailParams params, ConnectionChecker connectionChecker);
  Future<Either<Failure, Unit>> updateUserPhoneNumber(String newNumber, ConnectionChecker connectionChecker);
  Future<Either<Failure, Unit>> updateUserLanguage(String langCode, ConnectionChecker connectionChecker);
  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, Unit>> setupAuthentication();
  Either<Failure, List<AuthProviderType>> linkedProviders();
  Stream<Either<Failure, User?>> get stateChanges;
  Either<Failure, User> get currentUser;

}
