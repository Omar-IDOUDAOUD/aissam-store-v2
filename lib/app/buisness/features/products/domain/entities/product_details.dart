import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';

class ProductDetails extends ProductPreview {
  final String description;
  final List<String> sizes;
  final List<String> availableColorsNames;
  final String material;
  final int stockQuantity;
  final bool isAvailable;
  final List<String> images;
  final int reviewCount;
  final int views;
  final DateTime createdAt;
  final int? discountPercent;
  final DateTime? discountExpirationDate;
  ProductDetails({
    required super.id,
    required super.title,
    required super.categories,
    required super.averageRating,
    required super.price,
    required super.sales,
    required super.image,
    required this.reviewCount,
    required this.description,
    required this.createdAt,
    required this.views,
    required this.sizes,
    required this.availableColorsNames,
    required this.material,
    required this.stockQuantity,
    required this.isAvailable,
    required this.images,
    required this.discountPercent,
    required this.discountExpirationDate,
  });

  @override
  String toString() =>
      'ProductDetails(id: id, name: $title, categories: $categories, price: $price, averageRating: $averageRating, sales: $sales, ...)';
}
