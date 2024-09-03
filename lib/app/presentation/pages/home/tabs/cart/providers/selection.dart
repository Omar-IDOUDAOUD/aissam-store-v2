


import 'dart:async';

import 'package:aissam_store_v2/app/buisness/cart/domain/entities/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/presentation/core/card_states.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data.dart';


final cartSelectionsProvider =
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
      message: 'Removing Items...',
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

    final data = ref.read(cartProvider).valueOrNull!;
    for (var index in trash) {
      itemsToDelete.add(data[index].id!);
    }

    final res = await RemoveCartItems().call(itemsToDelete);
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
