import 'package:equatable/equatable.dart';

class CartItem {
  final String? id;
  final String productId;
  final String productTitle;
  final double productPrice;
  final int quantity;
  final String color;
  final String size;
  final int? discountPercent;
  final DateTime? discountExpirationDate;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime lastDataUpdate;
  CartItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.color,
    required this.size,
    required this.discountPercent,
    required this.discountExpirationDate,
    required this.createdAt,
    required this.modifiedAt,
    required this.lastDataUpdate,
  });
}
