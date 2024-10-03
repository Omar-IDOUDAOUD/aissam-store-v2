import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = ref.watch(viewProvider.select((value) => value.pinAppbar));
    final showBackButton =
        ref.watch(viewProvider.select((value) => value.viewState.isResults));

    return SliverAppBar.large(
      pinned: pin,
      expandedHeight: ViewConsts.appBarExpandHeight,
      leading: showBackButton
          ? IconButton(
              onPressed: ref.read(viewProvider).clear,
              icon: const Icon(FluentIcons.chevron_left_24_regular),
            )
          : null,
      titleSpacing: 8,
      title: Row(
        children: [
          const SizedBox(width: 50),
          const Spacer(),
          Text(
            'Search',
            style: context.theme.appBarTheme.titleTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => ref.read(viewProvider).searchFocus(),
            icon: const Icon(FluentIcons.search_24_regular),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Search',
                  style: context.textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Discover all kinds of thousands of products by hundereds of categories',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.theme.colors.s,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
