import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
       padding: const EdgeInsets.fromLTRB(
          ViewConsts.pagePadding, 25, ViewConsts.pagePadding, 0),
      sliver: SliverToBoxAdapter(
        child: Text(
          title,
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.theme.colors.s,
          ),
        ),
      ),
    );
  }
}
