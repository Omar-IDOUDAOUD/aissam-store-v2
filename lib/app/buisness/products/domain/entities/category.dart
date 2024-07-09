




class Category {
  final String id; 
  final String name;
  final String imageUrl;
  final String? parentCategory; 

  Category({required this.id,  required this.name, required this.imageUrl, this.parentCategory});


    @override
  String toString() => 'Category(id: $id, name: $name, imageUrl: $imageUrl, parentCategory: $parentCategory)';

}