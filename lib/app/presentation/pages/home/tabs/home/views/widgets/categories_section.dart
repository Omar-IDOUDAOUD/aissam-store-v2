import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/views/product/products_list.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section_title.dart';
import 'package:aissam_store_v2/app/presentation/core/views/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/core/views/tabs.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesSection extends ConsumerStatefulWidget {
  const CategoriesSection(
      {super.key,
      required this.onChangeCategory,
      required this.onDiscoverAllCategoriesClick,
      required this.onDiscoverAllproductsClick});
  final VoidCallback onDiscoverAllCategoriesClick;
  final VoidCallback onDiscoverAllproductsClick;
  final Function(String category) onChangeCategory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesSectionState();
}

class _CategoriesSectionState extends ConsumerState<CategoriesSection> {
  String? _selectedTitle;

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(categoriesProvider(null));
    return Column(
      children: [
        SectionTitle(
          title: 'Categories',
          onDiscoverAllClick: widget.onDiscoverAllCategoriesClick,
        ),
        const SizedBox(height: 12),
        if (!watch.hasValue && watch.hasError)
          ErrorCard(
            addPageMargine: true,
            error: watch.error!,
            height: ViewConsts.chipHeight,
            onRety: () => ref.refresh(categoriesProvider(null)),
          )
        else
          Tabs(
            onSelect: (index) {
              setState(
                () {
                  if (index == 0)
                    _selectedTitle = null;
                  else {
                    _selectedTitle =
                        watch.valueOrNull?.elementAtOrNull(index - 1)?.name;
                    if (_selectedTitle != null)
                      widget.onChangeCategory(_selectedTitle!);
                  }
                },
              );
            },
            labels: (watch.valueOrNull?.map((e) => TabLabel(text: e.name)).toList()
                  ?..insert(0, TabLabel(text: 'All'))) ??
                [],
            extraLabels: watch.isLoading
                ? const [
                    TabLoading(),
                    TabLoading(),
                    TabLoading(),
                    TabLoading(),
                  ]
                : watch.hasValue
                    ? [
                        _SeeAllCategoriesTab(
                            onTap: widget.onDiscoverAllCategoriesClick)
                      ]
                    : null,
          ),
        AnimatedSize(
          duration: ViewConsts.animationDuration2,
          curve: ViewConsts.animationCurve,
          child: AnimatedSwitcher(
            duration: ViewConsts.animationDuration,
            child: _selectedTitle == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    key: ValueKey(_selectedTitle),
                    child: Column(
                      children: [
                        SectionTitle(
                          onDiscoverAllClick: widget.onDiscoverAllproductsClick,
                          title: _selectedTitle!,
                        ),
                        const SizedBox(height: 12),
                        ProductsList(
                          state: (ref) => ref.watch(
                              productsByCategoriesProvider(_selectedTitle!)),
                          loadData: (ref) => ref
                              .read(
                                  productsByCategoriesProvider(_selectedTitle!)
                                      .notifier)
                              .loadData,
                        ),
                      ],
                    ),
                  ),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _SeeAllCategoriesTab extends StatelessWidget {
  const _SeeAllCategoriesTab({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ViewConsts.chipHeight / 2),
          color: context.theme.colors.a,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Text(
              'see all categories',
              style: context.textTheme.bodyMedium!
                  .copyWith(color: Colors.blueAccent),
            ),
            const SizedBox(width: 5),
            const Icon(FluentIcons.chevron_right_24_regular,
                size: 18, color: Colors.blueAccent),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
