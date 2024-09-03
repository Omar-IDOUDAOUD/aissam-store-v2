
class CategorySelection {
  final String? parentCategory;
  // final String? searchFor;
  String? subCategoryName;
  int? subCategoryIndex;

  CategorySelection(
      {
        // this.searchFor,
      required this.parentCategory,
      this.subCategoryName,
      this.subCategoryIndex});

  void setSubCategory({required String name, required int index}) {
    subCategoryName = name;
    subCategoryIndex = index;
  }

  void unsetSubCategory() {
    subCategoryName = subCategoryIndex = null;
  }

  bool get hasSubCategory => subCategoryIndex != null;
}