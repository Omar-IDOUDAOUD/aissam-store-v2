 
import 'package:equatable/equatable.dart';

class User extends Equatable {
  /// represents the user id given from auth
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber; 
  final String? currency;
  final String? language;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber, 
    this.currency,
    this.language,
  });

  @override
  List<Object?> get props =>
      [id, email, fullName, phoneNumber , currency, language];

  @override
  String toString() =>
      'User(id: $id, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, currency: $currency, language: $language)';
}
