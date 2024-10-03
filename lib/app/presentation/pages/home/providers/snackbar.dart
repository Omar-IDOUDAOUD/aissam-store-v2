import 'dart:math';

import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snackBarProvider = StateProvider<SnackBarEvent?>((ref) => null);

class SnackBarEvent {
  late final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      controller;
  final String message;
  final Widget? content;
  final String? action;
  final VoidCallback? onActionPress;

  final Duration duration;

  SnackBarEvent({
    required this.message,
    this.action,
    this.content,
    this.onActionPress,
    this.duration = ViewConsts.snackbarDuration,
  });
}
