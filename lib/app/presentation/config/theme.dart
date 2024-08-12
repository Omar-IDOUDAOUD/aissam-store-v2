import 'package:aissam_store_v2/app/presentation/config/colors.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
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
    bodySmall: _textStyleBase.copyWith(fontSize: 12),
    bodyMedium: _textStyleBase.copyWith(fontSize: 14),
    bodyLarge: _textStyleBase.copyWith(fontSize: 18),
    displaySmall: _textStyleBase.copyWith(fontSize: 22),
    displayMedium: _textStyleBase.copyWith(fontSize: 25),
    displayLarge: _textStyleBase.copyWith(fontSize: 29),
    titleSmall: _textStyleBase.copyWith(fontSize: 34),
  );
  late final AppBarTheme appBarTheme = AppBarTheme(
    toolbarHeight: ViewConsts.toolbarHeight,
    scrolledUnderElevation: 10,
    elevation: 0,
    shadowColor: shadowColor,
    centerTitle: true,
    iconTheme: iconTheme.copyWith(size: 30),
    titleTextStyle: textTheme.displayMedium,
    backgroundColor: WidgetStateColor.resolveWith((states) {
      return states.lastOrNull == WidgetState.scrolledUnder
          ? colors.a
          : colors.b;
    }),
    surfaceTintColor: Colors.transparent,
  );

  late final IconThemeData iconTheme = IconThemeData(
    size: 24,
    color: colors.p,
  );

  late final ButtonThemeData buttonStyle = ButtonThemeData(
    minWidth: ViewConsts.buttonHeight,
    height: ViewConsts.buttonHeight,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
  );
  late final TooltipThemeData tooltipTheme = TooltipThemeData(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colors.d.withOpacity(.8),
    ),
    textStyle: textTheme.bodyMedium!.copyWith(color: Colors.white),
  );

  late final CheckboxThemeData checkboxTheme = CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) => states.lastOrNull == WidgetState.selected
          ? colors.d
          : Colors.transparent,
    ),
    // materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: WidgetStateBorderSide.resolveWith(
      (states) => states.lastOrNull == WidgetState.selected
          ? BorderSide.none
          : BorderSide(
              color: colors.t,
              width: 2,
            ),
    ),
    checkColor: WidgetStateColor.resolveWith(
      (states) => states.lastOrNull == WidgetState.selected
          ? colors.a
          : Colors.transparent,
    ),
  );

  late final DialogTheme dialogTheme = DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      backgroundColor: colors.b,
      elevation: 20,
      shadowColor: Colors.black87,
      insetPadding: const EdgeInsets.all(20),
      titleTextStyle: textTheme.bodySmall);
  late final CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    elevation: 7,
    shadowColor: shadowColor,
    color: colors.a,
    margin: EdgeInsets.zero,
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
    border: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: borderSide.copyWith(color: colors.d),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: borderSide.copyWith(color: Colors.pink),
    ),
  );

  late final ThemeData buildThemeData = ThemeData(
    colorSchemeSeed: colors.d,
    textTheme: textTheme,
    useMaterial3: true,
    cardTheme: cardTheme,
    cardColor: colors.b,
    focusColor: Color.lerp(colors.d, colors.a, 0.85),
    indicatorColor: colors.d,
    dialogBackgroundColor: colors.b,
    scaffoldBackgroundColor: colors.b,
    appBarTheme: appBarTheme,
    dialogTheme: dialogTheme,
    iconTheme: iconTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonStyle,
    checkboxTheme: checkboxTheme,
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
