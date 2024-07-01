


import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class AuthenticationFailure extends Failure {
  final String code;
  final String? message; 
  final List<AuthFieldError>? errorFields;
  AuthenticationFailure({required this.code,this.message, this.errorFields}): super(message ?? '');

  factory AuthenticationFailure.fromException(AuthException exception) => AuthenticationFailure(message: exception.message, code: exception.code, errorFields: exception.fields ); 
}