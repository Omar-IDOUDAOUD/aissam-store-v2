




class Category {
  final String id; 
  final String name;
  final String imageUrl;
  final String? parentCategory; 

  Category({required this.id,  required this.name, required this.imageUrl, this.parentCategory});


    @override
  String toString() => 'Category(id: $id, name: $name, imageUrl: $imageUrl, parentCategory: $parentCategory)';

}



void fonctionX(){
  // get data from server
  final dataFromServer = Object; 

  var listOfCaegories = [
    dataFromServer.first , dataFromServer.second ,  dataFromServer.third
  ] ; 

  // show result to user
}