import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return MaterialApp(
      home: const SplashPage(),
      themeMode: ThemeMode.light,
      theme: ThemeBuilder.buildLightTheme(),
      debugShowCheckedModeBanner: false,
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
