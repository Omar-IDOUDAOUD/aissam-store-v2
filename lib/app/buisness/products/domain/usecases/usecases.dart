import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class GetCategories
    implements FutureUseCase<DataPagination<Category>, GetCategoriesParams> {
  final ProductsRepository repository = sl();

  @override
  Future<Either<Failure, DataPagination<Category>>> call(
      GetCategoriesParams params) {
    return repository.categories(params);
  }
}

class GetProductsByCategory
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductsByCategoryParams> {
  final ProductsRepository _repository = sl();

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductsByCategoryParams params) {
    return _repository.productsByCategory(params);
  }
}

class GetProductsByPerformance
    implements
        FutureUseCase<DataPagination<ProductPreview>,
            GetProductByPerformanceParams> {
  final ProductsRepository _repository = sl();

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      GetProductByPerformanceParams params) {
    return _repository.productsByPerformance(params);
  }
}

class SearchProducts
    implements
        FutureUseCase<DataPagination<ProductPreview>, SearchProductsParams> {
  final ProductsRepository _repository = sl();

  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      SearchProductsParams params) {
    return _repository.searchProducts(params);
  }
}
