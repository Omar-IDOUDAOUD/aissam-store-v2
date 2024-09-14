class AppRoute {
  final String path;
  final String name;

  AppRoute(String path, this.name) : path = '/$path';
  AppRoute.withouPrefix(this. path, this.name)  ;

  String get subPath {
    final slashesCount = path.split('/').length - 1;
    if (slashesCount == 1) {
      return path;
    }
    return path.split('/').last;
  }

  AppRoute buildChild(String subPath, String name) {
    return AppRoute.withouPrefix('$path/$subPath', name);
  }
}

abstract class AppRoutes {
  static final AppRoute splash = AppRoute('', 'splash');
  static final AppRoute home = AppRoute('home', 'home');
  static final AppRoute homeDiscoverProducts =
      home.buildChild('discover_products', 'discover products');
  static final AppRoute homeDiscoverCategories =
      home.buildChild('discover_categories', 'discover categories');
        static final AppRoute homeSearchFilterDialog =
      home.buildChild('filter_dialog', 'filter dialog');
}
