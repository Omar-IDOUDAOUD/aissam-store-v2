import 'dart:ui';

abstract class AppColors {
  // Hexadecimal to Decimal converted used: https://www.checkyourmath.com/convert/color/hexadecimal_decimal.php

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
  Color get d => Color.fromARGB(255, 70, 150, 115);

  @override
  Color get p => Color.fromARGB(255, 48, 60, 50);

  @override
  Color get s => Color.fromARGB(255, 14, 243, 87);

  @override
  Color get t => Color.fromARGB(255, 224, 224, 224);

  @override
  Color get b => Color.fromARGB(255, 246, 246, 246);

  @override
  Color get a => Color.fromARGB(255, 255, 255, 255);
}


class AppColorsDark extends AppColors {
  @override
  Color get a => throw UnimplementedError();

  @override
  Color get b => throw UnimplementedError();

  @override
  Color get d => throw UnimplementedError();

  @override
  Color get p => throw UnimplementedError();

  @override
  Color get s => throw UnimplementedError();

  @override
  Color get t => throw UnimplementedError();
}
