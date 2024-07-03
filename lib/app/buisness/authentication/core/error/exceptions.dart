class AuthException implements Exception {
  const AuthException({required this.code, this.message, this.fields});

  final String code;
  final String? message;
  final List<AuthFieldError>? fields;
}

class AuthFieldError {
  final AuthCredentialFields field;
  final String? errorMessage;

  const AuthFieldError({required this.field, this.errorMessage});
}

enum AuthCredentialFields { emailField, passwordField, fullNameField }

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
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.emailField, errorMessage: "Missing email")
    ],
  );

  static const AuthException missingPassword = AuthException(
    code: 'missing-password',
    fields: [
      AuthFieldError(
        field: AuthCredentialFields.passwordField,
        errorMessage: "Missing password",
      )
    ],
  );

  static const AuthException missingFullName = AuthException(
    code: 'missing-fullname',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.fullNameField,
          errorMessage: "Missing full name"),
    ],
  );

  static const AuthException emailAlreadyInUse = AuthException(
    code: 'email-already-in-use',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.emailField,
          errorMessage:
              "The email address is already in use by another account")
    ],
  );

  static const AuthException invalidEmail = AuthException(
    code: 'invalid-email',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.emailField,
          errorMessage: "The email address is not valid."),
    ],
  );
  
  static const AuthException weakPassword = AuthException(
    code: 'weak-password',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.passwordField,
          errorMessage: "The password is too weak.")
    ],
  );
  static const AuthException userNotFound = AuthException(
    code: 'user-not-found',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.emailField,
          errorMessage: "No user found for that email.")
    ],
  );
  static const AuthException invalidCredential = AuthException(
    code: 'invalid-credential',
    message: "Email or password is not correct",
    fields: [
      AuthFieldError(field: AuthCredentialFields.emailField),
      AuthFieldError(field: AuthCredentialFields.passwordField)
    ],
  );
  static const AuthException wrongPassword = AuthException(
    code: 'wrong-password',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.passwordField,
          errorMessage: "Wrong password provided for that user.")
    ],
  );
  static const AuthException userDisabled = AuthException(
    code: 'user-disabled',
    fields: [
      AuthFieldError(
          field: AuthCredentialFields.emailField,
          errorMessage:
              "The user account has been disabled by an administrator.")
    ],
  );
  static const AuthException networkRequestFailed = AuthException(
    code: 'network-request-failed',
    message:
        "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
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
