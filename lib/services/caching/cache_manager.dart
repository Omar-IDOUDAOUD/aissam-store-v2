import 'dart:async';

import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:aissam_store_v2/services/caching/entity/cache_entity.dart';
import 'package:aissam_store_v2/core/types.dart';

class CacheManager extends ServiceLifecycle {
  final LocalDb _localDb;

  CacheManager(this._localDb);

  @override
  CacheManager init() {
    _localDb.registerAdapter(CacheEntityAdapter());
    return this;
  }

  Future<void> commitNewCache({
    required String key,
    required String collection,
    required List<String> path,

    /// it must be a primitive type
    required Object data,
  }) async {

    /// T must be a primitive type
    final box = await _localDb.openLazyBox<CacheEntity>(
      path: _insertCacheDirTo(path),
      name: collection,
      regiserAdapter: CacheEntityAdapter(),
    );
    await box.put(
      key,
      CacheEntity(
        key: key,
        data: data,
        expirationDate:
            DateTime.now().add(GlobalConstnts.cacheExpirationPeriod),
      ),
    );
  }

  List<String> _insertCacheDirTo(List<String> path) => path..insert(0, 'cache');

  /// Type T must be a primitive type
  Future<List<T>?> getListCaches<T>({
    required String key,
    required String collection,
    required List<String> path,
  }) async {
    final box = await _localDb.openLazyBox<CacheEntity>(
      path: _insertCacheDirTo(path),
      name: collection,
      regiserAdapter: CacheEntityAdapter(),
    );
    final entry = await box.get(key);
    if (entry?.expirationDate.isBefore(DateTime.now()) ?? false) {
      box.delete(key);
      return null;
    }
    final data = entry?.data;
    if (T == Map2)
      return (data as List?)?.map<Map2>((elem) => Map2.from(elem)).toList()
          as List<T>?;
    else
      return data as List<T>?;
  }

  /// Type T must be a primitive type
  Future<T?> getCacheObject<T>({
    required String key,
    required String collection,
    required List<String> path,
  }) async { 
    final box = await _localDb.openLazyBox<CacheEntity>(
      path: _insertCacheDirTo(path),
      name: collection,
      regiserAdapter: CacheEntityAdapter(),
    );
    final entry = await box.get(key);
    if (entry?.expirationDate.isBefore(DateTime.now()) ?? false) {
      box.delete(key);
      return null;
    }
    final data = entry?.data;

    if (T == Map2 && data != null)  return Map2.from(data as Map) as T; 
    return data as T?;
  }
}
