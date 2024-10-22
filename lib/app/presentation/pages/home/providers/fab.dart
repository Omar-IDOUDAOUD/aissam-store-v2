import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fabProvider = ChangeNotifierProvider<Notifier>(Notifier.new);

class FabEvent {
  final IconData icon; 
  final VoidCallback? onPressed;

  FabEvent({required this.icon, this.onPressed});

  factory FabEvent.backToTop(VoidCallback onBack) {
    return FabEvent(icon: FluentIcons.chevron_up_24_regular, onPressed: onBack);
  }
}



class Notifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  Notifier(this.ref);

  FabEvent? _fabEvent;

  FabEvent? get fabEvent => _fabEvent;

  set fabEvent(FabEvent? value) {
    _fabEvent = value;
    notifyListeners();
  }
}
