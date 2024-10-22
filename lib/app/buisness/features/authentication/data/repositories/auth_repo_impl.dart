import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/core/services/connection_checker.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart'
//     as userEntity;

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  Future<Either<AuthenticationFailure, User>> _createUser(User user) async {
    final createUser =
        await CreateUserAfterAuth().call(CreateUserAfterAuthParams(user: user));
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
  Stream<Either<Failure, User?>> get stateChanges =>
      _authDataSource.stateChanges.map((event) => Right(event));

  @override
  Either<Failure, User> get currentUser {
    try {
      final user = _authDataSource.currentUser;
      return Right(user);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-1542', e));
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
    } on NoUserLoggedInFailure {
      final res = await signInAsGuest();
      return res.fold((err) => Left(err), (_) => const Right(unit));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserEmail(
      UpdateAuthEmailParams params, ConnectionChecker connectionChecker) async {
    try {
      connectionChecker.checkConnection();
      final currentEmail = _authDataSource.currentUser.email!;
      print('Test 2');
      await _authDataSource.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: currentEmail, password: params.password));
      print('Test 3');
      await _authDataSource.updateEmail(params.newEmail);
      print('Test 4');
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' || e.code == 'wrong-password')
        return Left(InvalidPassword('E-3521'));
      return Left(
        Failure.fromExceptionOrFailure(
            'E-3415', e, "Error while updating email!"),
      );
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-3417', e, "Error while updating email!"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserLanguage(
      String langCode, ConnectionChecker connectionChecker) async {
    try {
      connectionChecker.checkConnection();
      await _authDataSource.updateLanguageCode(langCode);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-3515', e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserPhoneNumber(
      String newNumber, ConnectionChecker connectionChecker) async {
    try {
      connectionChecker.checkConnection();
      await _authDataSource.updatePhoneNumber(newNumber);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-3435', e));
    }
  }

  @override
  Either<Failure, List<AuthProviderType>> linkedProviders() {
    try {
      final resp = _authDataSource.linkedProviders();
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-2458', e));
    }
  }
}
