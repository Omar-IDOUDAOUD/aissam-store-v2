
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/providers/data.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/selection.dart';

class CartAppbar extends ConsumerWidget {
  const CartAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref
        .watch(cartSelectionsProvider.select((state) => state.selections));
    return SliverAppBar(
      pinned: true,
      title: const Text('My Cart'),
      leadingWidth: MediaQuery.sizeOf(context).width * 0.3,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: ViewConsts.pagePadding),
          child: Text.rich(
            TextSpan(
              children: [
                if (selections.isNotEmpty) ...[
                  TextSpan(
                    text: selections.length.toString(),
                    style: context.textTheme.displayMedium,
                  ),
                  TextSpan(
                    text: ' selected',
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: context.theme.colors.s),
                  )
                ] else ...[
                  TextSpan(
                    text: '100',
                    style: context.textTheme.displayMedium,
                  ),
                  TextSpan(
                    text: ' items',
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: context.theme.colors.s),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: ref.read(cartSelectionsProvider.notifier).unselectAll,
          icon: Icon(
            selections.isEmpty
                ? FluentIcons.cart_24_regular
                : FluentIcons.dismiss_24_regular,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
