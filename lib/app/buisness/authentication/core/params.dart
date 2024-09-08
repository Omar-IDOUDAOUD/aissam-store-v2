class SignUpParams {
  final String email;
  final String password;
  final String username;

  SignUpParams(
      {required this.email, required this.password, required this.username});
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class UpdateAuthUserParams {
  final String? email;
  final String? phoneNumber;
  // final String? photoUrl;
  final String? languageCode;

  UpdateAuthUserParams(
      {this.languageCode, this.email, this.phoneNumber});
}
