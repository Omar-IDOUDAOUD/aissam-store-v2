import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/providers/providers.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/appbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/cart_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/widgets/selection_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Add items count (app bar leading text)

class CartTab extends StatefulWidget {
  CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 20; i++) {
    //   AddToCart().call(
    //   AddAndModifyCartItemParams(
    //     quantity: i,
    //     color: 'color $i',
    //     size: 'M',
    //     productId: "669fcfeae621d399bd14dc39",
    //   ),
    // ).then((v){
    //   print(v.toString());
    // });
    // }
    return Stack(
      children: [
        const Positioned.fill(child: _Content()),
        Consumer(
          builder: (context, ref, child) {
            return AnimatedPositioned(
              duration: ViewConsts.animationDuration2,
              curve: ViewConsts.animationCurve,
              bottom: ref.watch(
                      cartSelectionsProvider.select((state) => state.isEmpty))
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
    final selections = ref.watch(cartSelectionsProvider);
    print('build _content');
    return ScrollNotificationListener(
      listener: ref.read(cartProvider.notifier).loadData,
      child: CustomScrollView(
        slivers: [
          const CartAppbar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: ViewConsts.pagePadding, vertical: 10),
            sliver: SliverList.builder(
              itemCount: buildPaginationListCount(ref.watch(cartProvider)),
              itemBuilder: (context, index) {
                return buildPaginationListItem(
                  asyncValue: ref.watch(cartProvider),
                  index: index,
                  onData: (data) => CartCard(
                    index: index,
                    deSelectOnTap: selections.isNotEmpty,
                    doCloseAnimation:
                        ref.watch(cartDeletedItemsProvider).contains(index),
                    seleted: selections.contains(index),
                    onSelect: (select) {
                      if (select)
                        ref
                            .read(cartSelectionsProvider.notifier)
                            .update((state) => List.from(state..add(index)));
                      else
                        ref
                            .read(cartSelectionsProvider.notifier)
                            .update((state) => List.from(state..remove(index)));
                    },
                  ),
                  onError: (err) {
                    return Text(err.toString());
                  },
                  onLoading: (_) {
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
