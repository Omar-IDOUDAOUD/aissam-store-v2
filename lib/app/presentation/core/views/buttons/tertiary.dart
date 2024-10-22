import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:flutter/material.dart';

 
 
class TertiaryButton extends StatelessWidget {
  const TertiaryButton(
      {super.key, this.onPressed, required this.child, this.padding});
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return _RawButton(
      isRoundedButton: false,
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }
}

class TertiaryRoundedButton extends StatelessWidget {
  const TertiaryRoundedButton(
      {super.key, this.onPressed,this.prefix, required this.label, this.padding});

  final VoidCallback? onPressed;
  final String label;
  final Widget? prefix;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return _RawButton(
      isRoundedButton: true,
      onPressed: onPressed,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          if (prefix != null) ...[prefix!,const SizedBox(width: 5)], 
          Text(label)
        ]
      ),
    );
  }
}

class _RawButton extends StatelessWidget {
  const _RawButton(
      {required this.isRoundedButton,
      required this.child,
      this.onPressed,
      this.padding});

  final bool isRoundedButton;
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
   final color = context.theme.scaffoldBackgroundColor;
    final borderColor = context.theme.colors.t;
    final borderRadius =  BorderRadius.circular(isRoundedButton ? 25 :  ViewConsts.radius);
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 5,
      borderRadius: borderRadius,
      shadowColor: Colors.black.withOpacity( .2),
      child: MaterialButton(
        height: isRoundedButton ? ViewConsts.chipHeight : ViewConsts.buttonHeight,
        padding: padding,
        color: color,
        textColor: context.theme.colors.p,
        onPressed: onPressed ?? () {},
        highlightColor: borderColor,
        splashColor: Color.lerp(Colors.black, borderColor, 0.8),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: ViewConsts.borderSideWidth,
            color: borderColor,
          ),
          borderRadius: borderRadius,
        ),
        elevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        child: child,
      ),
    );
  }
}
