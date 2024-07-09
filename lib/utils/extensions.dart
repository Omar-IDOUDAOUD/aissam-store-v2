import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';

extension GetItExtension on GetIt {
  FutureOr<T> getAsyncOnce<T extends Object>() async =>
      isReadySync<T>() ? get<T>() : await getAsync<T>();
}

extension TimestampExtensions on Timestamp {
  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}