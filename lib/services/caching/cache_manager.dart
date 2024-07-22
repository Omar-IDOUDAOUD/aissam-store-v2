import 'dart:async';

import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheManager extends ServiceLifecycle {
  final LocalDb _localDb;

  CacheManager(this._localDb);

  /// The data can be [Iterable] or [Object]
  /// If [attachKey] is null, an auto inctremente key is used
  Future<void> addToDocument({
    required List<String> path,
    required String document,
    String? attachKey,
    required Object data,
  }) async {
    final LazyBox box = await _localDb.openLazyBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    await box.put(
        'exp_date', DateTime.now().add(GlobalConstnts.cacheExpirationPeriod));

    if (attachKey != null)
      await box.put(attachKey, data);
    else if (data is Iterable)
      await box.addAll(data);
    else
      await box.add(data);
    await box.close();
  }

  Future<Map<dynamic, dynamic>?> getDocument({
    required String document,
    required List<String> path,
  }) async {
    final Box box = await _localDb.openBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    if (box.isEmpty) {
      await box.close();
      return null;
    }
    if ((box.get('exp_date') as DateTime).isBefore(DateTime.now())) {
      box.deleteFromDisk();
      return null;
    }
    var res = box.toMap()..remove('exp_date');
    await box.close();
    return res;
  }

  Future<Object?> getDocumentEntry({
    required String document,
    required List<String> path,
    required Object key,
  }) async {
    final LazyBox box = await _localDb.openLazyBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    if (box.isEmpty) {
      await box.close();
      return null;
    }
    if ((await box.get('exp_date') as DateTime).isBefore(DateTime.now())) {
      box.deleteFromDisk();
      return null;
    }
    if (key is int && box.containsKey(key)) return box.getAt(key);
    final res = box.get(key);
    await box.close();
    return res;
  }

  Future<void> cleanUpDocument({
    required String document,
    required List<String> path,
  }) async {
    final box = await _localDb.openLazyBox(
        path: _insertCacheDirTo(path), name: document);
    await box.deleteFromDisk();
  }

  List<String> _insertCacheDirTo(List<String> path) => path..insert(0, 'cache');
}
