import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/search_repository.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';

class PopularSearchSuggestions
    implements FutureUseCase<List<String>, NoParams> {
  @override
  Future<Either<Failure, List<String>>> call([NoParams? params]) {
    return sl<SearchRepository>().popularSuggestions();
  }
}

class PopularSearchedProducts
    implements FutureUseCase<List<PopularProductSearchType>, NoParams> {
  @override
  Future<Either<Failure, List<PopularProductSearchType>>> call(
      [NoParams? params]) {
    return sl<SearchRepository>().popularProducts();
  }
}

class SearchHistory
    implements FutureUseCase<List<SearchProductFilterParams>, NoParams> {
  @override
  Future<Either<Failure, List<SearchProductFilterParams>>> call([NoParams? params]) {
    return sl<SearchRepository>().history();
  }
}

class SearchProducts
    implements
        FutureUseCase<DataPagination<ProductPreview>, SearchProductsParams> {
  @override
  Future<Either<Failure, DataPagination<ProductPreview>>> call(
      SearchProductsParams params) {
    return sl<SearchRepository>().searchProducts(params);
  }
}

class SearchSuggestions implements FutureUseCase<List<String>, String> {
  @override
  Future<Either<Failure, List<String>>> call(String terms) {
    return sl<SearchRepository>().getSuggestions(terms);
  }
}

class SearchProductDetails implements FutureUseCase<ProductDetails, String> {
  @override
  Future<Either<Failure, ProductDetails>> call(String id) {
    return sl<SearchRepository>().product(id);
  }
}

class HandleSearchSuggestionClick implements FutureUseCase<Unit, String> {
  @override
  Future<Either<Failure, Unit>> call(String terms) {
    return sl<SearchRepository>().handleSuggestionClick(terms);
  }
}


class AddSearchToHistory implements FutureUseCase<Unit, SearchProductsParams> {
  @override
  Future<Either<Failure, Unit>> call(SearchProductsParams params) {
    return sl<SearchRepository>().addToHistory(params);
  }
}


class DeleteSearchHistory implements FutureUseCase<Unit, int> {
  @override
  Future<Either<Failure, Unit>> call(int index) {
    return sl<SearchRepository>().deleteHistoryItem(index);
  }
}
