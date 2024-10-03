import 'dart:async';

import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/core/global_consts.dart';
import 'package:aissam_store_v2/config/environment/environment.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:mongo_dart/mongo_dart.dart';
export 'package:mongo_dart/mongo_dart.dart';

class MongoDb extends ServiceLifecycle {
  final ConnectionChecker _connectionChecker;
  final String databaseName;
  MongoDb(this.databaseName, this._connectionChecker);

  @override
  Future<MongoDb> init() async {
    print('INITIALIZING MONGO DB');
    final isConnected = _connectionChecker.currentState;
    if (!isConnected) return this;
    final dbUri = Uri(
      scheme: "mongodb+srv",
      userInfo: "${Environment.mongodbUsername}:${Environment.mongodbPassword}",
      host: Environment.mongodbHost,
      path: databaseName,
      queryParameters: {'w': '1'},
    );
    try {
      _db = await Db.create(dbUri.toString());
      await _db!.open().timeout(GlobalConstnts.requestTimeoutDuration);
    } on TimeoutException {
      return this;
    } catch (e) {
      throw Failure('E-5648',
          message: 'Error while conneting to database', error: e);
    }
    return this;
  }

  Db? _db;

  /// It Constructs the connection first if its not connected yet
  FutureOr<Db> get db async {
    final isConnected = _connectionChecker.currentState;
    if (!isConnected) throw const NetworkFailure();
    if (_db?.isConnected == true) return _db!;
    await init();
    return _db!;
  }

  @override
  void dispose() async {
    await _db?.close();
  }
}
