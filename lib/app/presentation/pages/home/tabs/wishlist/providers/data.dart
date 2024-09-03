import 'dart:async';

import 'package:aissam_store_v2/app/buisness/wishlist/domain/entities/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/presentation/core/card_states.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider =
    AsyncNotifierProvider<_Provider, List<WishlistItem>>(_Provider.new);

class _Provider extends AsyncNotifier<List<WishlistItem>> {
  DataPaginationParams _dataPaginationParams = DataPaginationParams();

  @override
  Future<List<WishlistItem>> build() async {
    await loadData();
    return state.requireValue;
  }

  Future<void> loadData() async {
    if (state.isLoading && state.hasValue) return;
    if (!_dataPaginationParams.hasNextPage) return;

    state = const AsyncValue.loading();
    final res = await GetWishlist().call(_dataPaginationParams);
    res.fold((err) {
      state = AsyncValue.error(err, StackTrace.empty);
    }, (res) {
      state = AsyncValue.data(((state.valueOrNull ?? [])..addAll(res.items)));
      _dataPaginationParams = res.params;
    });
  }
}
