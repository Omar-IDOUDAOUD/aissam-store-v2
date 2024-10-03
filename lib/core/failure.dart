

class Failure {
  final String code;
  final String? message;
  final Object? error;
  StackTrace get stackTrace => StackTrace.current;

  const Failure(this.code, {this.message, this.error});

  factory Failure.fromExceptionOrFailure(String code, Object error,
      [String? elseMessage]) {
    if (error is Failure) return error;
    if ([NetworkFailure, NoCachedDataFailure].contains(error.runtimeType))
      return const NetworkFailure();
    return Failure(code,
        message: elseMessage ?? 'An unknown error has occurred',
        error: error.toString());
  }

  @override
  String toString() {
    return 'code: $code, $message, $error';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('E-1001', message: "Intrernet connection is required this time");
}

class NoCachedDataFailure extends Failure {
  const NoCachedDataFailure()
      : super('E-1002', message: 'No cached data available');
}

class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure()
      : super('E-1003',
            message: 'This product is not found or not longer exists!');
}