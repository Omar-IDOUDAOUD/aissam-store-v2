import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';

class ProductDetailsModel extends ProductDetails {
  ProductDetailsModel({
    required super.id,
    required super.name,
    required super.categories,
    required super.price,
    required super.averageRating,
    required super.reviewCount,
    required super.views,
    required super.sales,
    required super.createdAt,
    required super.description,
    required super.sizes,
    required super.availableColorsNames,
    required super.material,
    required super.stockQuantity,
    required super.isAvailable,
    required super.images, 
    required super.image,
  });
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json,
          [ProductPreview? productPreview]) =>
      ProductDetailsModel(
        id: productPreview?.id ?? (json['_id'] as ObjectId).toJson(),
        name: productPreview?.name ?? json['name'],
        categories:
            productPreview?.categories ?? List<String>.from(json['categories']),
        price: productPreview?.price ?? json['price'],
        averageRating: productPreview?.averageRating ?? json['average_rating'],
        image: productPreview?.averageRating ?? json['image'],
        reviewCount: json['review_count'],
        views: json['views'],
        sales: json['sales'],
        createdAt: json['created_at'],
        description: json["description"],
        sizes: List<String>.from(json["sizes"]),
        availableColorsNames: List<String>.from(json["available_colors"]),
        material: json["material"],
        stockQuantity: json["stock_quantity"],
        isAvailable: json["is_available"],
        images: List<String>.from(json["image_urls"]),
      );
}
