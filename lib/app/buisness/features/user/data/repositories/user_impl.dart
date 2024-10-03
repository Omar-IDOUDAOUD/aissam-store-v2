import 'dart:async';
import 'dart:io';

import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/data/data_source/user/remote.dart';
import 'package:aissam_store_v2/app/buisness/features/user/data/models/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/user.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/buisness/core/constants/constants.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:aissam_store_v2/utils/extentions/string.dart';
import 'package:aissam_store_v2/utils/tools.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;
import 'package:flutter/material.dart';

class UserRepositoryImpl extends ServiceLifecycle implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl(this._userDataSource);

  late final StreamController<Either<Failure, User>>
      _userChangesStreamController;
  late final StreamSubscription<Either<Failure, fb.User?>> _authChangesListener;
  late fb.User _authenticatedUser;

  @override
  UserRepositoryImpl init() {
    _userChangesStreamController = StreamController();

    _authChangesListener = AuthStateChanges().call().listen(
      (event) {
        _notifyUserChanges();
      },
    );
    return this;
  }

  fb.User _getAuthUser() {
    final res = GetAuthUser().call();
    return res.fold(
      (failure) => throw failure,
      (authUser) => authUser,
    );
  }

  @override
  void dispose() {
    _userChangesStreamController.close();
    _authChangesListener.cancel();
  }

  void _notifyUserChanges() {
    _userChangesStreamController.add(getUser());
  }

  @override
  Future<Either<Failure, Unit>> loadUser() async {
    try {
      await _userDataSource.loadUser(_getAuthUser());
      _notifyUserChanges();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure('E-9860', e));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUser(User user) async {
    try {
      await _userDataSource.createUser(UserModel.fromEntity(user));
      await _userDataSource.loadUser(_getAuthUser());
      _notifyUserChanges();
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
      _notifyUserChanges();
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
      // connectionChecker.checkConnection();

      // if (params.email?.isEmail == false) throw InvalidEmailFailure('E-2563');
      // if (params.phoneNumber?.isPhoneNumber == false)
      //   throw InvalidPhoneNumberFailure('E-2564');

      // await UpdateAuthUser().call(UpdateAuthUserParams(
      //   languageCode: params.languageCode,
      //   email: params.email,
      //   phoneNumber: params.phoneNumber,
      //   // photoUrl: params.photoUrl,
      // ));

      await _userDataSource.updateUser(params, _getAuthUser().uid);
      _notifyUserChanges();

      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9864', e, "Error while updating user"));
    }
  }

  @override
  Either<Failure, User> getUser() {
    try {
      final resp = _userDataSource.getUser(_getAuthUser().uid);
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromExceptionOrFailure(
          'E-9865', e, 'Error while getting current user'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUserFromAuth(
      CreateUserAfterAuthParams params) {
    String languageCode = Platform.localeName.contains("_")
        ? Platform.localeName.split("_")[0]
        : Platform.localeName;

    return createUser(
      UserModel(
        id: params.user.uid,
        displayName: params.user.displayName?.isNotEmpty == true
            ? params.user.displayName!
            : 'user-${generateRandomString(5)}',
        authInfo: params.user.isAnonymous
            ? null
            : AuthInfo(
                email: params.user.email,
                phoneNumber: params.user.phoneNumber,
              ),
        photoUrl: params.user.photoURL,
        language: RegionsAndCurrenciesData.lookForLanguage(languageCode)!,
      ),
    );
  }

  @override
  Stream<Either<Failure, User>> userChanges() {
    return _userChangesStreamController.stream;
  }
}
