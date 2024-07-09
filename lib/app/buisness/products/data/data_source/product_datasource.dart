import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';

abstract class ProductsDatasource {
  Future<DataPagination<CategoryModel>> categories(GetCategoriesParams params);
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      GetProductByPerformanceParams params);
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params);
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params);
  Future<ProductDetailsModel> product(String id);
}
