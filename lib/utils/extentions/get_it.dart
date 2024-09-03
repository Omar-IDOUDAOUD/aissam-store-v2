import 'dart:async';

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
