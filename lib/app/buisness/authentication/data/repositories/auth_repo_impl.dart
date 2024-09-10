import 'package:aissam_store_v2/app/buisness/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart'
//     as userEntity;

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  Future<Either<AuthenticationFailure, User>> _createUser(User user) async {
    final createUser = await CreateUserAfterAuth().call(user);
    return createUser.fold(
      (failure) => throw failure,
      (_) => Right(user),
    );
  }

  @override
  Future<Either<AuthenticationFailure, User>> signIn(
      SignInParams params) async {
    try {
      final user = await _authDataSource.signIn(params.email, params.password);
      await LoadUser().call();
      return Right(user);
    } on AuthenticationFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthenticationFailure, User>> signInGoogle() async {
    try {
      final userCreds = await _authDataSource.signInGoogle();
      final user = userCreds.user!;
      if (userCreds.additionalUserInfo?.isNewUser == true) {
        await LoadUser().call();
      } else {
        await _createUser(userCreds.user!);
      }
      return Right(user);
    } on AuthenticationFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        AuthenticationFailure('E-8975',
            message: 'Authentication failed', error: e),
      );
    }
  }

  @override
  Future<Either<AuthenticationFailure, User>> signUp(
      SignUpParams params) async {
    try {
      final user = await _authDataSource.signUp(
          params.email, params.password, params.username);
      return await _createUser(user);
    } on AuthenticationFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthenticationFailure, Unit>> logOut() async {
    await _authDataSource.logOut();
    return const Right(unit);
  }

  @override
  Either<AuthenticationFailure, Stream<User?>> get stateChanges =>
      Right(_authDataSource.stateChanges);

  @override
  Either<Failure, User> get currentUser {
    final user = _authDataSource.currentUser;
    if (user == null) return const Left(NoUserLoggedInFailure('E-9563'));
    return Right(user);
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UpdateAuthUserParams params) async {
    try {
      if (params.email != null)
        await _authDataSource.updateEmail(params.email!);
      if (params.phoneNumber != null)
        await _authDataSource.updatePhoneNumber(params.phoneNumber!);
      if (params.languageCode != null)
        await _authDataSource.updateLanguageCode(params.languageCode!);

      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9636', e, 'Error while updating user'));
    }
  }

  @override
  Future<Either<AuthenticationFailure, User>> signInAsGuest() async {
    try {
      final user = await _authDataSource.signInAnonymously();
      await _createUser(user);
      return Right(user);
    } on AuthenticationFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> setupAuthentication() async {
    try {
      _authDataSource.currentUser;
      await LoadUser().call();
      return const Right(unit);
    } on NoUserLoggedInFailure  {
      final res = await signInAsGuest();
      return res.fold((err) => Left(err), (_) => const Right(unit));
    }
  }
}
