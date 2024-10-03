import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key, required this.title, required this.onDiscoverAllClick});
  final VoidCallback onDiscoverAllClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: ViewConsts.pagePadding, right: ViewConsts.pagePadding - 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.textTheme.bodyLarge,
            ),
          ),
          MaterialButton(
            onPressed: onDiscoverAllClick,
            height: 25,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Row(
              children: [
                Text(
                  'discover all',
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: context.theme.colors.s),
                ),
                const SizedBox(width: 5),
                Icon(
                  FluentIcons.arrow_right_24_regular,
                  color: context.theme.colors.s,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
