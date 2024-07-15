import 'package:aissam_store_v2/app/core/constants.dart';

class DataPagination<T> {
  final List<T> items;
  final dynamic indexIdentifier;
  final bool hasNextPage;

  DataPagination(
      {required this.items, required this.hasNextPage, this.indexIdentifier});

  copyWith({List<T>? items, bool? hasNextPage, Object? indexIdentifier}) {
    return DataPagination<T>(
      items: items ?? this.items,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      indexIdentifier: indexIdentifier ?? this.indexIdentifier,
    );
  }
}

class DataPaginationParams {
  final dynamic indexIdentifierObj;
  final int pageSize;
  DataPaginationParams({
    this.indexIdentifierObj,
    this.pageSize = BuisnessConsts.dataPaginationPageSize,
  });
}
