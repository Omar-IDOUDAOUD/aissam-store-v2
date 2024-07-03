import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/usecase/usecase.dart';

class CreateUserParams {
  late final User newUser;

  CreateUserParams({ required this.newUser});
}

class CreateUser implements FutureUseCase<Unit, CreateUserParams> {
  final UserRepository _userRepository = sl();
  
  @override
  Future<Either<Failure, Unit>> call(CreateUserParams params) {
    return _userRepository.createUser(params.newUser); 
  }
}

//

class GetUserParams{
  final String userId;

  GetUserParams({required this.userId}); 

}

class GetUser implements FutureUseCase<User, GetUserParams> {
  final UserRepository _userRepository = sl();
  
  @override
  Future<Either<Failure, User>> call(GetUserParams params) {
    return _userRepository.getUser(params.userId); 
  }
}

//

class UpdateUserParams {
  late final User updatedUser;

  UpdateUserParams({ required this.updatedUser});
}

class UpdateUser implements FutureUseCase<User, UpdateUserParams> {
  final UserRepository _userRepository = sl();
  
  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) {
    return _userRepository.updateUser(params.updatedUser); 
  }
}


class DeleteUserParams {
  final String userId;

  DeleteUserParams({ required this.userId});
}

class DeleteUser implements FutureUseCase<Unit, DeleteUserParams> {
  final UserRepository _userRepository = sl();
  
  @override
  Future<Either<Failure, Unit>> call(DeleteUserParams params) {
    return _userRepository.deleteUser(params.userId); 
  }
}

