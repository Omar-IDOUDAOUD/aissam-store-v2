import 'package:aissam_store_v2/core/types.dart';

class AppRoute {
  final AppRoute? parrentRoute;
  final String _path;
  final String? name;
  final List<String>? params;

  AppRoute(this._path, {this.parrentRoute, this.name, this.params});

  String get path {
    String buildPath = parrentRoute == null ? '/$_path' : _path;
    if (params != null) {
      for (var param in params!) {
        buildPath += '/:$param';
      }
    }
    print('GET PATH: $buildPath');
    return buildPath;
  }

  String fullPath([Map2? paramsValues]) {
    final parrentPath = parrentRoute?.fullPath(paramsValues) ?? '';
    String fullPath = '$parrentPath/$_path';
    if (params != null) {
      for (var paramKey in params!) {
        fullPath += '/${paramsValues?[paramKey] ?? 'null'}';
      }
    }
    print('GET FULL-PATH: $fullPath');
    return fullPath;
  }
}

abstract class AppRoutes {
  static final AppRoute splash = AppRoute('', name: 'splash');
  static final AppRoute home = AppRoute('test', name: 'test');
  static final AppRoute test = AppRoute('home', name: 'home');
  static final AppRoute auth =
      AppRoute('auth', name: 'authentication', params: ['idOne', 'idTwo']);
  static final AppRoute homeDiscoverProducts = AppRoute('discover_products',
      parrentRoute: home, name: 'discover products');
  static final AppRoute homeDiscoverCategories = AppRoute('discover_categories',
      name: 'discover categories', parrentRoute: home);
  static final AppRoute homeProfileMyAccount =
      AppRoute('my_account', name: 'my account', parrentRoute: home);
  static final AppRoute authSignIn =
      AppRoute('sign_in', name: 'sign in', parrentRoute: auth);
  static final AppRoute authSignUp =
      AppRoute('sign_up', name: 'sign up', parrentRoute: auth);
}
