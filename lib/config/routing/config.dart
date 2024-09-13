import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/config/routing/routes.dart';
import 'package:go_router/go_router.dart';

/// adb -s emulator-5554 shell am start -W -a android.intent.action.VIEW -d "aissamstore://aissame.store.com"

abstract class AppRoutingConfig {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splash.subPath,
        name: AppRoutes.splash.name,
        builder: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return SplashPage(redirectTo: redirect);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomePage(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.subPath,
            name: AppRoutes.home.name,
            builder: (context, state) => const HomeMainBody(),
            routes: [
              GoRoute(
                path: AppRoutes.homeDiscoverCategories.subPath,
                name: AppRoutes.homeDiscoverCategories.name,
                builder: (_, state) {
                  return const DiscoverCategoriesSubScreen();
                },
              ),
              GoRoute(
                path: AppRoutes.homeDiscoverProducts.subPath,
                name: AppRoutes.homeDiscoverProducts.name,
                builder: (_, state) {
                  final params = state.extra as DiscoverProductsSubScreenParams;
                  return DiscoverProductsSubScreen(routeParams: params);
                },
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (_, state) async {
      print('REDIRECTION----------<<');
      print('URI: ${state.uri.toString()}');
      print('PATH: ${state.path}');
      print('FULLPATH: ${state.fullPath}');
      print('MATCHED-LOCATION: ${state.matchedLocation}');
      print('PARAMS: ${state.pathParameters}');
      print('REDIRECTION---------->>');
      // return null;
      if (!appInitilized && state.matchedLocation != '/')
        return Uri(
          path: '/',
          queryParameters: {
            'redirect': state.uri.toString(),
          },
        ).toString();
      return null;
    },
  );
}
