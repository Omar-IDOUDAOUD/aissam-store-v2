import 'dart:async';

import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class LocalDb extends ServiceLifecycle {
  
  @override
  Future<LocalDb> init() async {
    Hive.init((await getApplicationSupportDirectory()).path);
    return this;
  }

  void registerAdapter<T>(TypeAdapter<T>? regiserAdapter) {
    if (regiserAdapter != null &&
        !Hive.isAdapterRegistered(regiserAdapter.typeId))
      Hive.registerAdapter<T>(regiserAdapter);
  }

  Future<LazyBox<T>> openLazyBox<T>({
    TypeAdapter<T>? regiserAdapter,
    required List<String> path,
    required String name,
  }) async {
    registerAdapter(regiserAdapter);
    return Hive.openLazyBox(
      name,
      path: Path.joinAll(path),
    );
  }

  Future<Box> openBox<T>({
    TypeAdapter<T>? regiserAdapter,
    required Uri path,
    required String name,
  }) async {
    registerAdapter(regiserAdapter);
    return Hive.openBox(
      name,
      path: path.path,
    );
  }

  Future<void> deleteBox(String name, {String? path}) {
    return Hive.deleteBoxFromDisk(name, path: path);
  }

  Future<void> reset() {
    return Hive.deleteFromDisk();
  }

  @override
  Future<void> dispose() async {
    return Hive.close();
  }
}
