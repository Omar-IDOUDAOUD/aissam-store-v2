import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/app/core/interfaces/cache_identifier.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/services/caching/cache_manager.dart';

typedef Map2 = Map<String, dynamic>;

abstract class ProductsLocalDatasource {
  Future<DataPagination<T>> getAll<T>(
    (CacheIdentifier, DataPaginationParams) params, {
    required String collection,
    List<String>? path,
    T Function(Map2 json)? fromMap,
  });

  Future<T> get<T>(
    CacheIdentifier params, {
    required String collection,
    List<String>? path,
    T Function(Map2 json)? fromMap,
  });

  Future<void> saveAll<T>(
    CacheIdentifier params, {
    required String collection,
    required List<T> data,
    List<String>? path,
    Map2 Function(T element)? toMap,
  });

  Future<void> save(
    CacheIdentifier params, {
    required String collection,
    List<String>? path,
    required Map2 data,
  });
}

class ProductsLocalDatasourceImpl extends ProductsLocalDatasource {
  final CacheManager _cacheManager;

  ProductsLocalDatasourceImpl(this._cacheManager);

  final _defPath = <String>['products'];
  T _defFromMap<T>(e) => e as T;
  Map2 _defToMap<T>(e) => e as Map2;

  @override
  Future<DataPagination<T>> getAll<T>(
    (CacheIdentifier, DataPaginationParams) params, {
    required String collection,
    List<String>? path,
    T Function(Map2 json)? fromMap,
  }) async {
    final caches = await _cacheManager.getCaches<List<Map2>>(
      key: params.$1.buildCacheIdentifier(),
      collection: collection,
      path: path ?? _defPath,
    );
    if (caches == null) throw NoCachedDataException();
    return DataPagination(
      items: caches.map<T>(fromMap ?? _defFromMap).toList(),
      hasNextPage: caches.length == params.$2.pageSize,
      indexIdentifier: (params.$2.indexIdentifierObj ?? 0) + caches.length,
    );
  }

  @override
  Future<void> saveAll<T>(
    CacheIdentifier params, {
    required String collection,
    required List<T> data,
    List<String>? path,
    Map2 Function(T element)? toMap,
  }) {
    return _cacheManager.commitNewCache(
      key: params.buildCacheIdentifier(),
      collection: collection,
      path: path ?? _defPath,
      data: data.map(toMap ?? _defToMap),
    );
  }

  @override
  Future<void> save(
    CacheIdentifier params, {
    required String collection,
    List<String>? path,
    required Map2 data,
  }) {
    return _cacheManager.commitNewCache<Map2>(
      key: params.buildCacheIdentifier(),
      collection: collection,
      path: path ?? _defPath,
      data: data,
    );
  }

  @override
  Future<T> get<T>(
    CacheIdentifier params, {
    required String collection,
    List<String>? path,
    T Function(Map2 json)? fromMap,
  }) async {
    final cache =await _cacheManager.getCaches<Map2>(
      key: params.buildCacheIdentifier(),
      collection: collection,
      path: path ?? _defPath,
    );
    if (cache == null) throw NoCachedDataException();
    return (fromMap ?? _defFromMap)(cache); 
  }
}
