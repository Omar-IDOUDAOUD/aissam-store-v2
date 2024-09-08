import 'package:aissam_store_v2/app/core/errors/failures.dart';

class InvalidPhoneNumberFailure extends Failure {
  InvalidPhoneNumberFailure(super.code ) : super(message: 'Invalide phone number');
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure(super.code ) : super(message: 'Invalide email');
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(super.code, {super.message, super.error, this.causes});
  final List<AuthErrorCause>? causes;
}

class AuthErrorCause {
  final AuthErrorSources source;
  final String? errorMessage;

  const AuthErrorCause({required this.source, this.errorMessage});
}

enum AuthErrorSources {
  emailField,
  passwordField,
  fullNameField,
  networkConnection
}

class FirebaseAuthExceptions {
  AuthenticationFailure find(String code, [message]) {
    final List<AuthenticationFailure> values = [
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

  final AuthenticationFailure missingEmail = AuthenticationFailure(
    'missing-email',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.emailField, errorMessage: "Missing email")
    ],
  );

  final AuthenticationFailure missingPassword = AuthenticationFailure(
    'missing-password',
    causes: [
      const AuthErrorCause(
        source: AuthErrorSources.passwordField,
        errorMessage: "Missing password",
      )
    ],
  );

  final AuthenticationFailure missingFullName = AuthenticationFailure(
    'missing-fullname',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.fullNameField,
          errorMessage: "Missing full name"),
    ],
  );

  final AuthenticationFailure emailAlreadyInUse = AuthenticationFailure(
    'email-already-in-use',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage:
              "The email address is already in use by another account")
    ],
  );

  final AuthenticationFailure invalidEmail = AuthenticationFailure(
    'invalid-email',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage: "The email address is not valid."),
    ],
  );

  final AuthenticationFailure weakPassword = AuthenticationFailure(
    'weak-password',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.passwordField,
          errorMessage: "The password is too weak.")
    ],
  );
  final AuthenticationFailure userNotFound = AuthenticationFailure(
    'user-not-found',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage: "No user found for that email.")
    ],
  );
  final AuthenticationFailure invalidCredential = AuthenticationFailure(
    'invalid-credential',
    message: "Email or password is not correct",
    causes: [
      const AuthErrorCause(source: AuthErrorSources.emailField),
      const AuthErrorCause(source: AuthErrorSources.passwordField)
    ],
  );
  final AuthenticationFailure wrongPassword = AuthenticationFailure(
    'wrong-password',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.passwordField,
          errorMessage: "Wrong password provided for that user.")
    ],
  );
  final AuthenticationFailure userDisabled = AuthenticationFailure(
    'user-disabled',
    causes: [
      const AuthErrorCause(
          source: AuthErrorSources.emailField,
          errorMessage:
              "The user account has been disabled by an administrator.")
    ],
  );
  final AuthenticationFailure networkRequestFailed = AuthenticationFailure(
    'network-request-failed',
    causes: [
      const AuthErrorCause(
        source: AuthErrorSources.networkConnection,
        errorMessage: 'no internet connection',
      ),
    ],
  );
  final AuthenticationFailure unknownError = AuthenticationFailure(
    'unknown-error',
    message: "An unknown error has occurred.",
  );

  AuthenticationFailure unExceptedError(code, Object error) =>
      AuthenticationFailure(
        code,
        message: "Unexcepted error",
        error: error,
      );
}
