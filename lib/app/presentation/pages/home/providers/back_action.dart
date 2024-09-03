import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backEventProvider = ChangeNotifierProvider<Notifier>(Notifier.new);

class Notifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  Notifier(this.ref);

  Function()? _backEvent;

  Function()? get backEvent => _backEvent;

  set backEvent(Function()? value) {
    _backEvent = value;
    notifyListeners();
  }
}
