import 'package:aissam_store_v2/app/buisness/features/products/core/params.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/sign_in.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/sign_up.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/sub_views/account/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/sub_views/filter_dialog/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/widget/app_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/app/presentation/pages/test/page.dart';
import 'package:aissam_store_v2/config/routing/routes.dart';
import 'package:aissam_store_v2/main.dart';
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
 sdfsdf
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      // GoRoute(
      //   path: '/mainroute1/:param',
      //   pageBuilder: (context, state) {
      //     return buildPageWithDefaultTransition(
      //       const TestPage(
      //         text: '/mainroute1',
      //         redirectTo: '/subroute',
      //       ),
      //       state,
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: 'subroute1',
      //       pageBuilder: (context, state) {
      //         return buildPageWithDefaultTransition(
      //           const TestPage(
      //             text: 'subroute1',
      //             redirectTo: '/splash',
      //           ),
      //           state,
      //         );
      //       },
      //       routes: [
      //         GoRoute(
      //           path: 'subsubroute1',
      //           pageBuilder: (context, state) {
      //             return buildPageWithDefaultTransition(
      //               const TestPage(
      //                 text: 'subsubroute1',
      //                 redirectTo: '/',
      //               ),
      //               state,
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      // GoRoute(
      //       path: '/mainroute2',
      //       pageBuilder: (context, state) {
      //         return buildPageWithDefaultTransition(
      //           const TestPage(
      //             text: 'mainroute1',
      //             redirectTo: '/',
      //           ),
      //           state,
      //         );
      //       },
      //     ),
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return buildPageWithDefaultTransition(
              SplashPage(redirectTo: redirect), state);
        },
      ),
      GoRoute(
        path: AppRoutes.test.path,
        name: AppRoutes.test.name,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(const TestPage(), state);
        },
      ),
      GoRoute(
        path: AppRoutes.auth.path,
        name: AppRoutes.auth.name,
        redirect: (_, state) {
          if (state.fullPath == AppRoutes.auth.path)
            return AppRoutes.authSignUp.fullPath(state.pathParameters);
          else
            return null;
        },
        routes: [
          GoRoute(
            path: AppRoutes.authSignUp.path,
            name: AppRoutes.authSignUp.name,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(const SignUpPage(), state);
            },
          ),
          GoRoute(
            path: AppRoutes.authSignIn.path,
            name: AppRoutes.authSignIn.name,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(const SignInPage(), state);
            },
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: homeNestedNavigatorKey,
        pageBuilder: (context, state, child) {
          return buildPageWithDefaultTransition(HomePage(child: child), state);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              const HomeMainBody(),
              state,
            ),
            routes: [
              GoRoute(
                path: AppRoutes.homeDiscoverCategories.path,
                name: AppRoutes.homeDiscoverCategories.name,
                pageBuilder: (_, state) {
                  return buildPageWithDefaultTransition(
                      const DiscoverCategoriesSubScreen(), state);
                },
              ),
              GoRoute(
                path: AppRoutes.homeDiscoverProducts.path,
                name: AppRoutes.homeDiscoverProducts.name,
                pageBuilder: (_, state) {
                  final params = state.extra as DiscoverProductsSubScreenParams;
                  return buildPageWithDefaultTransition(
                      DiscoverProductsSubScreen(routeParams: params), state);
                },
              ),
              GoRoute(
                path: AppRoutes.homeProfileMyAccount.path,
                name: AppRoutes.homeProfileMyAccount.name,
                pageBuilder: (_, state) {
                  return buildPageWithDefaultTransition(
                      const MyAccount(), state);
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
