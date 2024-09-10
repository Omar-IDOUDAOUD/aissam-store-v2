import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_info.dart';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar.large(
      pinned: true,
      titleSpacing: 8,
      expandedHeight: ViewConsts.appBarExpandHeight,
      title: Row(
        children: [
          const SizedBox(width: 50),
          const Spacer(),
          Text(
            'Profile & settings',
            style: context.theme.appBarTheme.titleTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.search_24_regular),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        collapseMode: CollapseMode.pin,
        // title: Text('hello'),
        background: Column(
          children: [
            SizedBox(
              height: ViewConsts.toolbarHeight,
              child: Center(
                child: Text(
                  'Profile & settings',
                  style: context.theme.appBarTheme.titleTextStyle,
                ),
              ),
            ),
            Spacer(),
            const MainInfoSection(),
          ],
        ),
      ),
    );
  }
}
