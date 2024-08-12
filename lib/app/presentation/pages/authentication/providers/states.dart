import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final List<AuthErrorCause> errorFields;
  final String? errorMessage;
  final String? errorCode;

  AuthState(
      {required this.isLoading,
      this.errorMessage,
      List<AuthErrorCause>? errorFields,
      this.errorCode})
      : errorFields = errorFields ?? [];

  bool get success => errorMessage != null && !isLoading;

  AuthErrorCause? checkFieldErrored(AuthErrorSources field) {
    return errorFields
        .where((errorField) => errorField.source == field)
        .firstOrNull;
  }

  factory AuthState.initial() => AuthState(isLoading: false);
  factory AuthState.loading() => AuthState(isLoading: true);
  factory AuthState.sucess() => AuthState(isLoading: false);
  factory AuthState.error(AuthenticationFailure failure) => AuthState(
        isLoading: false,
        errorFields: failure.errorFields,
        errorMessage: failure.message,
        errorCode: failure.code,
      );

  @override
  List<Object?> get props => [isLoading, errorFields, errorMessage, errorCode];
}
