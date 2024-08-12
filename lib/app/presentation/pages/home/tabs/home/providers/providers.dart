import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/products_usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsByPerformanceProvider = AsyncNotifierProviderFamily<
    _ProductsByPerformanceNotifier,
    List<ProductPreview>,
    ProductsPerformance>(_ProductsByPerformanceNotifier.new);

final productsByCategoriesProvider = AsyncNotifierProviderFamily<
    _ProductsByCategoriesNotifier,
    List<ProductPreview>,
    String>(_ProductsByCategoriesNotifier.new);

final categoriesProvider = AsyncNotifierProviderFamily<
    _CategoriesProviderNotifier,
    List<Category>,
    String?>(_CategoriesProviderNotifier.new);

/////////////////////
class _ProductsByPerformanceNotifier
    extends FamilyAsyncNotifier<List<ProductPreview>, ProductsPerformance> {
  late final ProductsPerformance _performance;
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<ProductPreview>> build(arg) async {
    _performance = arg;
    await loadData();
    return state.requireValue;
  }

  Future<void> loadData() async {
    if (state.isLoading && state.hasValue) 
      return;
    
    if (!_dataPaginationParams.hasNextPage) return;
    state = const AsyncValue.loading();
    final res = await ProductsByPerformance().call(
      ProductByPerformanceParams(
        paginationParams: _dataPaginationParams,
        performance: _performance,
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

////////////////////
class _ProductsByCategoriesNotifier
    extends FamilyAsyncNotifier<List<ProductPreview>, String> {
  late final String _category;
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<ProductPreview>> build(arg) async {
    _category = arg;
    await loadData();
    return state.requireValue;
  }

 
    
  Future<void> loadData() async {
        if (state.isLoading && state.hasValue) 
      return;
    
    if (!_dataPaginationParams.hasNextPage) return;
    state = const AsyncValue.loading();
    final res = await ProductsByCategory().call(
      ProductsByCategoryParams(
        paginationParams: _dataPaginationParams,
        category: _category,
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

////////////////
/////
class _CategoriesProviderNotifier
    extends FamilyAsyncNotifier<List<Category>, String?> {
  late final String? _parentCategory;
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<Category>> build(arg) async {
    _parentCategory = arg;
    await loadData();
    return state.requireValue;
  }

  Future<void> loadData() async {
        if (state.isLoading && state.hasValue) 
      return;
    
    if (!_dataPaginationParams.hasNextPage) return;
    state = const AsyncValue.loading();
    final res = await Categories().call(
      GetCategoriesParams(
        paginationParams: _dataPaginationParams,
        parentCategory: _parentCategory,
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
