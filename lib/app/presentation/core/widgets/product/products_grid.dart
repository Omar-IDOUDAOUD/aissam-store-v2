import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsGride extends ConsumerWidget {
  const ProductsGride({
    super.key,
    required this.state,
    required this.loadData,
  });
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;
  final VoidCallback Function(WidgetRef ref) loadData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildStateAwareChild(
      asyncValue: state(ref),
      onRety: loadData(ref),
      addPageMargine: false,
      isSliver: true,
      height: 300,
      child: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: ViewConsts.seperatorSize,
          crossAxisSpacing: ViewConsts.seperatorSize,
          mainAxisExtent: regularProductHeight,
        ),
        itemCount: calculatePaginationItemCount(state(ref)),
        itemBuilder: (_, i) => buildPaginatedListItem(
          loadData: loadData(ref),
          asyncValue: state(ref),
          index: i,
          onDataBuilder: (data) {
            return ProductWidget(data: data);
          },
          onErrorBuilder: (err) {
            return ErrorCard(
              error: err,
              onRety: loadData(ref),
            );
          },
          onLoadingBuilder: (i) => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
