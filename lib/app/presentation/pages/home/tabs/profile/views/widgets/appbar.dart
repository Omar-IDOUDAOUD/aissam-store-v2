import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
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
      expandedHeight: ViewConsts.toolbarHeight+10 + 50,
      title: Row(
        children: [
          const SizedBox(width: 35),
          const Spacer(),
          Text(
            'Profile & settings',
            style: context.theme.appBarTheme.titleTextStyle,
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 15, 
            backgroundColor: Colors.red, 
          )
          , 
          const SizedBox(width: 5)
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        collapseMode: CollapseMode.pin,
        // title: Text('hello'),
        background: Column(
          children: [
            SafeArea(
              child: SizedBox(
              height: ViewConsts.toolbarHeight,
              child: Center(
                child: Text(
                  'Profile & settings',
                  style: context.theme.appBarTheme.titleTextStyle,
                ),
              ),
            ),
            ),
            const Spacer(),
            const MainInfoSection(),
          ],
        ),
      ),
    );
  }
}
