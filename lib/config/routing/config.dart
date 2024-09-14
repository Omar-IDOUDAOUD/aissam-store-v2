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

abstract class AppRoutingConfig {
  static Page buildPageWithDefaultTransition<T>(Widget child) {
    return CupertinoPage(child: child);
  }

  // static Page buildDialogWithDefaultTransition<T>(Widget child) {
  //   return DialogPage(builder: );

  //   return CustomTransitionPage(
  //     child: child,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       final an = CurvedAnimation(
  //         parent: animation,
  //         curve: ViewConsts.animationCurve,
  //         reverseCurve: ViewConsts.animationCurve.flipped,
  //       );
  //       final scaleAn = an.drive(Tween(begin: 0.95, end: 1.0));
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
  //         child: FadeTransition(
  //           opacity: an,
  //           child: ScaleTransition(
  //             scale: scaleAn,
  //             child: child,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static final GoRouter router = GoRouter(
    // initialLocation: '/tfooooooooooo',
    routes: [
      GoRoute(
        path: AppRoutes.splash.subPath,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return buildPageWithDefaultTransition(
              SplashPage(redirectTo: redirect));
        },
      ),
      ShellRoute(
        pageBuilder: (context, state, child) {
          return buildPageWithDefaultTransition(HomePage(child: child));
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.subPath,
            name: AppRoutes.home.name,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(const HomeMainBody()),
            routes: [
              GoRoute(
                path: AppRoutes.homeDiscoverCategories.subPath,
                name: AppRoutes.homeDiscoverCategories.name,
                pageBuilder: (_, state) {
                  return buildPageWithDefaultTransition(
                      const DiscoverCategoriesSubScreen());
                },
              ),
              GoRoute(
                path: AppRoutes.homeDiscoverProducts.subPath,
                name: AppRoutes.homeDiscoverProducts.name,
                pageBuilder: (_, state) {
                  final params = state.extra as DiscoverProductsSubScreenParams;
                  return buildPageWithDefaultTransition(
                      DiscoverProductsSubScreen(routeParams: params));
                },
              ),
              // GoRoute(
              //   path: AppRoutes.homeSearchFilterDialog.subPath,
              //   name: AppRoutes.homeSearchFilterDialog.name,
              //   pageBuilder: (_, state) {
              //     final params = state.extra as SearchProductFilterParams;
              //     return buildDialogWithDefaultTransition(
              //       FilterDialog(filters: params),
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   path: '/tfooooooooooo',
      //   pageBuilder: (_, state) {
      //     return MaterialPage(
      //       child: Scaffold(
      //         appBar: AppBar(
      //           title: Text('Title'),
      //         ),
      //         body: MaterialButton(  
      //           child: Text('show dialog'),
      //           onPressed: () {
      //             showGeneralDialog( 
      //               context: _,      
      //               pageBuilder: (_, __, ___) {
      //                 return Dialog( 
      //                   child: InkWell(
      //                     child: const Text('GOOO BACK'), 
      //                     onTap: (){ 
      //                       _.pop(); 
      //                     },
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //         ),
      //       ),
      //     );
      //   },
      // ),
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
