import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<AuthenticationFailure, Unit>> signIn(
      String email, String password) async {
    try {
      await _authDataSource.signIn(email, password);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(AuthenticationFailure.fromException(e));
    }
  }

  @override
  Future<Either<AuthenticationFailure, AuthUser>> signUp(
      String email, String password, String username) async {
    try {
      final user = await _authDataSource.signUp(email, password, username);
      
      final createUserResult = await CreateUser().call(CreateUserParams(
          newUser:
              User(id: user.id, email: user.email, fullName: user.fullname)));

    return createUserResult.fold(
      (failure) => Left(AuthenticationFailure(code: 'create-user-failed', message: failure.errorMessage)),
      (_) => Right(user),
    );
    } on AuthException catch (e) {
      return Left(AuthenticationFailure.fromException(e));
    }
  }

  @override
  Future<Either<AuthenticationFailure, Unit>> logOut() async {
    await _authDataSource.logOut();
    return const Right(unit);
  }

  @override
  Either<AuthenticationFailure, Stream<AuthUser?>> get stateChanges =>
      Right(_authDataSource.stateChanges);
}
