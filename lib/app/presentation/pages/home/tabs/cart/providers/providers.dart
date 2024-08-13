import 'dart:async';

import 'package:aissam_store_v2/app/buisness/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';






final cartProvider = AsyncNotifierProvider<_Provider, List<CartItem>>(_Provider.new);


class _Provider extends AsyncNotifier<List<CartItem>> {
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<CartItem>> build() async {
    await loadData();
    return state.requireValue;
  }

  Future<void> loadData() async {
    if (state.isLoading && state.hasValue) return;

    if (!_dataPaginationParams.hasNextPage) return;
    state = const AsyncValue.loading();
    final res = await GetCart().call(_dataPaginationParams);
    res.fold((err) {
      state = AsyncValue.error(err, StackTrace.empty);
    }, (res) {
      state = AsyncValue.data(((state.valueOrNull ?? [])..addAll(res.items)));
      _dataPaginationParams = res.params;
    });
  }
}





final cartSelectionsProvider = StateProvider<List<int>>((ref) {
  return [];
});

final cartDeletedItemsProvider = StateProvider<List<int>>((ref) {
  
  return [];
});



