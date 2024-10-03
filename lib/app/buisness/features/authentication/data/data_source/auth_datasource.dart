// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart'; 
import 'package:aissam_store_v2/app/buisness/features/user/core/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<User> signUp(String email, String password, String username);
  Future<User> signIn(String email, String password);
  Future<UserCredential> signInGoogle();
  Future<User> signInAnonymously();
  Future logOut();
  Future updateEmail(String email);
  Future updatePhoneNumber(String phoneNumber);
  Future updateLanguageCode(String languageCode);
  List<AuthProviderType> linkedProviders( );
  Stream<User?> get stateChanges;
  User get currentUser;
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAuthExceptions _firebaseAuthExceptions =
      FirebaseAuthExceptions();

  AuthDataSourceImpl(this._firebaseAuth);

  void _validatFields(String email, String pass, [String? fullName]) {
    AuthenticationFailure? error;
    if (email.isEmpty) error = _firebaseAuthExceptions.missingEmail;

    if (fullName?.isEmpty ?? false)
      error = _firebaseAuthExceptions.missingFullName;

    if (pass.isEmpty) error = _firebaseAuthExceptions.missingPassword;

    if (error != null) throw error;
  }

  

  @override
  Future logOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User> signIn(String email, String password) async {
    late final UserCredential credentials;
    try {
      _validatFields(email, password);
      credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _firebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw _firebaseAuthExceptions.unExceptedError('E-5480', e);
    }
    return credentials.user!;
  }

  @override
  Future<User> signUp(String email, String password, String fullname) async {
    late final UserCredential credentials;
    try {
      _validatFields(email, password, fullname);
      credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _firebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw _firebaseAuthExceptions.unExceptedError('E-5481', e);
    }
    credentials.user!.updateDisplayName(fullname);

    return credentials.user!;
  }

  @override
  Stream<User?> get stateChanges => _firebaseAuth.userChanges();

  @override
  Future<UserCredential> signInGoogle() async {
    late final UserCredential user;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = userCredential;
    } on FirebaseAuthException catch (e) {
      throw _firebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw _firebaseAuthExceptions.unExceptedError('E-5482', e);
    }

    return user;
  }

  @override
  User get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const NoUserLoggedInFailure('E-8512');
    return user;
  }

  @override
  Future updateEmail(String newEmail) { 
    return currentUser.verifyBeforeUpdateEmail(newEmail);
  }

  @override
  Future updateLanguageCode(String languageCode) {
    return _firebaseAuth.setLanguageCode(languageCode);
  }

  @override
  Future updatePhoneNumber(String phoneNumber) async {
    throw UnimplementedError();
    // _checkUserLogin();
    // final Completer completer = Completer();
    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   verificationCompleted: (creds) async {
    //     print('verificationCompleted start');
    //     await FirebaseAuth.instance.currentUser?.updatePhoneNumber(creds).then((_){
    //       completer.complete();
    //     }).catchError((_){
    //       completer.completeError(error);
    //     });
    //     print('verificationCompleted end');
    //   },
    //   verificationFailed: (e) {
    //     print('verificationFailed: $e');
    //     if (e.code == ){

    //     }
    //   },
    //   codeSent: (verificationId, forceResendingToken) {},
    //   forceResendingToken: 10,
    //   codeAutoRetrievalTimeout: (verificationId) {},
    // );
    // return  completer.future;
  }

  @override
  Future<User> signInAnonymously() async {
    late final UserCredential creds;
    try {
      creds = await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw _firebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw _firebaseAuthExceptions.unExceptedError('E-5487', e);
    }
    return creds.user!;
  }
  
  @override
  List<AuthProviderType> linkedProviders() {
     final providersString = currentUser.providerData
        .map((provider) => provider.providerId);
    final linkedProviders = <AuthProviderType>[];
    if (providersString.contains('password'))
      linkedProviders.add(AuthProviderType.password);
    if (providersString.contains('emailLink'))
      linkedProviders.add(AuthProviderType.emailLink);
    return linkedProviders;
  }
}
