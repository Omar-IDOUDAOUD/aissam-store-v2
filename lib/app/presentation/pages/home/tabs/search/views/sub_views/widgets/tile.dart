import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class Tile2 extends StatelessWidget {
  const Tile2({super.key, required this.icon, required this.label,required this.onPressed});
  final String label;
  final IconData icon;
  final VoidCallback onPressed; 

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            icon,
            color: context.theme.colors.s,
            size: 25,
          ),
        ],
      ),
    );
  }
}
