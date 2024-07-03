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
  Future<Either<Failure, Unit>> createUser(User user) async {
    try {
       await _userDataSource.createUser(UserModel.fromEntity(user));
      return const Right(unit);
    } catch (e) {
      return Left(Failure("error while creating user",e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(String userId) async {
    try {
       await _userDataSource.deleteUser(userId);
      return const Right(unit);
    } catch (e) {
      return Left(Failure("error while deleting user",e));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final resp = await _userDataSource.getUser(userId);
      return Right(resp);
    } catch (e) {
      return Left(Failure("error while getting user", e));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
       try {
      final resp = await _userDataSource.updateUser(UserModel.fromEntity(user));
      return Right(resp);
    } catch (e) {
      return Left(Failure("error while getting user", e));
    }
  }
}
