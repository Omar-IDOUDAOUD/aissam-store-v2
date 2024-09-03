import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_grid.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/tabs.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/back_action.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/fab.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/utils/extentions/list_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ResultsView extends ConsumerStatefulWidget {
  const ResultsView({super.key});

  @override
  ConsumerState<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends ConsumerState<ResultsView> {
  late final ScrollController _scrollController =
      ref.read(viewProvider).scrollController;
  // late final Ref _refOnDispose;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_showBackToTopScrollListener);
      // ref.read(backEventProvider).backEvent = () {
      //   ref.read(viewProvider).searchFocus();
      // };
      // _refOnDispose = ref.read(backEventProvider).ref;
    });
  }

  void _showBackToTopScrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      ref.read(fabProvider).fabEvent ??= FabEvent.backToTop(() {
        _scrollController.animateTo(
          0,
          duration: const Duration(seconds: 1),
          curve: ViewConsts.animationCurve,
        );
      });
    } else {
      ref.read(fabProvider).fabEvent = null;
    }
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _refOnDispose.read(backEventProvider.notifier).backEvent = null;
    //   _refOnDispose.read(fabProvider).fabEvent = null;
    // });
    _scrollController.removeListener(_showBackToTopScrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters =
        ref.watch(viewProvider.select((value) => value.searchFilters));

    return MultiSliver(
      children: [
        _Tabs(
          initialTab:
              ref.read(viewProvider.notifier).searchFilters.performance.index,
          onSelectTab: (performance) {
            ref.read(viewProvider.notifier).searchFilters = filters.copyWith(
                performance: performance ?? ProductsPerformance.best_sellers);
          },
        ),
        SliverPadding(
          padding:
              const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
          sliver: ProductsGride(
            loadData: (ref) =>
                ref.read(resultsProvider(filters).notifier).loadData,
            state: (ref) => ref.watch(resultsProvider(filters)),
          ),
        )
      ],
    );
  }
}

class _Tabs extends ConsumerWidget {
  const _Tabs({super.key, required this.onSelectTab, required this.initialTab});
  final int initialTab;
  final Function(ProductsPerformance? performanceType) onSelectTab;

  final labels = ProductsPerformance.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ScrollNotificationListener(
        listener: ref.read(categoriesProvider(null).notifier).loadData,
        child: Tabs(
          initialSelectedTab: initialTab,
          onSelect: (index) {
            onSelectTab(labels[index]);
          },
          labels: labels.map((element) => element.toString()).toList(),
        ),
      ),
    );
  }
}
