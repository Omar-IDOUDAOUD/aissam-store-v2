import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/formats.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/primary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/secondary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/tertiary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/tabs.dart';
import 'package:aissam_store_v2/config/routing/config.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkAccountWith extends StatelessWidget {
  const LinkAccountWith({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: ViewConsts.chipHeight,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
              horizontal: ViewConsts.pagePadding),
          children: [
            _chip(context, 'Google'),
            const SizedBox(width: 8),
            _chip(context, 'Facebook'),
            const SizedBox(width: 8),
            _chip(context, 'Twitter'),
            const SizedBox(width: 8),
            _chip(context, 'Pintirest'),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    return TertiaryRoundedButton(
      label: label,
      padding: const EdgeInsets.only(left: 7, right: 15),
      prefix: const CircleAvatar(
        radius: 13,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
