import 'dart:async';

abstract   class DisposableService {
  FutureOr<void> dispose() {}
}

abstract class ServiceLifecycle extends DisposableService {
  FutureOr<Object?> init() {
    return null;
  }
}
