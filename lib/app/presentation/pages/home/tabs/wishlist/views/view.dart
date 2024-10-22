import 'package:aissam_store_v2/app/buisness/features/wishlist/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/views/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/views/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/widgets/appbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/widgets/wishlist_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/widgets/selection_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selection.dart';

// TODO: Add items count (app bar leading text)

class WishlistTab extends StatefulWidget {
  const WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
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
              bottom: ref.watch(wishlistSelectionsProvider
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
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionProvider = ref.watch(wishlistSelectionsProvider);
    final dataProvider = ref.watch(wishlistProvider);

    return buildStateAwareChild(
      asyncValue: dataProvider,
      onRety: () => ref.refresh(wishlistProvider),
      child: CustomScrollView(
        slivers: [
          const WishlistAppbar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: ViewConsts.pagePadding, vertical: 10),
            sliver: SliverList.builder(
              itemCount: calculatePaginationItemCount(dataProvider),
              itemBuilder: (context, index) {
                return buildPaginatedListItem(
                  asyncValue: dataProvider,
                  index: index,
                  onDataBuilder: (data) => WishlistItemCard(
                    index: data.id!,
                    doSelectOnTap: selectionProvider.selections.isNotEmpty,
                    state: selectionProvider.buildCardState(index),
                    onSelect: (select) {
                      selectionProvider.select(select, index);
                    },
                  ),
                  loadData: ref.read(wishlistProvider.notifier).loadData,
                  onErrorBuilder: (err) {
                    return ErrorCard(
                      error: err,
                      height: 50,
                      onRety: ref.read(wishlistProvider.notifier).loadData,
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
