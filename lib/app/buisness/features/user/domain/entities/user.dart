// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:aissam_store_v2/app/buisness/core/entities/currency.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/language.dart';

class User {
  /// same as auth user id
  final String id;
  final String displayName; 
  /// if null then the user is anonymous
  final AuthInfo? authInfo;
  final String? photoUrl;
  final String? firstName;
  final String? lastName;
  final Language language;
  final Currency? currency;

  const User({
    required this.id,
    required this.displayName, 
    this.authInfo,
    this.photoUrl, 
    this.firstName,
    this.lastName,
    this.currency,
    required this.language,
  });

 
  

  @override
  String toString() {
    return 'User(id: $id, displayName: $displayName, authInfo: $authInfo, photoUrl: $photoUrl, firstName: $firstName, lastName: $lastName, language: $language, currency: $currency)';
  }
}

class AuthInfo {
  final String? email;
  final String? phoneNumber;

  const AuthInfo({this.email, this.phoneNumber});

  @override
  String toString() => 'AuthInfo(email: $email, phoneNumber: $phoneNumber)';
}
