import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/config/routing/config.dart';
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
      routerConfig: AppRoutingConfig.router,
      themeMode: ThemeMode.light,
      theme: ThemeBuilder.buildLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class _CustomPage extends StatelessWidget {
//   const _CustomPage({super.key, required this.child});
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: child,
//         ),
//         Container(
//           height: 50,
//           width: 200,
//           child: Center(child: Text('HEEEELLO')),
//         )
//       ],
//     );
//   }
// }

// class _HomePage extends StatelessWidget {
//   const _HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             MaterialButton(
//               child: const Text('Go Products page'),
//               onPressed: () {
//                 context.go('/products');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Go Details page'),
//               onPressed: () {
//                 context.go('/products/details');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push Details page'),
//               onPressed: () {
//                 context.push('/products/details');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Go Settings page'),
//               onPressed: () {
//                 context.push('/settings');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProductsPage extends StatelessWidget {
//   const _ProductsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             MaterialButton(
//               child: const Text('Go Details page'),
//               onPressed: () {
//                 context.go('/products/details');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push Details page'),
//               onPressed: () {
//                 context.push('/products/details');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProductsDetailsPage extends StatelessWidget {
//   const _ProductsDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products details page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             MaterialButton(
//               child: const Text('Pop'),
//               onPressed: () {
//                 context.pop();
//               },
//             ),
//             MaterialButton(
//               child: const Text('Go Home page'),
//               onPressed: () {
//                 context.go('/');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push Home page'),
//               onPressed: () {
//                 context.push('/');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Go Products page'),
//               onPressed: () {
//                 context.go('/products');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push Products page'),
//               onPressed: () {
//                 context.push('/products');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push replacement Products page'),
//               onPressed: () {
//                 context.pushReplacement('/products');
//               },
//             ),
//             MaterialButton(
//               child: const Text('replace Products page'),
//               onPressed: () {
//                 context.replace('/products');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SettingsPage extends StatelessWidget {
//   const _SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             MaterialButton(
//               child: const Text('Go Home page'),
//               onPressed: () {
//                 context.go('/');
//               },
//             ),
//             MaterialButton(
//               child: const Text('Push Home page'),
//               onPressed: () {
//                 context.push('/');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
 
 




