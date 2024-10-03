import 'dart:ui';

import 'package:flutter/material.dart';

class TextFieldInputBorder extends InputBorder {
  final Color backgroundColor;
  final double radius;
  final double elevation;
  final Color shadowColor;

  const TextFieldInputBorder({
    this.backgroundColor = Colors.transparent,
    this.radius = 8.0,
    this.elevation = 0,
    this.shadowColor = Colors.transparent,
    super.borderSide = const BorderSide(),
  });

  @override
  TextFieldInputBorder copyWith({
    BorderSide? borderSide,
    Color? backgroundColor,
    double? radius,
    double? elevation,
    Color? shadowColor,
  }) {
    return TextFieldInputBorder(
      borderSide: borderSide ?? this.borderSide,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      radius: radius ?? this.radius,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(radius);

  @override
  bool get isOutline => true;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      );
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Draw shadow
    canvas.drawShadow(
      Path()..addRRect(rrect),
      shadowColor,
      elevation,
      true,
    );

    // Draw background color
    final paint = Paint()..color = backgroundColor;
    canvas.drawRRect(rrect, paint);

    // Draw border
    if (borderSide.style == BorderStyle.solid) {
      final borderPaint = Paint()
        ..color = borderSide.color
        ..strokeWidth = borderSide.width
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(rrect, borderPaint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return TextFieldInputBorder(
      borderSide: borderSide.scale(t),
      backgroundColor: backgroundColor,
      radius: radius * t,
      elevation: elevation * t,
      shadowColor: shadowColor,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
            rect.deflate(borderSide.width), Radius.circular(radius)),
      );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TextFieldInputBorder) {
      return TextFieldInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        backgroundColor: Color.lerp(a.backgroundColor, backgroundColor, t)!,
        radius: lerpDouble(a.radius, radius, t)!,
        elevation: lerpDouble(a.elevation, elevation, t)!,
        shadowColor: Color.lerp(a.shadowColor, shadowColor, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TextFieldInputBorder) {
      return TextFieldInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        backgroundColor: Color.lerp(backgroundColor, b.backgroundColor, t)!,
        radius: lerpDouble(radius, b.radius, t)!,
        elevation: lerpDouble(elevation, b.elevation, t)!,
        shadowColor: Color.lerp(shadowColor, b.shadowColor, t)!,
      );
    }
    return super.lerpTo(b, t);
  }
}
