

import 'package:aissam_store_v2/app/buisness/authentication/core/params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/interfaces/usecase.dart';
import 'package:aissam_store_v2/app/presentation/authentication/providers/states.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>((ref)=>AuthController());

class AuthController extends StateNotifier<AuthState> {
  AuthController(): super(AuthState.initial());

  void signUp(String email, String password, String username) async {
    final usecase = SignUp();
    state = AuthState.loading();
    final res = await usecase.call(
        SignUpParams(email: email, password: password, username: username));
    res.fold(
      (authFailure) {
        return state = AuthState.error(authFailure);
      },
      (user) {
        return state = AuthState.sucess();
      },
    );
  }
  void signIn(String email, String password ) async {
    final usecase = SignIn();
    state = AuthState.loading();
    final res = await usecase.call(
        SignInParams(email: email, password: password ));
    res.fold(
      (authFailure) {
        return state = AuthState.error(authFailure);
      },
      (user) {
        return state = AuthState.sucess();
      },
    );
  }

  void logOut() async {
    final usecase = Logout();
    state = AuthState.loading(); 
    await usecase.call(NoParams()); 
    state = AuthState.sucess();
  }
}
