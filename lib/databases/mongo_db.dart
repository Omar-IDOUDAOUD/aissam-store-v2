import 'dart:async';

import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/config/environment/environment.dart';
import 'package:aissam_store_v2/core/service_lifecycle.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:mongo_db_driver/mongo_db_driver.dart';

export 'package:bson/bson.dart';
export 'package:mongo_db_query/mongo_db_query.dart';
export 'package:mongo_db_driver/mongo_db_driver.dart';

class MongoDb extends DisposableService {
  final Future<ConnectionChecker> _connectionChecker;
  final String databaseName;
  MongoDb(this.databaseName, this._connectionChecker);

  MongoClient? _client;
  MongoDatabase? _db;
  FutureOr<MongoDatabase> get db async {
    if (await _connectionChecker.then((con) => !con.currentState))
      throw NetworkException();

    if (_db != null) return _db!;
    final dbUri = Uri(
      scheme: "mongodb+srv",
      userInfo: "${Environment.mongodbUsername}:${Environment.mongodbPassword}",
      host: Environment.mongodbHost,
      queryParameters: {
        'retryWrites': 'true',
        'w': 'majority',
      },
    );
    try {
      _client = MongoClient(
        dbUri.toString(),
        mongoClientOptions: MongoClientOptions()
          ..socketTimeoutMS =
              GlobalConstnts.requestTimeoutDuration.inMilliseconds
          ..connectTimeoutMS =
              GlobalConstnts.requestTimeoutDuration.inMilliseconds,
      );
      await _client!.connect().timeout(GlobalConstnts.requestTimeoutDuration);
      _db = _client!.db(dbName: databaseName);
    } on TimeoutException {
      throw NetworkException();
    } catch (e) {
      throw Exception2(msg: 'Error while conneting to database', error: e);
    }
    return _db!;
  }

  @override
  void dispose() async {
    await _client?.close();
    _client = _db = null;
  }
}
