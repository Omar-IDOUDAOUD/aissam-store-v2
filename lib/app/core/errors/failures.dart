import 'package:aissam_store_v2/core/exceptions.dart';



// TODO: for every failure class, add an error code property to show it to user when this error is happen
class Failure {
  final String message;
  // this can be deleted in prodction
  final Object? error;

  Failure(this.message, [this.error]);

  factory Failure.fromExceptionOrFailure(Object exception,
      [String? elseMessage]) {
    if (exception is Failure) return exception;
    if ([NetworkException, NoCachedDataException]
        .contains(exception.runtimeType)) return NetworkFailure();
    if (exception is Exception2) return Failure(exception.msg, exception.error);
    return Failure(elseMessage ?? 'An unknown error has occurred', exception);
  }


  

  @override
  String toString() {
    return '$message, $error';
  }
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("Intrernet connection is required this time");
}


class ProductNotFoundFailure extends Failure {
  ProductNotFoundFailure() : super('This product is not found or not longer exists!');
}