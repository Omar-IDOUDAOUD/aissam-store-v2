
class Failure<ErrorType> {
  final String errorMessage;
  final ErrorType? errorObj;

  Failure(this.errorMessage, [this.errorObj]);

  @override
  String toString() {
    return 'FAILURE: message = "$errorMessage", error = "$errorObj" '; 
  }
}

class NetworkFailure<T> extends Failure<T> {
  NetworkFailure([T? errorObj]) : super( "Intrernet connection is required this time", errorObj);
}

