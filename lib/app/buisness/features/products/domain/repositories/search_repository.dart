import 'package:aissam_store_v2/app/buisness/features/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/core/data_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<String>>> popularSuggestions();
  Future<Either<Failure, List<PopularProductSearchType>>> popularProducts();
  Future<Either<Failure, List<SearchProductFilterParams>>> history();
  Future<Either<Failure, DataPagination<ProductPreview>>> searchProducts(
      SearchProductsParams params);
  Future<Either<Failure, List<String>>> getSuggestions(String terms);
  Future<Either<Failure, ProductDetails>> product(String id);

  Future<Either<Failure, Unit>> handleSuggestionClick(String terms);
  Future<Either<Failure, Unit>> addToHistory(SearchProductsParams params);

  Future<Either<Failure, Unit>> deleteHistoryItem(int index);
}
