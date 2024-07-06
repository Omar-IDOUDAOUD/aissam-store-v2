import 'dart:async';

import 'package:aissam_store_v2/app/buisness/user/data/data_source/user_data_source.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl(this._userDataSource);

  @override
  Future<Either<Failure, Unit>> loadUser() async {
    try {
      await _userDataSource.loadUser();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUser(User user) async {
    try {
      await _userDataSource.createUser(UserModel.fromEntity(user));
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromException(e, "Error while creating user"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    try {
      await _userDataSource.deleteUser();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.fromException(e, "Error while deleting user"));
    }
  }

  @override
  Future<Either<Failure, User>> getPublicUser(String userId) async {
    try {
      final resp = await _userDataSource.getPublicUser(userId);
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromException(e, "Error while getting user"));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      final resp = await _userDataSource.updateUser(UserModel.fromEntity(user));
      return Right(resp);
    } catch (e) {
      return Left(Failure.fromException(e, "Error while updating user"));
    }
  }

  @override
  Either<Failure, User> getUser() {
    try {
      return Right(_userDataSource.getUser());
    } catch (e) {
      return Left(Failure.fromException(e, 'Error while getting current user'));
    }
  }
}
