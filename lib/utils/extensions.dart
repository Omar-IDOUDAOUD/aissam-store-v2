import 'dart:async';

import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';

extension GetItExtension on GetIt {
  FutureOr<T> getAsyncOnce<T extends Object>() async =>
      isReadySync<T>() ? get<T>() : await getAsync<T>();
}

extension SelectorBuilderExtension on SelectorBuilder {
  /// shortcut for: where..id(ObjectId.fromHexString(hexString))
  SelectorBuilder id2(String hexString) {
    return id(ObjectId.fromHexString(hexString));
  }
}

extension FirebaseFirestoreGet2<T> on Query<T> {
  Future<QuerySnapshot<T>> get2() async {
    final ConnectionChecker connectionChecker = sl();
    late final QuerySnapshot<T> res;
    if (connectionChecker.currentState)
      {
        try {
          res = await get().timeout(GlobalConstnts.requestTimeoutDuration);
        } on TimeoutException  {
          throw NetworkException(); 
        }
      }
    else {
      res = await get(const GetOptions(source: Source.cache));
      if (res.size == 0) throw NoCachedDataException();
    }
    return res;
  }
}

 


