import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/user.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/buisness/core/interfaces/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;

class LoadUser implements FutureUseCase<Unit, NoParams> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, Unit>> call([NoParams? params]) async {
    return await _userRepository.loadUser();
  }
}

class CreateUser implements FutureUseCase<Unit, User> {
  final UserRepository _userRepository = sl();
  @override
  Future<Either<Failure, Unit>> call(User newUser) async {
    
    return _userRepository.createUser(newUser);
  }
}

class CreateUserAfterAuth implements FutureUseCase<Unit, CreateUserAfterAuthParams> {
  final UserRepository _userRepository = sl();
  @override
  Future<Either<Failure, Unit>> call(CreateUserAfterAuthParams params) async {
    return _userRepository.createUserFromAuth(params);
  }
}

class GetUser implements UseCase<User, NoParams> {
  final UserRepository _userRepository = sl();

  @override
  Either<Failure, User> call([NoParams? params]) {
    return _userRepository.getUser();
  }
}

class GetPublicUser implements FutureUseCase<User, String> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, User>> call(String userId) {
    return _userRepository.getPublicUser(userId);
  }
}

class UpdateUser implements FutureUseCase<Unit, UpdateUserParams> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(UpdateUserParams params) {
    return _userRepository.updateUser(params, sl());
  }
}

class DeleteUser implements FutureUseCase<Unit, String> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(String userId) {
    return _userRepository.deleteUser();
  }
}


class UserChanges implements StreamUseCase<User, NoParams> {
  final UserRepository _userRepository = sl();
  
  @override
  Stream<Either<Failure, User>> call([NoParams? params])=>_userRepository.userChanges();
  

  
}