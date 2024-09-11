import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/sub_views/filter_dialog/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/widget/app_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/config/routing/routes.dart';
import 'package:aissam_store_v2/config/routing/utils/dialog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// adb -s emulator-5554 shell am start -W -a android.intent.action.VIEW -d "aissamstore://aissame.store.com"

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeNestedNavigatorKey =
    GlobalKey<NavigatorState>();

abstract class AppRoutingConfig {
  static Page buildPageWithDefaultTransition<T>(
      Widget child, GoRouterState state) {
    return CupertinoPage(
      child: child,
      name: state.name,
      key: state.pageKey,
    );
  }

  static final GoRouter router = GoRouter(
    observers: [],
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash.subPath,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return buildPageWithDefaultTransition(
              SplashPage(redirectTo: redirect), state);
        },
      ),
      ShellRoute(
        navigatorKey: homeNestedNavigatorKey,
        pageBuilder: (context, state, child) {
          return buildPageWithDefaultTransition(HomePage(child: child), state);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.subPath,
            name: AppRoutes.home.name,
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              const HomeMainBody(),
              state,
            ),
            routes: [
              GoRoute(
                path: AppRoutes.homeDiscoverCategories.subPath,
                name: AppRoutes.homeDiscoverCategories.name,
                pageBuilder: (_, state) {
                  return buildPageWithDefaultTransition(
                      const DiscoverCategoriesSubScreen(), state);
                },
              ),
              GoRoute(
                path: AppRoutes.homeDiscoverProducts.subPath,
                name: AppRoutes.homeDiscoverProducts.name,
                pageBuilder: (_, state) {
                  final params = state.extra as DiscoverProductsSubScreenParams;
                  return buildPageWithDefaultTransition(
                      DiscoverProductsSubScreen(routeParams: params), state);
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
            'redirect': state.uri.path.toString(),
          },
        ).toString();
      return null;
    },
  );
}
// GoRoute(
//   path: '/tfooooooo',
//   pageBuilder: (context, state) {
//     return MaterialPage(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Title'),
//         ),
//         body: MaterialButton(
//           child: const Text('back'),
//           onPressed: () {
//             context.pop();
//           },
//         ),
//       ),
//     );
//   },
// ),

// class XClass extends NavigatorObserver {
  
  
  
//   @override
//   void didPop(Route route, Route? previousRoute) {
    
//     super.didPop(route, previousRoute);
//   }
// }
