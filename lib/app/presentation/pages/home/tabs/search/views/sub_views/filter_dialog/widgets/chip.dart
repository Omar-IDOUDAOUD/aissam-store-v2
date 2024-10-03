import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class Chip2 extends StatelessWidget {
  const Chip2({
    super.key,
    required this.label,
    required this.onRemove,
    this.leadingColor,
  });
  final String label;
  final VoidCallback onRemove;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ViewConsts.chipHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          border: Border.all(color: context.theme.colors.t, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            if (leadingColor != null)
              CircleAvatar(
                radius: 12,
                backgroundColor: leadingColor,
              ),
            const SizedBox(width: 5),
            Text(
              label,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                onRemove();
              },
              child: Icon(
                FluentIcons.subtract_24_regular,
                color: context.theme.colors.p,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
