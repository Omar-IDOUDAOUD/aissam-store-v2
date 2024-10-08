import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUp implements FutureUseCase<User, SignUpParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call(
           SignUpParams params) async =>
      _authRepository.signUp(params);
}

class SignInGoogle implements FutureUseCase<User, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call([NoParams? params]) async => _authRepository.signInGoogle();
}


class SignIn implements FutureUseCase<User, SignInParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call(SignInParams params) async => _authRepository.signIn(params);
}

class Logout implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository = sl();


  @override
  Future<Either<Failure, void>> call([NoParams? params])async {
    return _authRepository.logOut();
  }
}

class AuthStateChanges implements UseCase<Stream<User?>, NoParams> {
  final AuthRepository _authRepository = sl();
  
  @override
  Either<Failure, Stream<User?>> call([NoParams? params]) {
    return _authRepository.stateChanges; 
  }
}

class GetAuthUser implements UseCase<User, NoParams> {
  final AuthRepository _authRepository = sl();
  
  @override
  Either<Failure, User> call([NoParams? params]) {
    return _authRepository.currentUser;
  }
  
}