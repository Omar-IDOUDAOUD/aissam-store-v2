// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<User> signUp(String email, String password, String username);
  Future<User> signIn(String email, String password);
  Future<User> signInGoogle();
  Future logOut();
  Stream<User?> get stateChanges;
  User? get currentUser;
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth; 

  AuthDataSourceImpl(this._firebaseAuth);

  void _validatFields(String email, String pass, [String? fullName]) {
    AuthException? error;
    if (email.isEmpty) error = FirebaseAuthExceptions.missingEmail;

    if (fullName?.isEmpty ?? false)
      error = FirebaseAuthExceptions.missingFullName;

    if (pass.isEmpty) error = FirebaseAuthExceptions.missingPassword;

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
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw FirebaseAuthExceptions.unknownError;
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
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw FirebaseAuthExceptions.unknownError;
    }
    credentials.user!.updateDisplayName(fullname);
   
    return credentials.user!;
  }

  @override
  Stream<User?> get stateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInGoogle() async {
    late final User user;
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
      user = userCredential.user!;
       
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions.find(e.code, e.message);
    } catch (e) {
      throw FirebaseAuthExceptions.unknownError;
    }

    return user;
  }

  @override
  User? get currentUser {
    print('getting auth user: ${_firebaseAuth.currentUser}'); 
    return _firebaseAuth.currentUser;
  }
}
