import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/buisness/core/interfaces/usecase.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp implements FutureUseCase<User, SignUpParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call(SignUpParams params) async =>
      _authRepository.signUp(params);
}

class SignInGoogle implements FutureUseCase<User, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call([NoParams? params]) async =>
      _authRepository.signInGoogle();
}

class SignIn implements FutureUseCase<User, SignInParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call(SignInParams params) async =>
      _authRepository.signIn(params);
}

class SignInAsGuest implements FutureUseCase<User, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<AuthenticationFailure, User>> call([NoParams? params]) async =>
      _authRepository.signInAsGuest();
}

class Logout implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    return _authRepository.logOut();
  }
}

class AuthStateChanges implements StreamUseCase<User?, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Stream<Either<Failure, User?>> call([NoParams? params]) {
    return _authRepository.stateChanges;
  }
}

class AuthLinkedProviders implements UseCase<List<AuthProviderType>, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Either<Failure, List<AuthProviderType>> call([NoParams? params]) {
    return _authRepository.linkedProviders();
  }

}

class UpdateAuthEmail implements FutureUseCase<Unit, UpdateAuthEmailParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(UpdateAuthEmailParams params) {
    return _authRepository.updateUserEmail(params, sl());
  }
}

class UpdateAuthPhoneNumber implements FutureUseCase<Unit, String> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return _authRepository.updateUserPhoneNumber(params, sl());
  }
}

class UpdateAuthLanguageCode implements FutureUseCase<Unit, String> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return _authRepository.updateUserLanguage(params, sl());
  }
}

class GetAuthUser implements UseCase<User, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Either<Failure, User> call([NoParams? params]) {
    return _authRepository.currentUser;
  }
}

class SetupAuthentication implements FutureUseCase<Unit, NoParams> {
  final AuthRepository _authRepository = sl();

  @override
  Future<Either<Failure, Unit>> call([NoParams? params]) {
    return _authRepository.setupAuthentication();
  }
}
