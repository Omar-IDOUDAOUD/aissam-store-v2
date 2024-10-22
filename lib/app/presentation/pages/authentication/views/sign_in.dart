import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/sign_up.dart';
import 'package:aissam_store_v2/app/presentation/config/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/providers/providers.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/widgets/textfield.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignInPage> {
  late final TextEditingController _emailController =
      TextEditingController(text: 'duqshudiqsd@sfdgfg.sdf');
  late final TextEditingController _passwordController =
      TextEditingController(text: 'qsdqusdsldknf');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
  
    ref.listen(
      authProvider,
      (_, as) {
        print(as.success);
        as.success
          ? context.go(AppRoutes.test.fullPath())
          : null;
      },
    );
    final emailError = state.checkFieldErrored(AuthErrorSources.emailField);
    final passwordError =
        state.checkFieldErrored(AuthErrorSources.passwordField);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFieldWidget(
              controller: _emailController,
              hint: 'Email',
              error: emailError != null,
              errorText: emailError?.errorMessage,
            ),
            const SizedBox(height: 25),
            TextFieldWidget(
              controller: _passwordController,
              hint: 'Password',
              error: passwordError != null,
              errorText: passwordError?.errorMessage,
            ),
            const Spacer(),
            if (state.isLoading) const CircularProgressIndicator(),
            const Spacer(),
            if (state.errorMessage != null) Text(state.errorMessage!),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: state.isLoading
                  ? null
                  : () {
                      ref.read(authProvider.notifier).signIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                    },
              child: const Text('Sing In'),
            ),
            MaterialButton(
              color: Colors.blueAccent,
              child: const Text('Sing Up'),
              onPressed: () {
                context.go(AppRoutes.authSignUp.fullPath());
              },
            ),
            MaterialButton(
              color: Colors.blueAccent,
              child: const Text('Sing with google'),
              onPressed: () async {
                final res = await SignInGoogle().call();
                print('result');
                res.fold((fail) => print(fail), (res) {
                  context.go(AppRoutes.test.fullPath());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
