

import 'package:aissam_store_v2/app/buisness/core/constants.dart';

class DataPagination<T> {
  final List<T> items;
  final DataPaginationParams params;

  DataPagination({
    required this.items,
    required this.params,
  });

  factory DataPagination.ready({
    required DataPaginationParams params,
    required List<T> items,
    dynamic tokenObj,
  }) {
    return DataPagination(
      items: items,
      params: DataPaginationParams(
        pageSize: params.pageSize,
        page: params.page + 1,
        hasNextPage: items.length == params.pageSize,
        tokenObj: tokenObj,
      ),
    );
  }

  factory DataPagination.empty() {
    return DataPagination(items: [], params: DataPaginationParams());
  }

  @override
  String toString() {
    return 'DataPagination: length: ${items.length}';
  }
}

class DataPaginationParams {
  /// used for getting specified pagination data
  final dynamic tokenObj;
  final int pageSize;
  final bool hasNextPage;

  /// used for data caching
  int page;

  DataPaginationParams({
    this.tokenObj,
    this.pageSize = BuisnessConsts.dataPaginationPageSize,
    this.page = 0,
    this.hasNextPage = true,
  });

  void incrementPage() {
    page += 1;
  }

  @override
  String toString() {
    return 'DataPaginationParams: token:$tokenObj, page: $page, hasNextPage: $hasNextPage';
  }
}
