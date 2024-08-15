import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.transparent,
      textColor: context.theme.colors.p,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ViewConsts.radius),
        side: BorderSide(
          width: 2,
          color: context.theme.colors.t,
        ),
      ),
      onPressed: () {},
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      child: child,
    );
  }
}
