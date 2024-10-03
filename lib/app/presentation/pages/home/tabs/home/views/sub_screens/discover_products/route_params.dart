import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverProductsSubScreenParams {
  const DiscoverProductsSubScreenParams(
      {required this.state,
      required this.loadData,
      required this.title,
      required this.description});
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;
  final Function() Function(WidgetRef) loadData;
  final String title;
  final String description;
}
