// ignore_for_file: dead_code

import 'dart:async';

import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

const int _possibleInsertCountPerDocument = 4;

class CacheManager extends ServiceLifecycle {
  final LocalDb _localDb;

  CacheManager(this._localDb);

  final Map<String, int> _insertCountsPerDocument = {};
  bool _canInsertOnDoc(String doc, List<String> path) {
    final docPath = path.join() + doc;
    if ((_insertCountsPerDocument[docPath] ?? 0) >=
        _possibleInsertCountPerDocument) return false;

    _insertCountsPerDocument[docPath] =
        (_insertCountsPerDocument[docPath] ?? 0) + 1;
    return true;
  }

  /// The data can be [Iterable] or [Object].
  /// If data is [Iterable] the items will be added to existing entries.
  /// If [attachKey] is null, an auto inctremente key is used.
  Future<void> addToDocument({
    required List<String> path,
    required String document,
    String? attachKey,
    bool cleanUpFirst = false,
    required Object data,
  }) async {
    return;
    print('==>ADD TO DOCUMENT: $document, path: $path');
    if (!_canInsertOnDoc(document, path)) return;
    final LazyBox box = await _localDb.openLazyBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    if (cleanUpFirst) {
      await box.deleteAll(box.keys);
    }

    await box.put(
        'exp_date', DateTime.now().add(GlobalConstnts.cacheExpirationPeriod));
    if (attachKey != null) {
      print('======>ADD TO DOCUMENT: $document, path: $path, case 1');

      await box.put(attachKey, data);
    } else if (data is Iterable) {
      print('======>ADD TO DOCUMENT: $document, path: $path, case 2');
      await box.addAll(data);
    } else {
      print('======>ADD TO DOCUMENT: $document, path: $path, case 3');
      await box.add(data);
    }
    await box.close();
  }

  Future<Map<dynamic, dynamic>?> getDocument({
    required String document,
    required List<String> path,
  }) async {
    return null;
    print('==>GET CACHE DOCUMENT: $document, path: $path');
    final Box box = await _localDb.openBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    print('case 1');
    if (box.isEmpty) {
      await box.close();
      print('======>GET CACHE DOCUMENT: $document, path: $path, result: empty');

      return null;
    }
    if ((box.get('exp_date') as DateTime).isBefore(DateTime.now())) {
      box.deleteFromDisk();
      print(
          '======>GET CACHE DOCUMENT: $document, path: $path, result: experation date');
      return null;
    }

    var res = box.toMap()..remove('exp_date');
    await box.close();
    print('======>GET CACHE DOCUMENT: $document, path: $path, result: $res');
    return res;
  }

  Future<Object?> getDocumentEntry({
    required String document,
    required List<String> path,
    required Object key,
  }) async {
    return null;
    print('==>GET CACHE DOCUMENT ENTRY: $document, path: $path');
    final LazyBox box = await _localDb.openLazyBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    if (box.isEmpty) {
      await box.close();
      print(
          '=======>GET CACHE DOCUMENT ENTRY: $document, path: $path, result: empty');

      return null;
    }
    if ((await box.get('exp_date') as DateTime).isBefore(DateTime.now())) {
      await box.deleteFromDisk();
      print(
          '=======>GET CACHE DOCUMENT ENTRY: $document, path: $path, result: exp date');
      return null;
    }
    if (key is int && box.containsKey(key)) {
      print(
          '======>GET CACHE DOCUMENT ENTRY: $document, path: $path, result: ${await box.getAt(key)}');

      return await box.getAt(key);
    }
    final res = await box.get(key);
    await box.close();
    print(
        '======>GET CACHE DOCUMENT ENTRY: $document, path: $path, result: $res');

    return res;
  }

  // Future<void> _closeBoxBeforeUse(BoxBase box, [bool justLazyBoxes = false]) async {
  //   if (justLazyBoxes && box.lazy) {
  //     await box.close();
  //   } else if (!justLazyBoxes && box.isOpen){

  //   }
  // }

  Future<void> deleteDocumentEntry({
    required String document,
    required List<String> path,
    required Object key,
  }) async {
    return;
    final LazyBox box = await _localDb.openLazyBox(
      path: _insertCacheDirTo(path),
      name: document,
    );
    if (box.isEmpty) {
      // await box.close();
      return;
    }
    if (key is int)
      await box.deleteAt(key);
    else
      await box.delete(key);
    // await box.close();
  }

  Future<void> cleanUpDocument({
    required String document,
    required List<String> path,
  }) async {
    final box = await _localDb.openLazyBox(
        path: _insertCacheDirTo(path), name: document);
    await box.deleteFromDisk();
    // await _localDb.deleteBox(document, path: path);
  }

  List<String> _insertCacheDirTo(List<String> path) => path..insert(0, 'cache');

  void destryAllCaches() {
    return _localDb.deleteDir(_insertCacheDirTo([]));
  }
}
