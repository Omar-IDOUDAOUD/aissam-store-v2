import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColors extends ThemeExtension<AppColors> {
  // Hexadecimal to Decimal converter used: https://www.checkyourmath.com/convert/color/hexadecimal_decimal.php

  /// app main color
  Color get d;

  /// text color
  Color get p;

  /// primary grey color
  Color get s;

  /// secondary grey color
  Color get t;

  /// backround color
  Color get b;

  /// nav bar color
  Color get a;
}

class AppColorsLight extends AppColors {
  @override
  Color get d => const Color.fromARGB(255, 70, 150, 115);

  @override
  Color get p => const Color.fromARGB(255, 48, 59, 50);

  @override
  Color get s => const Color.fromARGB(255, 151, 151, 151);

  @override
  Color get t => const Color.fromARGB(255, 224, 224, 224);

  @override
  Color get b => const Color.fromARGB(255, 240, 240, 240);

  @override
  Color get a => const Color.fromARGB(255, 255, 255, 255);

  @override
  ThemeExtension<AppColors> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    return this;
  }
}

class AppColorsDark extends AppColors {
  @override
  Color get d => const Color.fromARGB(255, 70, 150, 115);

  @override
  Color get p => const Color.fromARGB(255, 239, 239, 239);

  @override
  Color get s => const Color.fromARGB(255, 143, 143, 143);

  @override
  Color get t => const Color.fromARGB(255, 65, 65, 65);

  @override
  Color get b => const Color.fromARGB(255, 46, 46, 46);

  @override
  Color get a => const Color.fromARGB(255, 20, 20, 20);

  @override
  ThemeExtension<AppColors> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    return this;
  }
}
