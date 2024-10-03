class AddAndModifyCartItemParams {
  final String? itemId;
  final String? productId;
  final int quantity;
  final String color;
  final String size;

  AddAndModifyCartItemParams({
    this.itemId,
    this.productId,
    required this.quantity,
    required this.color,
    required this.size,
  });
}
