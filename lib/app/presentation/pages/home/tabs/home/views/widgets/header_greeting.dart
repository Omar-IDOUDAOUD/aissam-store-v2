import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class HeaderGreating extends StatefulWidget {
  const HeaderGreating({super.key});

  @override
  State<HeaderGreating> createState() => _HeaderGreatingState();
}

class _HeaderGreatingState extends State<HeaderGreating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22.5,
            backgroundColor: Colors.blue,
          ),
          const SizedBox.square(
            dimension: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcom back!',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.theme.colors.s,
                  ),
                ),
                Text(
                  'Yass!',
                  style: context.textTheme.displaySmall,
                ),
              ],
            ),
          ),
          const Icon(FluentIcons.alert_24_regular),
        ],
      ),
    );
  }
}
