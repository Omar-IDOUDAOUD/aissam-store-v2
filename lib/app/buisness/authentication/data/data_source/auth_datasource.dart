// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<AuthUser> signUp(String email, String password, String username);
  Future<AuthUser> signIn(String email, String password);
  Future logOut();
  Stream<AuthUser?> get stateChanges;
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  void _validatFields(String email, String pass, [String? fullName]) {
     AuthException? error;
    if (email.isEmpty) error = FirebaseAuthExceptions.missingEmail;

    if (fullName?.isEmpty ?? false) error = FirebaseAuthExceptions.missingFullName;

    if (pass.isEmpty) error = FirebaseAuthExceptions.missingPassword;

    

    if (error != null)
      throw error; 
  }

  @override
  Future logOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser> signIn(String email, String password) async {
    late final UserCredential credentials;
    try {
      _validatFields(email, password);
      credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      print("TEST1: $e"); 
      throw FirebaseAuthExceptions.find(e.code, e.message); 
    } catch (e) {
      print("TEST2: $e"); 
      throw FirebaseAuthExceptions.unknownError; 
    }
    final user = credentials.user!;
    return AuthUser(
        id: user.uid, email: user.email!, username: user.displayName);
  }

  @override
  Future<AuthUser> signUp(
      String email, String password, String username) async {
    late final UserCredential credentials;
    try {
      _validatFields(email, password, username);
      credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions.find(e.code, e.message); 
    } catch (e) {
      throw FirebaseAuthExceptions.unknownError; 
    }
    credentials.user!.updateDisplayName(username);
    final user = credentials.user!;
    return AuthUser(
        id: user.uid, email: user.email!, username: user.displayName);
  }

  @override
  Stream<AuthUser?> get stateChanges =>
      _firebaseAuth.authStateChanges().map<AuthUser>(
            (event) => AuthUser(
                id: event!.uid,
                email: event.email!,
                username: event.displayName),
          );
}
