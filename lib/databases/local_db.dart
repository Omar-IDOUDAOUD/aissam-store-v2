import 'dart:async';
import 'dart:io';

import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class LocalDb extends ServiceLifecycle {
  late final Directory _mainDirectory;
  @override
  Future<LocalDb> init() async {
    _mainDirectory = await getApplicationSupportDirectory();
    Hive.init(_mainDirectory.path);
    return this;
  }

  String _buildFinalPath(List<String> path) =>
      p.joinAll([..._mainDirectory.uri.pathSegments, ...path]);

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
      path: _buildFinalPath(path),
    );
  }

  Future<Box> openBox<T>({
    TypeAdapter<T>? regiserAdapter,
    required List<String> path,
    required String name,
  }) async {
    registerAdapter(regiserAdapter);
    return Hive.openBox(
      name,
      path: _buildFinalPath(path),
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
