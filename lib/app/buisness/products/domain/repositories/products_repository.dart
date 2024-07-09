import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failure, DataPagination<Category>>> categories(
      GetCategoriesParams params);
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByPerformance(
      GetProductByPerformanceParams params);
  Future<Either<Failure, DataPagination<ProductPreview>>> productsByCategory(
      GetProductsByCategoryParams params);
  Future<Either<Failure, DataPagination<ProductPreview>>> searchProducts(
      SearchProductsParams params);
  Future<Either<Failure, ProductDetailsModel>> product(String id);
 
      
}
