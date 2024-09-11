import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;

///TODO: ADD IMPORTANT FEATURE: every user should set only one seller to follow on the entire app, choose seller from profile tab
void main() async {
  print('==== AISSAM STORE V2 ====');
  // TODO: this for dev:
  // timeDilation = 2.5;
  //
  initServiceLocator();
  runApp(const ProviderScope(child: AissamStoreV2()));
}

class AissamStoreV2 extends StatelessWidget {
  const AissamStoreV2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashPage(),
          ),
          ShellRoute(
            builder: (context, state, child) => HomePage(child: child),
            routes: [
              GoRoute(path: '/', 
              builder: (_, __)=>_HomePage(), 
              ),
              GoRoute(path: '/settings', 
              builder: (_, __)=>_SettingsPage(), 
              ), 
              ShellRoute(

                builder: ,
                routes: [
                GoRoute(
                  path: '/c1', 
                ), 
              ],),
              
              
              // GoRoute(
              //   path: '/home',
              //   builder: (context, state) => const HomeBody(),
              //   routes: [
              //     GoRoute(
              //       path: '/discover_all_products',
              //       builder: (context, state) => DiscoverProductsSubScreen(
              //         routeParams:
              //             state.extra as DiscoverProductsSubScreenParams,
              //       ),

              //     ),
              //   ],
              // ),
               
            ],
          ),
        ],
      ),
      themeMode: ThemeMode.light,
      theme: ThemeBuilder.buildLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}




class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home page'))
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Settings page'))
    );
  }
}

class _CustomePage extends StatelessWidget {
  const  _CustomePage({super.key, required this.child});
  final Widget child;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custome Page')
      )
      body: child, 
    );
  }
}





// class TestPage extends StatelessWidget {
//   const TestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: CustomScrollView(
//         slivers: [
//           SliverAnimatedPaintExtent(
//               duration: Duration(seconds: 1), child: Text('data')
//               // SliverList.list(
//               //   children: [
//               //     // SliverAppBar(),
//               //     Text(
//               //       'data',
//               //     ),
//               //   ],
//               // ),
//               ),
//         ],
//       ),
//     );
//   }
// }
