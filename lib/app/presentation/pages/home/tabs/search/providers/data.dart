import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/search_usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularSearchedProductsProvider =
    FutureProvider<List<PopularProductSearchType>>((ref) async {
  final res = await PopularSearchedProducts().call();

  return res.fold(
    (err) {
      throw err;
    },
    (res) {
      return res;
    },
  );
});

final historyProvider =
    FutureProvider<List<SearchProductFilterParams>>((ref) async {
  final res = await SearchHistory().call();

  return res.fold(
    (err) {
      throw err;
    },
    (res) {
      return res;
    },
  );
});

final suggestionsProvider =
    FutureProvider.family<List<String>, String>((ref, arg) async {
  final res = await SearchSuggestions().call(arg);

  return res.fold(
    (err) {
      throw err;
    },
    (res) {
      return res;
    },
  );
});

final resultsProvider = AsyncNotifierProviderFamily<_ResultsProvider,
    List<ProductPreview>, SearchProductFilterParams>(_ResultsProvider.new);

class _ResultsProvider extends FamilyAsyncNotifier<List<ProductPreview>,
    SearchProductFilterParams> {
  late final SearchProductFilterParams _filters;
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<ProductPreview>> build(SearchProductFilterParams args) async {
    _filters = args;
    await loadData();
    return state.requireValue;
  }

  Future<void> loadData() async {
    
    if (state.isLoading && state.hasValue) return;
    if (!_dataPaginationParams.hasNextPage) return;
    state = const AsyncValue.loading();
    final res = await SearchProducts().call(
      SearchProductsParams(
        filterParams: _filters,
        paginationParams: _dataPaginationParams,
      ),
    );
    res.fold((err) {
      state = AsyncValue.error(err, StackTrace.empty);
    }, (res) {
      state = AsyncValue.data(((state.valueOrNull ?? [])..addAll(res.items)));
      _dataPaginationParams = res.params;
    });
  }
}
