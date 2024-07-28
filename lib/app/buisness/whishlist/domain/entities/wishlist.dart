import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';

class WishlistItem {
  final String? id;
  final DateTime createdAt;
  ProductPreview? productPreview;

  WishlistItem({
    this.id,
    required this.createdAt,
    this.productPreview,
  });
}
