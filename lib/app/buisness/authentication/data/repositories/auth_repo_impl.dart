import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart'
    as userEntity;
import 'package:flutter/material.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  Future<Either<AuthenticationFailure, User>> _createUser(userEntity.User user, User returnRight) async {
    final createUser = await CreateUser().call(CreateUserParams(newUser: user));

    return createUser.fold(
      (failure) => Left(AuthenticationFailure(
          code: 'create-user-failed', errorMessage: failure.message)),
      (_) => Right(returnRight),
    );
  }

  @override
  Future<Either<AuthenticationFailure, User>> signIn(
      String email, String password) async {
    try {
      final user = await _authDataSource.signIn(email, password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthenticationFailure.fromAuthException(e));
    }
  }

  @override
  Future<Either<AuthenticationFailure, User>> signInGoogle() async {
    try {
      final user = await _authDataSource.signInGoogle();
      return await _createUser(
        userEntity.User(
          id: user.uid,
          email: user.email!,
          fullName: user.displayName!,
        ),
        user,
      );
    } on AuthException catch (e) {
      return Left(AuthenticationFailure.fromAuthException(e));
    }
  }

  @override
  Future<Either<AuthenticationFailure, User>> signUp(
      String email, String password, String username) async {
    try {
      final user = await _authDataSource.signUp(email, password, username);
      return await _createUser(
        userEntity.User(
          id: user.uid,
          email: email,
          fullName: username,
        ),
        user,
      );
    } on AuthException catch (e) {
      return Left(AuthenticationFailure.fromAuthException(e));
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
    if (user == null) return Left(Failure('No user found now'));
    return Right(user);
  }
}
