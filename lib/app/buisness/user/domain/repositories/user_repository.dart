import 'dart:async';

import 'package:aissam_store_v2/app/buisness/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;


abstract interface class UserRepository {
  Future<Either<Failure, Unit>> loadUser(); 
  Future<Either<Failure, Unit>> createUser(User user);
  Future<Either<Failure, Unit>> createUserFromAuth(fb.User user);
  Future<Either<Failure, User>> getPublicUser(String userId);
  Either<Failure, User> getUser();
  Future<Either<Failure, Unit>> updateUser(UpdateUserParams params, ConnectionChecker connectionChecker);
  Future<Either<Failure, Unit>> deleteUser();
}
