


import 'package:aissam_store_v2/app/core/errors/exceptions.dart';

class NoUserAvailableException extends Exception2{
  NoUserAvailableException() : super(msg: 'No user available');
}

class UserNotFoundException extends Exception2{
  UserNotFoundException() : super(msg: 'User is not found');
}


class UserNotLoadedException extends Exception2{
  UserNotLoadedException() : super(msg: 'User not loaded yet!');
}



