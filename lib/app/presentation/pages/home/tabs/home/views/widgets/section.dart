import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_list.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsSection extends ConsumerWidget {
  const ProductsSection({
    super.key,
    required this.onDiscoverAllClick,
    required this.title,
    required this.state,
    required this.loadData,
  });
  final String title;
  final VoidCallback onDiscoverAllClick;
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;
  final VoidCallback Function(WidgetRef) loadData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SectionTitle(
          title: title,
          onDiscoverAllClick: onDiscoverAllClick,
        ),
        const SizedBox(height: 12),
        ProductsList(
          state: state,
          loadData: loadData,
        ),
      ],
    );
  }
}
