import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:flutter/material.dart';





class Title2 extends StatelessWidget {
  const Title2({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.fromLTRB(ViewConsts.pagePadding, 15, ViewConsts.pagePadding, 5),
        sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge,
            ),
            if (icon != null)
            Icon(
              icon!,
              color: context.theme.colors.s,
              size: 22,
            )
          ],
        ),
      ),
    );
  }
}
