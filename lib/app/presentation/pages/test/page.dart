import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/primary.dart';
import 'package:aissam_store_v2/app/presentation/config/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatelessWidget {
  const TestPage({
    super.key,
    // this.text, required this.redirectTo
  });
  // final String redirectTo;

  // final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test page'),
        actions: [
          IconButton(
            onPressed: () {
              Logout().call().then((_){
                _.map((_){
                  context.go(AppRoutes.auth.fullPath());
                });
              });
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              GetUser()
                  .call()
                  .fold((fail) => "User: $fail", (user) => 'User: $user'),
            ),
            Text(
              AuthLinkedProviders()
                  .call()
                  .fold((fail) => "Provider: $fail", (pr) => 'Provider: $pr'),
            ),
          ],
        ),
      ),
    );
  }
}
