import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/views/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/views/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/appbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/cart_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/selection_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selection.dart';

// TODO: Add items count (app bar leading text)

class CartTab extends StatefulWidget {
  const CartTab({super.key});

    

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 100; i++) {
    //   AddToWishlist().call("669fcfeae621d399bd14dc39").then((v) {
    //     print(v.toString());
    //   });
    // }

    return Stack(
      children: [
        const Positioned.fill(child: _Content()),
        Consumer(
          builder: (context, ref, child) {
            return AnimatedPositioned(
              duration: ViewConsts.animationDuration2,
              curve: ViewConsts.animationCurve,
              bottom: ref.watch(cartSelectionsProvider
                      .select((state) => state.selections.isEmpty))
                  ? -100
                  : 0,
              right: 0,
              left: 0,
              child: const SelectionPanel(),
            );
          },
        ),
      ],
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionProvider = ref.watch(cartSelectionsProvider);
    final dataProvider = ref.watch(cartProvider);

    return buildStateAwareChild(
      asyncValue: dataProvider,
      onRety: () => ref.refresh(cartProvider),
      child: CustomScrollView(
        slivers: [
          const CartAppbar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: ViewConsts.pagePadding, vertical: 10),
            sliver: SliverList.builder(
              itemCount: calculatePaginationItemCount(dataProvider),
              itemBuilder: (context, index) {
                return buildPaginatedListItem(
                  loadData: ref.read(cartProvider.notifier).loadData,
                  asyncValue: dataProvider,
                  index: index,
                  onDataBuilder: (data) => CartCard(
                    index: data.id!,
                    doSelectOnTap: selectionProvider.selections.isNotEmpty,
                    state: selectionProvider.buildCardState(index),
                    onSelect: (select) {
                      selectionProvider.select(select, index);
                    },
                  ),
                  onErrorBuilder: (err) {
                    return ErrorCard(
                      error: err,
                      onRety: ref.read(cartProvider.notifier).loadData,
                    );
                  },
                  onLoadingBuilder: (_) {
                    return const CircularProgressIndicator();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
