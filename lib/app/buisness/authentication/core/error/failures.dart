
 
import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class AuthenticationFailure extends Failure {
  final String code;
  final String? errorMessage; 
  final List<AuthFieldError>? errorFields;
  AuthenticationFailure({required this.code,this.errorMessage, this.errorFields}): super(errorMessage ?? code);

  factory AuthenticationFailure.fromAuthException(AuthException exception) => AuthenticationFailure(errorMessage: exception.msg, code: exception.code, errorFields: exception.fields ); 
}

