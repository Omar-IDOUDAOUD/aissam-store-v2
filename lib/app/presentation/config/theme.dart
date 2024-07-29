import 'package:aissam_store_v2/app/presentation/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeBuilder {
  final Brightness brightness;
  ThemeBuilder({required this.brightness});

  late final AppColors colors =
      brightness == Brightness.light ? AppColorsLight() : AppColorsDark();

  final double buttonHight = 54;
  final double toolbarHight = 66;
  final double radius = 66;
  late final BorderRadius borderRadius = BorderRadius.circular(radius);

  late final TextStyle _textStyleBase = TextStyle(
    fontFamily: 'poppins',
    color: colors.d,
    height: 1.3,
  );
  late final TextTheme textTheme = TextTheme(
    displaySmall: _textStyleBase.copyWith(fontSize: 11),
    displayMedium: _textStyleBase.copyWith(fontSize: 14),
    displayLarge: _textStyleBase.copyWith(fontSize: 16),
    bodySmall: _textStyleBase.copyWith(fontSize: 18),
    bodyMedium: _textStyleBase.copyWith(fontSize: 20),
    bodyLarge: _textStyleBase.copyWith(fontSize: 22),
    titleSmall: _textStyleBase.copyWith(fontSize: 25),
    titleMedium: _textStyleBase.copyWith(fontSize: 28),
    titleLarge: _textStyleBase.copyWith(fontSize: 32),
  );
  late final AppBarTheme appBarTheme = AppBarTheme(
    color: colors.b,
    elevation: 18,
    shadowColor: Colors.black87,
    toolbarHeight: toolbarHight,
    centerTitle: true,
    iconTheme: const IconThemeData(size: 33),
  );

  late final IconThemeData iconTheme = IconThemeData(
    size: 24,
    color: colors.b,
  );

  late final EdgeInsets _buttonPadding =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 5);

  late final ButtonThemeData primaryButtonStyle = ButtonThemeData(
    height: buttonHight,
    buttonColor: colors.d,
    padding: _buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
  );

  late final ButtonThemeData secondaryButtonStyle = ButtonThemeData(
    height: buttonHight,
    buttonColor: colors.t,
    padding: _buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: colors.t,
        width: 1.5,
      ),
    ),
  );

  late final ButtonThemeData tertiaryButtonStyle = ButtonThemeData(
    height: buttonHight,
    buttonColor: Colors.transparent,
    padding: _buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: colors.t,
        width: 1.5,
      ),
    ),
  );

  late final DialogTheme dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    backgroundColor: colors.b,
    elevation: 20,
    shadowColor: Colors.black87,
    insetPadding: const EdgeInsets.all(20),
    // titleTextStyle: textTheme.
  );
  late final CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    elevation: 18,
  );


  late final ThemeData buildThemeData = ThemeData(
    primaryColor: colors.p,
    cardTheme: cardTheme,
    cardColor: colors.b,
    focusColor: Color.lerp(colors.d, colors.b, 0.8),
    indicatorColor: colors.d,
    dialogBackgroundColor: colors.b,
    scaffoldBackgroundColor: colors.b,
    appBarTheme: appBarTheme,
    dialogTheme: dialogTheme,
  );

  static ThemeData buildLightTheme() {
    final theme = ThemeBuilder(brightness: Brightness.light);
    return theme.buildThemeData;
  }

  // static ThemeData buildDarkTheme() {
  //   final theme = ThemeBuilder(brightness: Brightness.dark);
  //   return theme.buildThemeData;
  // }
}
