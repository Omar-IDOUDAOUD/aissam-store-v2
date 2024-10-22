import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/config/routing/config.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
