import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/core/views/product/products_grid.dart';

import 'package:aissam_store_v2/app/presentation/core/views/product/products_list.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Products extends StatelessWidget {
  const Products({
    super.key,
    required this.useGrideProductsFormat,
    this.parentCategory,
  });

  final bool useGrideProductsFormat;
  final String? parentCategory;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: parentCategory == null
          ? const SliverToBoxAdapter(child: SizedBox.shrink())
          : useGrideProductsFormat
              ? SliverPadding(
                  key: ValueKey(parentCategory),
                  padding: const EdgeInsets.symmetric(
                      horizontal: ViewConsts.pagePadding),
                  sliver: ProductsGride(
                    loadData: (ref) => ref
                        .read(productsByCategoriesProvider(parentCategory!)
                            .notifier)
                        .loadData,
                    state: (ref) => ref
                        .watch(productsByCategoriesProvider(parentCategory!)),
                  ),
                )
              : SliverToBoxAdapter(
                  key: ValueKey(parentCategory),
                  child: ProductsList(
                    state: (ref) => ref
                        .watch(productsByCategoriesProvider(parentCategory!)),
                    loadData: (ref) => ref
                        .read(productsByCategoriesProvider(parentCategory!)
                            .notifier)
                        .loadData,
                  ),
                ),
    );
  }
}
