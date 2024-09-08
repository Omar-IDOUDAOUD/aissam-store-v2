import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/params.dart';
import 'package:aissam_store_v2/app/presentation/config/theme.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/splash/splash.dart';
import 'package:aissam_store_v2/config/routing/config.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'app/buisness/user/domain/usecases/user.dart';

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

class TestPage extends StatelessWidget {
  TestPage({super.key});

  var email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            onChanged: (str) {
              email = str;
            },
          ),
          MaterialButton(
            child: const Text('Sign Up'),
            onPressed: () async {
              final res = await SignUp().call(
                SignUpParams(
                    email: email, password: 'password', username: 'username'),
              );
              print(res);
            },
          ),
          MaterialButton(
            child: const Text('Update'),
            onPressed: () async {
              final res = await UpdateUser()
                  .call(
                    UpdateUserParams(
                      currency: '5555',
                      email: 'omar.idoudaoud1@gmail.com',
                    ),
                  )
                  .then(
                    (value) => value,
                  );
              print(res);
            },
          ),
        ],
      ),
    );
  }
}
