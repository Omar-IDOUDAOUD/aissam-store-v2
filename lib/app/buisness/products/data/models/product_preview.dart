import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:mongo_dart/mongo_dart.dart';

class ProductPreviewModel extends ProductPreview {
  ProductPreviewModel({
    required super.id,
    required super.name,
    required super.categories,
    required super.price,
    required super.averageRating, 
    required super.sales, 
  });

  factory ProductPreviewModel.fromFirestore(
      fs.DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
    final json = snapshot.data()!;
    return ProductPreviewModel(
      id: snapshot.id,
      name: json["name"],
      categories: List.from(json["categories"]),
      price: json["price"],
      averageRating: json["average_rating"],
      sales: json["sales"],
    );
  }

  factory ProductPreviewModel.fromJson(Map<String, dynamic> json) {
    return ProductPreviewModel(
      id: (json["_id"] as ObjectId).toJson(),
      name: json["name"],
      categories: List.from(json["categories"]),
      price: json["price"],
      averageRating: json["average_rating"],

      sales: json["sales"],
    );
  }
  static  List<String> get fields => ['name', 'categories', 'price', 'average_rating', 'review_count', 'views', 'sales', 'created_at'];  

  
}
