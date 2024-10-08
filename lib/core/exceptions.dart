class Exception2 {
  final String msg;
  final Object? error;

  const Exception2({required this.msg, this.error});
  @override
  String toString() {
    return 'Exception2: $msg, error = $error';
    
  }
}

class NetworkException extends Exception2 {
  NetworkException([Object? error])
      : super(msg: 'Internet connection is required', error: error);
}

class NoCachedDataException extends Exception2 {
  NoCachedDataException([Object? error])
      : super(
            msg: 'No cached data avaialbe currently, or it might expired',
            error: error);
}
