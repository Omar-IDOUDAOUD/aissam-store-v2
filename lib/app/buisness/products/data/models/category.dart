import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id,
      required super.name,
      required super.imageUrl,
      super.parentCategory});
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: (json['_id'] as ObjectId).toJson(),
        name: json["name"],
        imageUrl: json["image_url"],
        parentCategory: json["parent_category"],
      );
    Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "parent_category": parentCategory,
      };
  
}
