import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/usecase/usecase.dart';

class CreateUserParams {
  late final User newUser;

  CreateUserParams({required this.newUser});
}

class GetUserParams {
  final String userId;
  GetUserParams({required this.userId});
}

class UpdateUserParams {
  late final User updatedUser;

  UpdateUserParams({required this.updatedUser});
}

class DeleteUserParams {
  final String userId;

  DeleteUserParams({required this.userId});
}

class LoadUser implements FutureUseCase<Unit, NoParams> {
  final UserRepository _userRepository=sl();
  
  @override
  Future<Either<Failure, Unit>> call([NoParams? params]) async {
    return await  _userRepository.loadUser();
  }
}

class CreateUser implements FutureUseCase<Unit, CreateUserParams> {
    final UserRepository _userRepository = sl();
  @override
  Future<Either<Failure, Unit>> call(CreateUserParams params) async {
    return _userRepository.createUser(params.newUser);
  }
}

class GetUser implements UseCase<User, NoParams> {
  final UserRepository _userRepository = sl();

  @override
  Either<Failure, User> call([NoParams? params]) {
    return _userRepository.getUser();
  }
}

class GetPublicUser implements FutureUseCase<User, GetUserParams> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, User>> call(GetUserParams params) {
    return _userRepository.getPublicUser(params.userId);
  }
}

class UpdateUser implements FutureUseCase<User, UpdateUserParams> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) {
    return _userRepository.updateUser(params.updatedUser);
  }
}

class DeleteUser implements FutureUseCase<Unit, DeleteUserParams> {
  final UserRepository _userRepository = sl();

  @override
  Future<Either<Failure, Unit>> call(DeleteUserParams params) {
    return _userRepository.deleteUser();
  }
}
