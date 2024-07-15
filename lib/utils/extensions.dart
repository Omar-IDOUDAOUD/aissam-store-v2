import 'dart:async';

import 'package:get_it/get_it.dart';

extension GetItExtension on GetIt {
  FutureOr<T> getAsyncOnce<T extends Object>() async =>
      isReadySync<T>() ? get<T>() : await getAsync<T>();
}
