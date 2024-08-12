import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: context.theme.colors.t,
      textColor: context.theme.colors.p,
      onPressed: () {},
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      child: child,
    );
  }
}
