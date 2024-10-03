import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/views/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/views/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({super.key, required this.state, required this.loadData});
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;
  final VoidCallback Function(WidgetRef ref) loadData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: regularProductHeight,
      child: buildStateAwareChild(
        asyncValue: state(ref),
        addPageMargine: true,
        onRety: loadData(ref),
        child: ListView.separated(
          cacheExtent: 1,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          padding:
              const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
          itemCount: calculatePaginationItemCount(state(ref)),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: ViewConsts.seperatorSize),
          itemBuilder: (_, i) => buildPaginatedListItem(
            loadData: loadData(ref),
            asyncValue: state(ref),
            index: i,
            onDataBuilder: (data) {
              return ProductWidget(data: data);
            },
            onErrorBuilder: (err) => ErrorCard(
              width: regularProductWidth,
              error: err,
              onRety: loadData(ref),
            ),
            onLoadingBuilder: (i) => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
