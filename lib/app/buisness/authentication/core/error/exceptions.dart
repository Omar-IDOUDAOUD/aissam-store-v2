import 'package:aissam_store_v2/core/exceptions.dart';

class AuthException extends Exception2 {
  const AuthException({required this.code, this.message, this.causes})
      : super(msg: message ?? code);

  final String code;
  final String? message;
  final List<AuthErrorCause>? causes;
}

class AuthErrorCause {
  final AuthErrorSources source;
  final String? errorMessage;

  const AuthErrorCause({required this.source, this.errorMessage});
}

enum AuthErrorSources { emailField, passwordField, fullNameField , networkConnection }

abstract class FirebaseAuthExceptions {
  static AuthException find(String code, [message]) {
    final List<AuthException> values = [
      missingEmail,
      missingPassword,
      missingFullName,
      emailAlreadyInUse,
      invalidEmail,
      weakPassword,
      invalidCredential,
      userNotFound,
      wrongPassword,
      userDisabled,
      networkRequestFailed,
      unknownError,
    ];
    return values.singleWhere((element) => element.code == code,
        orElse: () => unExceptedError(code, message));
  }

  static const AuthException missingEmail = AuthException(
    code: 'missing-email',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.emailField, errorMessage: "Missing email")
    ],
  );

  static const AuthException missingPassword = AuthException(
    code: 'missing-password',
    causes: [
      AuthErrorCause(
        source: AuthErrorSources.passwordField,
        errorMessage: "Missing password",
      )
    ],
  );

  static const AuthException missingFullName = AuthException(
    code: 'missing-fullname',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.fullNameField,
          errorMessage: "Missing full name"),
    ],
  );

  static const AuthException emailAlreadyInUse = AuthException(
    code: 'email-already-in-use',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage:
              "The email address is already in use by another account")
    ],
  );

  static const AuthException invalidEmail = AuthException(
    code: 'invalid-email',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage: "The email address is not valid."),
    ],
  );

  static const AuthException weakPassword = AuthException(
    code: 'weak-password',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.passwordField,
          errorMessage: "The password is too weak.")
    ],
  );
  static const AuthException userNotFound = AuthException(
    code: 'user-not-found',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage: "No user found for that email.")
    ],
  );
  static const AuthException invalidCredential = AuthException(
    code: 'invalid-credential',
    message: "Email or password is not correct",
    causes: [
      AuthErrorCause(source: AuthErrorSources.emailField),
      AuthErrorCause(source: AuthErrorSources.passwordField)
    ],
  );
  static const AuthException wrongPassword = AuthException(
    code: 'wrong-password',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.passwordField,
          errorMessage: "Wrong password provided for that user.")
    ],
  );
  static const AuthException userDisabled = AuthException(
    code: 'user-disabled',
    causes: [
      AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage:
              "The user account has been disabled by an administrator.")
    ],
  );
  static const AuthException networkRequestFailed = AuthException(
    code: 'network-request-failed',
    causes: [
      AuthErrorCause(
        source: AuthErrorSources.networkConnection,
        errorMessage: 'no internet connection' , 
      ),
    ],
  );
  static const AuthException unknownError = AuthException(
    code: 'unknown-error',
    message: "An unknown error has occurred.",
  );

  static AuthException unExceptedError(code, [message]) => AuthException(
        code: code,
        message: message ?? "no message found",
      );
}
