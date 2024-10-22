import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/widgets.dart';

extension CurrentRoute on BuildContext {
  Route<dynamic> get currentRoute {
    return BackButtonInterceptor.getCurrentNavigatorRoute(this)!;
  }
}
