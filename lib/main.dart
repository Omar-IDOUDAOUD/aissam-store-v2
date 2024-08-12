import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/app/presentation/test.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  print('==== AISSAM STORE V2 ====');
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
