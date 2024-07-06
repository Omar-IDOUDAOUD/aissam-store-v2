import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/authentication/views/sign_in.dart';
import 'package:aissam_store_v2/app/presentation/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Duration(seconds: 5).delay().then((_) {
      GetAuthUser().call().fold((f) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SignInPage(),
          ),
        );
      }, (s) async {
        print('user gotted, ${s.email}');
        LoadUser().call().then((_) {
          _.fold((f) {
            print(f);
          }, (_) {
            print('user loaded'); 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute( 
                builder: (_) => TestPage(),
              ),
            );
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('loading')));
  }
}
