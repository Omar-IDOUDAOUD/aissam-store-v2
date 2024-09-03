import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip(
      {super.key,
      required this.label,
      required this.selected,
      required this.onPressed});
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        height: ViewConsts.chipHeight,
        duration: ViewConsts.animationDuration,
        curve: ViewConsts.animationCurve,
        decoration: BoxDecoration(
          color: selected ? context.theme.colors.d : Colors.transparent,
          borderRadius: BorderRadius.circular(ViewConsts.chipHeight / 2),
          border: Border.all(
            color: selected ? Colors.transparent : context.theme.colors.t,
            width: 2,
          ),
          boxShadow: !selected
              ? null
              : [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(selected ? 0 : 0.05),
                  )
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            widthFactor: 0,
            child: Text(
              label,
              style: context.textTheme.bodyMedium!.copyWith(
                color:
                    selected ? context.theme.colors.a : context.theme.colors.p,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
