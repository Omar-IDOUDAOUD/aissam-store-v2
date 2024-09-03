import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.child, this.onPressed, this.padding});
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding,
      onPressed: onPressed,
      color: context.theme.colors.t,
      textColor: context.theme.colors.p,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      child: child,
    );
  }
}
