

class User {
  /// same as auth user id
  final String id;
  final String displayName; 
  /// if null then the user is anonymous
  final AuthInfo? authInfo;
  final String? photoUrl;
  final String? firstName;
  final String? lastName;
  final String? language;
  final String? currency;

  const User({
    required this.id,
    required this.displayName, 
    this.authInfo,
    this.photoUrl, 
    this.firstName,
    this.lastName,
    this.currency,
    this.language,
  });

 
  
}

class AuthInfo {
  final String? email;
  final String? phoneNumber;

  const AuthInfo({this.email, this.phoneNumber});
}
