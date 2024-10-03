import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/category.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart' show ObjectId;

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
  Map<String, dynamic> toCacheJson() => {
        '_id': id,
        "name": name,
        "image_url": imageUrl,
        "parent_category": parentCategory,
      };
        factory CategoryModel.fromCache(Map<String, dynamic> json,
      ) {
    json['_id'] = ObjectId.fromHexString(json['_id']);
    return CategoryModel.fromJson(json);
  }
}
