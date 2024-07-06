import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/authentication/views/sign_in.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  User? _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            MaterialButton(
                child: const Text('read user'),
                onPressed: () {
                  final res = GetUser().call();
                  res.fold(
                    (fail) => print(fail),
                    (user) => setState(() {
                      _user = user;
                    }),
                  );
                }),
            Text((_user ?? 'null').toString()),
            MaterialButton(
              child: Text('sing in'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> SignInPage()));
              },
            ), MaterialButton(
              child: Text('logout'),
              onPressed: () {
                Logout().call(); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
