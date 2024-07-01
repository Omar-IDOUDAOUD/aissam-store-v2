
import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/usecase/usecase.dart';
import 'package:aissam_store_v2/service_locator.dart';

class SignUpParams {
  final String email;
  final String password; 
  final String username;

  SignUpParams({required this.email, required this.password, required this.username}); 
}

class SignUpUsecase implements UseCase<AuthUser, SignUpParams> {
  final AuthRepository _authRepository = sl();
  
  @override
  Future<Either<AuthenticationFailure, AuthUser>> call(SignUpParams params)async => _authRepository.signUp(params.email, params.password, params.username);
}



class SignInParams {
  final String email;
  final String password; 

  SignInParams({required this.email, required this.password}); 

}

class SignInUsecase implements UseCase<AuthUser, SignInParams> {
  final AuthRepository _authRepository = sl();
  
  @override
  Future<Either<AuthenticationFailure, AuthUser>> call(SignInParams params) async => _authRepository.signIn(params.email, params.password);
}


class LogoutUsecase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository = sl();
 
  
  @override
  Future<Either<Failure, void>> call(NoParams params)async {
    await _authRepository.logOut();
    return const Right(null); 
  } 
  
 }


class AuthStateChangesUsecase implements UseCase<Stream<AuthUser?>, NoParams> {
  final AuthRepository _authRepository = sl();
  
  
  @override
  Future<Either<Failure, Stream<AuthUser?>>> call(NoParams params) async {
    return Right(_authRepository.stateChanges); 
  }
}