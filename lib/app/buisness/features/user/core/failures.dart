import 'package:aissam_store_v2/core/failure.dart';

class NoUserLoggedInFailure extends Failure {
  const NoUserLoggedInFailure(super.code)
      : super(message: 'No User logged in');
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(super.code)
      : super(message: 'User is not found');
}

class UserNotLoadedFailure extends Failure {
  const UserNotLoadedFailure(super.code)
      : super(message: 'User not loaded yet!');
}

class EmailAlreadyExistedFailure extends Failure {
  const EmailAlreadyExistedFailure(super.code, String email)
      : super(message: 'The email $email is already existed');
}
