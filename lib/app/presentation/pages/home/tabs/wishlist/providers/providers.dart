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

final wishlistSelectionsProvider =
    ChangeNotifierProvider<_SelectionsNotifier>(_SelectionsNotifier.new);

class _SelectionsNotifier extends ChangeNotifier {
  _SelectionsNotifier(this.ref);
  final ChangeNotifierProviderRef ref;
  List<int> selections = [];
  List<int> trash = [];
  List<int> restored = [];
  List<int> deleted = [];

  void select(bool select, int index) {
    if (trash.isNotEmpty) return;
    if (select)
      selections = List.from(selections..add(index));
    else
      selections = List.from(selections..remove(index));
    notifyListeners();
  }

  void unselectAll() {
    selections = [];
    notifyListeners();
  }

  void moveToTrach() async {
    trash = selections;
    selections = [];
    restored = [];
    notifyListeners();
    //

    ref.read(snackBarProvider.notifier).state = SnackBarEvent(
      message: 'Removing items...',
      action: 'Restore',
      onActionPress: _restoreFromTrach,
    );

    final snackbarCloseReason =
        await ref.read(snackBarProvider)!.controller.closed;
    if (snackbarCloseReason != SnackBarClosedReason.action) {
      _delete();
    }
  }

  void _restoreFromTrach() {
    restored = trash;
    trash = [];
    notifyListeners();
  }

  void _delete() async {
    final itemsToDelete = <String>[];

    final data = ref.read(wishlistProvider).valueOrNull!;
    for (var index in trash) {
      itemsToDelete.add(data[index].id!);
    }

    final res = await RemoveWishlistItems().call(itemsToDelete);
    return res.fold(
      (err) {
        restored = trash;
        trash.clear();
        notifyListeners();
        throw err;
      },
      (_) {
        deleted.addAll(trash);
        trash.clear();
        notifyListeners();
      },
    );
  }

  CardStates buildCardState(int index) {
    if (selections.contains(index)) return CardStates.selected;
    if (trash.contains(index)) return CardStates.trash;
    if (restored.contains(index)) return CardStates.restored;
    if (deleted.contains(index)) return CardStates.deleted;
    return CardStates.none;
  }
}
