import 'package:aissam_store_v2/core/failure.dart';

class NoUserLoggedInFailure extends Failure {
  const NoUserLoggedInFailure(String code)
      : super(code, message: 'No User logged in');
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(String code)
      : super(code, message: 'User is not found');
}

class UserNotLoadedFailure extends Failure {
  const UserNotLoadedFailure(String code)
      : super(code, message: 'User not loaded yet!');
}

class EmailAlreadyExistedFailure extends Failure {
  const EmailAlreadyExistedFailure(String code, String email)
      : super(code, message: 'The email $email is already existed');
}
