import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/providers.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section_title.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/tabs.dart';
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
        ScrollNotificationListener(
          listener: ref.read(categoriesProvider(null).notifier).loadData,
          child: Tabs(
            onSelect: (index) {
              setState(
                () {
                  if (index == 0)
                    _selectedTitle = null;
                  else{
                    _selectedTitle =
                        watch.valueOrNull?.elementAtOrNull(index - 1)?.name;
                     if (_selectedTitle != null)   widget.onChangeCategory(_selectedTitle!); 
                        }
                },
              );
          

            },
            labels: (watch.valueOrNull?.map((e) => e.name).toList()
                  ?..insert(0, 'All')) ??
                [],
            extraLabels: watch.isLoading
                ? [
                    const TabLoading(),
                    const TabLoading(),
                    const TabLoading(),
                    const TabLoading(),
                  ]
                : null,
          ),
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
                    child: ProductsSection(
                      onDiscoverAllClick: widget.onDiscoverAllproductsClick,
                      title: _selectedTitle!,
                      state: (ref) => ref
                          .watch(productsByCategoriesProvider(_selectedTitle!)),
                      loadData: (ref) => ref
                          .read(productsByCategoriesProvider(_selectedTitle!)
                              .notifier)
                          .loadData,
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
