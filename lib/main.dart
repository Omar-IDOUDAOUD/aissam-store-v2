import 'package:aissam_store_v2/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/presentation/splash/splash.dart';

void main()   {
  print('================================MAIN======================================='); 
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const ProviderScope(child: AissamStoreV2()));
}

class AissamStoreV2 extends StatelessWidget {
  const AissamStoreV2({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home: const SplashPage(),
      theme:ThemeData.dark(),
    );
  }
}
