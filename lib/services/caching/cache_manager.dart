import 'dart:async';

import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:aissam_store_v2/services/caching/entity/cache_entity.dart';

class CacheManager extends ServiceLifecycle {
  final LocalDb _localDb;

  CacheManager(this._localDb);

  @override
  CacheManager init() {
    _localDb.registerAdapter(CacheEntityAdapter());
    return this;
  }

  Future<void> commitNewCache<T>({
    required String key,
    required String collection,
    required List<String> path,

    /// it must be a primitive type
    required T data,
  }) async {
    path.insert(0, 'cache');
    final box = await _localDb.openLazyBox<CacheEntity<T>>(
      path: path,
      name: collection,
      regiserAdapter: CacheEntityAdapter(),
    );
    await box.put(
      key,
      CacheEntity(
        key: key,
        data: data,
        expirationDate: DateTime.now().add(
          GlobalConstnts.cacheExpirationPeriod,
        ),
      ),
    );
  }

  List<String> _insertCacheDirTo(List<String> path) => path..insert(0, 'cache');

  Future<T?> getCaches<T>(
      {required String key,
      required String collection,
      required List<String> path}) async {
    final box = await _localDb.openLazyBox<CacheEntity<T>>(
      path: _insertCacheDirTo(path),
      name: collection,
      regiserAdapter: CacheEntityAdapter(),
    );
    final entry = await box.get(key);
    if (entry?.expirationDate.isBefore(DateTime.now()) ?? false) {
      box.delete(key);
      return null;
    }
    return entry?.data;
  }
}
