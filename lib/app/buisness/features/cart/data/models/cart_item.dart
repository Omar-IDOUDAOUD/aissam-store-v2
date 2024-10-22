import 'package:aissam_store_v2/app/buisness/features/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/core/constants.dart';
import 'package:aissam_store_v2/core/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel extends CartItem { 
  CartItemModel(  
      {super.id,
      required super.productId,
      required super.quantity,
      required super.color,
      required super.size,
      required super.discountPercent,
      required super.discountExpirationDate,
      required super.productTitle,
      required super.productPrice,
      required super.createdAt,  
      required super.modifiedAt,
      required super.lastDataUpdate});

  Map<String, dynamic> toFirestore() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'product_title': productTitle,
      'product_price': productPrice,
      'color': color,
      'size': size,
      'discount_percent': discountPercent,
      'discount_exp_date': discountExpirationDate,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'last_data_update': lastDataUpdate
    };
  }

  factory CartItemModel.fromFirestore(DocumentSnapshot<Map2> doc, _) {
    final json = doc.data()!;
    return CartItemModel(
      id: doc.id,
      productId: json['product_id'],
      productTitle: json['product_title'],
      productPrice: json['product_price'],
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
      discountPercent: json['discount_percent'],
      discountExpirationDate: json['discount_exp_date'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
      modifiedAt: (json['modified_at'] as Timestamp).toDate(),
      lastDataUpdate: (json['last_data_update'] as Timestamp).toDate(),
    );
  }

  bool get needDataUpdate => lastDataUpdate
      .add(BuisnessConsts.minimumDataUpdateDuration)
      .isBefore(DateTime.now());
}
