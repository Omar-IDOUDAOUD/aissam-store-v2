import 'dart:async';

import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/config/environment/environment.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDb extends DisposableService {
  final Future<ConnectionChecker> _connectionChecker;
  MongoDb(this._connectionChecker) ;

  Db? _db;
  FutureOr<Db> get db async {
    if (await _connectionChecker.then((con) => !con.currentState))
      throw NetworkException();
    if (_db != null) return _db!;
    final dbUri = Uri(
      scheme: "mongodb+srv",
      userInfo: "${Environment.mongodbUsername}:${Environment.mongodbPassword}",
      host: Environment.mongodbHost,
      path: Environment.mongodbDatabase,
      queryParameters: {
        'retryWrites': 'true',
        'w': 'majority',
        'connectTimeoutMS':
            GlobalConstnts.requestTimeoutDuration.inMilliseconds.toString(),
        'socketTimeoutMS':
            GlobalConstnts.requestTimeoutDuration.inMilliseconds.toString(),
      },
    );

    try {
      _db = await Db.create(dbUri.toString())
          .timeout(GlobalConstnts.requestTimeoutDuration);
      await _db!.open().timeout(GlobalConstnts.requestTimeoutDuration);
    } on TimeoutException {
      throw NetworkException();
    }
    return _db!;
  }

  @override
  void dispose() async {
    await _db?.close();
  }
}
