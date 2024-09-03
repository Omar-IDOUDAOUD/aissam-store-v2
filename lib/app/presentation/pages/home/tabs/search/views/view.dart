import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/back_action.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'sub_views/history.dart';
import 'sub_views/results.dart';
import 'sub_views/suggestions.dart';
import 'widget/app_bar.dart';
import 'widget/search_textfield.dart';

class SearchTab extends ConsumerStatefulWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab> {
  Ref? _refForDispose;

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refForDispose?.read(backEventProvider.notifier).backEvent = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(viewProvider.select((value) => value.viewState),
        (previous, next) async {
      if (!mounted) return;
      final delayDur = ViewConsts.animationDuration2 + Durations.short1;
      final provider = ref.read(backEventProvider);
      _refForDispose ??= provider.ref;
      if (next.isInitial && previous != null) {
        await Future.delayed(delayDur);
        provider.backEvent = null;
      } else if ((next.isSearching || next.isSearching) && previous != null) {
        await Future.delayed(delayDur);
        provider.backEvent = () {
          ref.read(viewProvider).clear();
        };
      } else if (next.isResults && previous != null) {
        await Future.delayed(delayDur);
        provider.backEvent = () {
          ref.read(viewProvider).searchFocus();
        };
      }
    });
    return CustomScrollView(
      controller: ref.read(viewProvider).scrollController,
      cacheExtent: 1,
      slivers: [
        const Appbar(),
        const SearchTextField(),
        SliverAnimatedSwitcher(
          duration: ViewConsts.animationDuration2,
          child: _buildCurrentView(
              ref.watch(viewProvider.select((value) => value.viewState))),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: _buildHeightForRequiredSpace(context)),
        ),
      ],
    );
  }

  double _buildHeightForRequiredSpace(BuildContext context) {
    return MediaQuery.sizeOf(context).height -
        ViewConsts.toolbarHeight -
        ViewConsts.appBarExpandHeight;
  }

  Widget _buildCurrentView(ViewStates state) {
    return switch (state) {
      ViewStates.initial => const HistoryView(),
      ViewStates.showSuggestions => const SuggestionsView(),
      ViewStates.results => const ResultsView(),
    };
  }
}
