import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/test.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
      
      

      
  
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const ProviderScope(child: AissamStoreV2()));

  
}

class AissamStoreV2 extends StatelessWidget {
  const AissamStoreV2({super.key});



/// 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TestPage(),
      themeMode: ThemeMode.light,
      theme: ThemeBuilder.buildLightTheme(),
    );
  }
}
