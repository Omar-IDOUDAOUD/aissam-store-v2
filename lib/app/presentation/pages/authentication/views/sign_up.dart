import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/providers/providers.dart';
import 'package:aissam_store_v2/app/presentation/pages/authentication/views/widgets/textfield.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final TextEditingController _emailController = TextEditingController(text: 'duqshudiqsd@sfdgfg.sdf');
  late final TextEditingController _passwordController =
      TextEditingController(text: 'qsdqusdsldknf');
  late final TextEditingController _usernameController =
      TextEditingController(text: 'hello');


  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider); 
    final emailError = state.checkFieldErrored(AuthErrorSources.emailField) ;
    final passwordError = state.checkFieldErrored(AuthErrorSources.passwordField);
    final usernameError = state.checkFieldErrored(AuthErrorSources.fullNameField) ;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFieldWidget(
              controller: _emailController,
              hint: 'Email',
              error: emailError != null,
              errorText:emailError?.errorMessage ,
            ),
            TextFieldWidget(
              controller: _usernameController,
              hint: 'User Name',
              error: usernameError != null,
              errorText: usernameError?.errorMessage,
            ),
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
              onPressed: state.isLoading ? null : (){
                ref.read(authProvider.notifier).signUp(
                    _emailController.text,
                 _passwordController.text,
                  _usernameController.text,
                );
              },
              child:  const Text('Sing Up'),
            ),   
             MaterialButton(
              color: Colors.blueAccent,
              child: const Text('Sing In'),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const SignInPage())),
            ),
             MaterialButton(
              color: Colors.blueAccent,
              child: const Text('Sing with google'),
              onPressed: () async {
                final res = await SignInGoogle().call(); 
                print('result'); 
                res.fold((fail)=>print(fail), (res)=>print(res)); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
