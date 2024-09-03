import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/error_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/pagination_loader.dart';

import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../class.dart';
import 'cart.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({
    super.key,
    required this.categorySelection,
    required this.onSelectSubCategory,
  });
  final CategorySelection categorySelection;
  final Function(bool select, CategorySelection? subCategory)
      onSelectSubCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = categoriesProvider(categorySelection.parentCategory);
    final state = ref.watch(provider);
    final isEmpty = state.valueOrNull?.isEmpty == true;
    return AnimatedSize(
      duration: ViewConsts.animationDuration,
      alignment: Alignment.topCenter,
      curve: ViewConsts.animationCurve,
      child: SizedBox(
        height: isEmpty ? 40 : 130,
        child: isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ViewConsts.pagePadding),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ViewConsts.radius),
                        color: Colors.yellow.shade600),
                    child: const Center(child: Text('No more sub categories'))),
              )
            : buildStateAwareChild(
                asyncValue: state,
                addPageMargine: true,
                onRety:()=>ref.refresh(provider), 
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ViewConsts.pagePadding),
                  scrollDirection: Axis.horizontal,
                  cacheExtent: 1,
                  itemCount: calculatePaginationItemCount(state),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ViewConsts.seperatorSize),
                  itemBuilder: (_, index) {
                    return buildPaginatedListItem(
                      loadData: ref.read(provider.notifier).loadData,
                      asyncValue: state,
                      index: index,
                      onDataBuilder: (data) {
                        return CategoryCart(
                          index: index,
                          data: data,
                          onSelectSubCategory: onSelectSubCategory,
                          categorySelection: categorySelection,
                        );
                      },
                      onErrorBuilder: (err) {
                        print('hreeelo');
                        print(err.toString());
                        return ErrorCard(
                          error: err,
                          width: 100,
                          horizontalPadding: 8,
                          showDescription: false,
                          onRety: ref.read(provider.notifier).loadData,
                        );
                      },
                      onLoadingBuilder: (_) => const SizedBox.square(
                          dimension: 40, child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
