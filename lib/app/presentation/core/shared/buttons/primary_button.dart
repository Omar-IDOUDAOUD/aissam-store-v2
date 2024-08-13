import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.child, this.onPressed});
  final VoidCallback? onPressed; 
  final Widget child; 

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: context.theme.colors.d,
      textColor: Colors.white,
      onPressed: () {},
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      child: child,
      
    );
  }
}