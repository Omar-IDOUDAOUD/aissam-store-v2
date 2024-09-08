import 'dart:async';

import 'package:aissam_store_v2/app/buisness/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/user/data/data_source/user_datasource.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:aissam_store_v2/utils/extentions/string.dart';
import 'package:aissam_store_v2/utils/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl(this._userDataSource);

  @override
  Future<Either<Failure, Unit>> loadUser() async {
    try {
      await _userDataSource.loadUser();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9860', e));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUser(User user) async {
    try {
      await _userDataSource.createUser(UserModel.fromEntity(user));
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9861', e, "Error while creating user"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    try {
      await _userDataSource.deleteUser();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9862', e, "Error while deleting user"));
    }
  }

  @override
  Future<Either<Failure, User>> getPublicUser(String userId) async {
    try {
      final resp = await _userDataSource.getPublicUser(userId);
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9863', e, "Error while getting user"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(
      UpdateUserParams params, ConnectionChecker connectionChecker) async {
    try {
      connectionChecker.checkConnection();

      if (params.email?.isEmail == false) throw InvalidEmailFailure('E-2563');
      if (params.phoneNumber?.isPhoneNumber == false)
        throw InvalidPhoneNumberFailure('E-2564');

      await UpdateAuthUser().call(UpdateAuthUserParams(
        languageCode: params.languageCode,
        email: params.email,
        phoneNumber: params.phoneNumber,
        // photoUrl: params.photoUrl,
      ));

      await _userDataSource.updateUser(params);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9864', e, "Error while updating user"));
    }
  }

  @override
  Either<Failure, User> getUser() {
    try {
      return Right(_userDataSource.getUser());
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9865', e, 'Error while getting current user'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUserFromAuth(fb.User authUser) {
    return createUser(
      UserModel(
        id: authUser.uid,
        displayName: authUser.displayName ?? 'Guest-${generateRandomString(5)}',
        authInfo: authUser.isAnonymous
            ? null
            : AuthInfo(
                email: authUser.email,
                phoneNumber: authUser.phoneNumber,
              ),
        photoUrl: authUser.photoURL,
      ),
    );
  }
}
