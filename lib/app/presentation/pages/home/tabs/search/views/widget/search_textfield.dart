import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/sub_views/filter_dialog/view.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({super.key});

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  bool _showBackIcon = false;

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(viewProvider);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            ViewConsts.pagePadding, 15, ViewConsts.pagePadding, 0),
        child: TextField(
          controller: provider.searchInputController,
          focusNode: provider.searchFocusNode,
          style: context.textTheme.bodyLarge,
          onChanged: (str) {
            provider.onSearchTextEdit(str);
          },
          onTap: provider.searchFocus,
          onSubmitted: (_) => provider.searchSubmit(),
          decoration: InputDecoration(
            hintText: 'Search for clothes',
            prefixIcon: const Icon(FluentIcons.search_24_regular),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final filtersAvailable = ref.watch(viewProvider
                        .select((value) => !value.searchFilters.isEmpty));
                    return Stack(
                      children: [
                        IconButton(
                          tooltip: 'filters',
                          onPressed: _showFilterDialog,
                          icon: const Icon(FluentIcons.filter_24_regular),
                          visualDensity: VisualDensity.compact,
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        if (filtersAvailable)
                          Positioned(
                            top: 5,
                            right: 4,
                            child: CircleAvatar(
                              backgroundColor: context.theme.colors.d,
                              radius: 4,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.mic_24_filled),
                  visualDensity: VisualDensity.compact,
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() async {
    final newFilters = await showGeneralDialog<SearchProductFilterParams>(
      transitionDuration: ViewConsts.animationDuration2,
      context: context,
      barrierDismissible: true,
      barrierLabel: 'filter-dialog',
      barrierColor: Colors.black26,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final an = CurvedAnimation(
          parent: animation,
          curve: ViewConsts.animationCurve,
          reverseCurve: ViewConsts.animationCurve.flipped,
        );
        final scaleAn = an.drive(Tween(begin: 0.95, end: 1.0));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
          child: FadeTransition(
            opacity: an,
            child: ScaleTransition(
              scale: scaleAn,
              child: child,
            ),
          ),
        );
      },
      pageBuilder: (context, an1, an2) {
        return FilterDialog(
          filters: ref.read(viewProvider).searchFilters.copyWith(),
        );
      },
    );
    if (newFilters != null) {
      print('seteee');
      ref.read(viewProvider).searchFilters = newFilters;
    }
  }
}
