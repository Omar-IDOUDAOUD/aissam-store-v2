import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class Title2 extends StatelessWidget {
  const Title2({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          ViewConsts.pagePadding, 15, ViewConsts.pagePadding, 8),
      child: Text(
        title,
        style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600, color: context.theme.colors.s),
      ),
    );
  }
}
