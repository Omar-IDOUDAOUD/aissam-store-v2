import 'package:aissam_store_v2/app/presentation/authentication/views/sign_in.dart';
import 'package:aissam_store_v2/firebase_options.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator(); 
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child:  AissamStoreV2()));

}

class AissamStoreV2 extends StatelessWidget {
  const AissamStoreV2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SignInPage());
  }
}

//del: khir4592