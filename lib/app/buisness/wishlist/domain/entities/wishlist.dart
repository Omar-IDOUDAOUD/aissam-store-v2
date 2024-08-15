import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
/// TODO: modify wishlist items to be like CartItem entity, add product main info and update theme every unit of time 
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
