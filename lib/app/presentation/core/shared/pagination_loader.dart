import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildPaginationListItem<T>({
  required AsyncValue<List<T>> asyncValue,
  required int index,
  required Widget Function(T data) onData,
  required Widget Function(Object error) onError,
  required Widget Function(int index) onLoading,
}) {
  final data = asyncValue.valueOrNull?.elementAtOrNull(index);
  if (data != null) return onData(data);
  if (asyncValue.isLoading)
    return onLoading(index - (asyncValue.valueOrNull?.length ?? 0));
  if (asyncValue.hasError) return onError(asyncValue.error!);
  throw UnimplementedError();
}

int buildPaginationListCount(AsyncValue<List> asyncValue) {
  final isLoading = asyncValue.isLoading;
  final hasError = asyncValue.hasError;
  final dataLength = asyncValue.valueOrNull?.length ?? 0;
  return dataLength +
      (isLoading
          ? 3
          : hasError
              ? 1
              : 0);
}
