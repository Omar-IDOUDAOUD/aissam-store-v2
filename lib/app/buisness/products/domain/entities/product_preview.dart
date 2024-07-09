class ProductPreview {
  final String id;
  final String name;
  final List<String> categories;
  final double price;
  final double averageRating;
  final int sales;

  ProductPreview({
    required this.id,
    required this.name,
    required this.categories,
    required this.price,
    required this.averageRating,
    required this.sales,
  });
  @override
  String toString() =>
      'ProductPreview(id: $id, name: $name, categories: $categories, price: $price, averageRating: $averageRating, sales: $sales)';
}