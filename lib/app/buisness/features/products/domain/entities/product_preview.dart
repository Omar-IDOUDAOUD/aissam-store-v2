
class ProductPreview {
  final String id;
  final String title;
  final List<String> categories;
  final double price;
  final double averageRating;
  final int sales;
  final String image;

  ProductPreview({
    required this.id,
    required this.image,
    required this.title,
    required this.categories,
    required this.price,
    required this.averageRating,
    required this.sales,
  });
  @override
  String toString() =>
      'ProductPreview(id: $id, name: $title, categories: $categories, price: $price, averageRating: $averageRating, sales: $sales)';
}

typedef PopularProductSearchType = ({String image, String name});
