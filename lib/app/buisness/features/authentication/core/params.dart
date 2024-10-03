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

class UpdateAuthEmailParams{
  final String password; 
  final String newEmail;

  UpdateAuthEmailParams({required this.password, required this.newEmail}); 
}

enum AuthProviderType {
  password,
  emailLink, 
}
