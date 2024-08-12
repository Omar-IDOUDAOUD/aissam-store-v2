import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart' show ObjectId;

class ProductDetailsModel extends ProductDetails {
  ProductDetailsModel({
    required super.id,
    required super.title,
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
    required super.discountPercent,
    required super.discountExpirationDate,
  });
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json,
          [ProductPreview? productPreview]) =>
      ProductDetailsModel(
        id: productPreview?.id ?? (json['_id'] as ObjectId).toJson(),
        title: productPreview?.title ?? json['name'],
        categories:
            productPreview?.categories ?? List<String>.from(json['categories']),
        price: productPreview?.price ?? (json['price']as num).toDouble(),
        averageRating: productPreview?.averageRating ?? (json['average_rating']as num).toDouble(),
        image: productPreview?.averageRating ?? json['image'],
        reviewCount: (json['review_count'] as num).toInt(),
        views: (json['views'] as num).toInt(),
        sales: (json['sales'] as num).toInt(),
        createdAt: json['created_at'],
        description: json["description"],
        sizes: List<String>.from(json["sizes"]),
        availableColorsNames: List<String>.from(json["available_colors"]),
        material: json["material"],
        stockQuantity: (json["stock_quantity"] as num).toInt(),
        isAvailable: json["is_available"],
        images: List<String>.from(json["image_urls"]),
        discountPercent: (json['discount_percent'] as num).toInt(),
        discountExpirationDate: json['discount_exp_date'],
      );

  Map<String, dynamic> toCacheJson() => {
        '_id': id,
        'name': title,
        'categories': categories,
        'price': price,
        'average_rating': averageRating,
        'review_count': reviewCount,
        'views': views,
        'sales': sales,
        'created_at': createdAt,
        'description': description,
        'sizes': sizes,
        'available_colors': availableColorsNames,
        'material': material,
        'stock_quantity': stockQuantity,
        'is_available': isAvailable,
        'image_urls': images,
        'image': image,
      };
  factory ProductDetailsModel.fromCache(Map<String, dynamic> json,
      [ProductPreview? productPreview]) {
    json['_id'] = ObjectId.fromHexString(json['_id']);
    return ProductDetailsModel.fromJson(json, productPreview);
  }
}
