
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';

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