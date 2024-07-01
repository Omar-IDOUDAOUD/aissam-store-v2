
class Failure<ErrorType> {
  final String errorMessage;
  final ErrorType? errorObj;

  Failure(this.errorMessage, [this.errorObj]);
}

class NetworkFailure<T> extends Failure<T> {
  NetworkFailure([T? errorObj]) : super( "Intrernet connection is required this time", errorObj);
}

