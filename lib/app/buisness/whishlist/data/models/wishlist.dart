import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/whishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/core/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistItemModel extends WishlistItem {
  final String productId;
  ProductPreviewModel? productPreviewModel; 

  
  WishlistItemModel({
    super.id,
    required super.createdAt,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'product_id': productId,
    };
  }

  factory WishlistItemModel.fromJson(Map2 json) {
    return WishlistItemModel(
      id: json['product_id'],
      createdAt: ['created_at'] as DateTime,
      productId: json['product_id'],
    );
  }

  factory WishlistItemModel.fromFirestore(DocumentSnapshot<Map2> doc, _) {
    return WishlistItemModel(
      id: doc.id,
      createdAt: (doc.data()!['created_at'] as Timestamp).toDate(),
      productId: doc.data()!['product_id'],
    );
  }
}
