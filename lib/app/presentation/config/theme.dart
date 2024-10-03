import 'package:aissam_store_v2/app/presentation/config/colors.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/textfield/input_border.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeBuilder {
  final Brightness brightness;
  ThemeBuilder({required this.brightness});

  late final AppColors colors =
      brightness == Brightness.light ? AppColorsLight() : AppColorsDark();

  final double radius = ViewConsts.radius;
  late final BorderRadius borderRadius = BorderRadius.circular(radius);
  late final BorderSide borderSide = BorderSide(width: 2, color: colors.t);
  final shadowColor = Colors.black.withOpacity(0.2);

  late final TextStyle _textStyleBase = TextStyle(
    fontFamily: 'Poppins',
    color: colors.p,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.3,
  );
  late final TextTheme textTheme = TextTheme(
    bodySmall: _textStyleBase.copyWith(fontSize: 10),
    bodyMedium: _textStyleBase.copyWith(fontSize: 12),
    bodyLarge: _textStyleBase.copyWith(fontSize: 16),
    displaySmall: _textStyleBase.copyWith(fontSize: 18),
    displayMedium: _textStyleBase.copyWith(fontSize: 21),
    displayLarge: _textStyleBase.copyWith(fontSize: 26),
    titleSmall: _textStyleBase.copyWith(fontSize: 30),
  );
  late final AppBarTheme appBarTheme = AppBarTheme(
    toolbarHeight: ViewConsts.toolbarHeight,
    scrolledUnderElevation: 5,
    elevation: 0,
    shadowColor: Colors.black.withOpacity(.4),
    centerTitle: true,
    iconTheme: iconTheme.copyWith(size: 30),
    titleTextStyle: textTheme.displayMedium,
    backgroundColor: WidgetStateColor.resolveWith((states) {
      return states.lastOrNull == WidgetState.scrolledUnder
          ? colors.a
          : colors.a;
    }),
    surfaceTintColor: Colors.transparent,
  );

  late final IconThemeData iconTheme = IconThemeData(
    size: 24,
    color: colors.p,
  );

  late final TooltipThemeData tooltipTheme = TooltipThemeData(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colors.d.withOpacity(.8),
    ),
    textStyle: textTheme.bodyMedium!.copyWith(color: Colors.white),
  );

  late final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.all(17),
    filled: true,
    fillColor: colors.t,
    prefixIconColor: colors.s,
    suffixIconColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.lastOrNull == WidgetState.focused) return colors.p;
        return colors.s;
      },
    ),
    hintStyle: textTheme.bodyLarge!
        .copyWith(color: colors.s, fontWeight: FontWeight.w400),
    border: TextFieldInputBorder(
      backgroundColor: colors.a,
      borderSide:
          BorderSide(width: ViewConsts.borderSideWidth, color: colors.t),
      radius: ViewConsts.radius,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(.2),
    ),
    enabledBorder: TextFieldInputBorder(
      backgroundColor: colors.a,
      borderSide:
          BorderSide(width: ViewConsts.borderSideWidth, color: colors.t),
      radius: ViewConsts.radius,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(.2),
    ),
    focusedBorder: TextFieldInputBorder(
      backgroundColor: colors.a,
      borderSide: BorderSide(width: 2, color: colors.d),
      radius: ViewConsts.radius,
    ),
    errorBorder: TextFieldInputBorder(
      backgroundColor: colors.a,
      borderSide: const BorderSide(width: 2, color: Colors.redAccent),
      radius: ViewConsts.radius,
    ),
    focusedErrorBorder: TextFieldInputBorder(
      backgroundColor: colors.a,
      borderSide: const BorderSide(width: 2, color: Colors.redAccent),
      radius: ViewConsts.radius,
    ),
  );
  late final SnackBarThemeData snackbarTheme = const SnackBarThemeData(
    behavior: SnackBarBehavior.fixed,
  );

  late final ThemeData buildThemeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colors.d,
    textTheme: textTheme,
    focusColor: Color.lerp(colors.d, colors.a, 0.85),
    indicatorColor: colors.d,
    scaffoldBackgroundColor: colors.a,
    dialogBackgroundColor: colors.a,
    snackBarTheme: snackbarTheme,
    appBarTheme: appBarTheme,
    iconTheme: iconTheme,
    inputDecorationTheme: inputDecorationTheme,
    tooltipTheme: tooltipTheme,
    extensions: [
      if (brightness == Brightness.dark) AppColorsDark(),
      if (brightness == Brightness.light) AppColorsLight(),
    ],
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
