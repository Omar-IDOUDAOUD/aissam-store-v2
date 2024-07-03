import 'package:aissam_store_v2/app/core/errors/exceptions.dart';

class Failure {
  final String message;
  // this can be deleted in prodction
  final Object? error;

  Failure(this.message, [this.error]);

  factory Failure.fromException(Object exception, [String? elseMessage]) {
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
