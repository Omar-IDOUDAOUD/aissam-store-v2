import 'package:aissam_store_v2/core/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_card.dart';

Widget buildPaginatedListItem<T>({
  required AsyncValue<List<T>> asyncValue,
  required int index,
  required Widget Function(T data) onDataBuilder,
  required Widget Function(Object error) onErrorBuilder,
  required Widget Function(int index) onLoadingBuilder,
  required VoidCallback? loadData,
}) {
  final data = asyncValue.valueOrNull?.elementAtOrNull(index);
  if (data != null) {
    if (asyncValue.valueOrNull?.length == index + 1 &&
        !asyncValue.isLoading &&
        !asyncValue.hasError)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        print('LOADDDDDD DATA');
        loadData?.call();
      });
    return onDataBuilder(data);
  }
  if (asyncValue.isLoading)
    return onLoadingBuilder(index - (asyncValue.valueOrNull?.length ?? 0));
  if (asyncValue.hasError) return onErrorBuilder(asyncValue.error!);
  throw UnimplementedError();
}

int calculatePaginationItemCount(AsyncValue<List> asyncValue) {
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

Widget buildStateAwareChild(
    {required AsyncValue<List> asyncValue,
    required Widget child,
    bool isSliver = false,
    bool addPageMargine = true,
    VoidCallback? onRety,
    double? height = 300}) {
  final empty = asyncValue.valueOrNull?.isEmpty ?? true;

  if (empty && asyncValue.hasError)
    return _checkIfSliver(
        ErrorCard(
          error: asyncValue.error!,
          onRety: onRety,
          addPageMargine: addPageMargine,
          height: height,
          showDescription: true,
        ),
        isSliver);
  if (empty && !asyncValue.isLoading)
    return _checkIfSliver(EmptyData(height: height), isSliver);
  else
    return child;
}

Widget _checkIfSliver(child, isSliver) =>
    isSliver ? SliverToBoxAdapter(child: child) : child;

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    this.height,
  });
  final double? height;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height ?? 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FluentIcons.error_circle_20_regular,
            size: 40,
            color: context.theme.colors.s,
          ),
          const SizedBox(height: 10),
          const Text(
            'No Data!',
          ),
        ],
      ),
    );
  }
}
