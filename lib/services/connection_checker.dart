import 'dart:async';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker extends ServiceLifecycle {
  final Connectivity _connectivity = Connectivity();
  late final Stream<bool> _changesListener;
  late final StreamSubscription<bool> _stateListener;

  late bool _currentState;
  bool get currentState {
    return _currentState;
  }

  StreamSubscription<bool> subscribeToChanges(
      Function(bool connectionState) handeData) {
    return _changesListener.listen(handeData);
  }

  @override
  Future<ConnectionChecker> init() async {
    final initialConState = await _connectivity.checkConnectivity();
    _currentState = initialConState.last != ConnectivityResult.none;
    _changesListener = _connectivity.onConnectivityChanged
        .map((conStates) => conStates.last != ConnectivityResult.none);
    _stateListener = _changesListener.listen((conState) {
      _currentState = conState;
    });
    return this;
  }

  void checkConnection() {
    if (!currentState) throw const NetworkFailure();
  }

  @override
  FutureOr<void> dispose() {
    _stateListener.cancel();
  }
}
