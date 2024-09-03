
import 'package:aissam_store_v2/app/presentation/config/colors.dart';
import 'package:flutter/material.dart';




extension AppColorsExtention on ThemeData {
  AppColors get colors => extension<AppColors>()!;
}
extension ThemeExtention on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

}