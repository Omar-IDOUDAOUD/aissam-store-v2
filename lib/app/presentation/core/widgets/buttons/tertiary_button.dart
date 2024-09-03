import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({super.key, required this.child, this.padding, this.onPressed});
  final VoidCallback? onPressed; 
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      padding: padding,
      color: Colors.transparent,
      textColor: context.theme.colors.p,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ViewConsts.radius),
        side: BorderSide(
          width: 2,
          color: context.theme.colors.t,
        ),
      ),
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      child: child,
    );
  }
}
