import 'package:flutter/material.dart';

abstract class ViewConsts {

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationDuration2 = Duration(milliseconds: 600);
  static const Duration snackbarDuration =
      Duration(seconds: 1, milliseconds: 500);
  static const Duration restoreSnackbarDuration = Duration(seconds: 10);
  static const Curve animationCurve = Curves.linearToEaseOut;
  static const double pagePadding = 20;
  static const double radius = 6;
  static const double toolbarHeight = 66;
  static const double appBarExpandHeight = 150;
  static const double buttonHeight = 54;
  static const double chipHeight = 40;
  static const double seperatorSize = 10;
}
