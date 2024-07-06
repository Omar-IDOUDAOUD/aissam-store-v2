import 'dart:async';

import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/errors/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart';
import 'package:aissam_store_v2/app/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;
import 'package:get_it/get_it.dart';

abstract interface class UserDataSource {
  Future loadUser();
  Future createUser(UserModel user);

  /// throws [UserNotFoundException]
  Future<UserModel> getPublicUser(String userId);

  /// throws [NoUserAvailableInException]
  UserModel getUser();
  Future<UserModel> updateUser(UserModel user);
  Future deleteUser();
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore _fbFirestore;
  UserDataSourceImpl(this._fbFirestore);

  UserModel? _currentUser;

  CollectionReference<UserModel> get _ref =>
      _fbFirestore.collection('users').withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  @override
  Future loadUser() async {
    final authUser = GetAuthUser().call();
    await authUser.fold((_) {
      throw NoUserAvailableException();
    }, (authUser) async {
      try {
        _currentUser ??= await getPublicUser(authUser.uid);
      } on UserNotFoundException catch (e) {
        createUser(
          UserModel( 
            id: authUser.uid,
            email: authUser.email!,
            fullName: authUser.displayName ?? 'no name',
            photoUrl: authUser.photoURL,
            phoneNumber: authUser.phoneNumber,
          ),
        );
      }
    });
  }

  fb.User _getAuthUser() {
    final res = GetAuthUser().call();
    return res.fold(
      (failure) => throw Exception2(msg: failure.message, error: failure.error),
      (authUser) => authUser,
    );
  }

  @override
  Future createUser(UserModel user) async {
    await _ref
        .doc(user.id)
        .set(user)
        .then((_) => _currentUser = user)
        .catchError((e) {
      throw e;
    });
  }

  @override
  Future deleteUser() {
    return _ref
        .doc(_getAuthUser().uid)
        .delete()
        .then((_) => _currentUser = null);
  }

  @override
  Future<UserModel> getPublicUser(String userId) {
    return _ref.doc(userId).get().then((value) {
      throwIf(!value.exists, UserNotFoundException());
      print('test 9, ${value.data()}');
      return value.data()!;
    }).catchError((_) {
      print('test 8');
    });
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    await _ref.doc(user.id).set(user).then((_) => _currentUser = user);
    return user;
  }

  @override
  UserModel getUser() {
    throwIf(_currentUser == null, NoUserAvailableException());
    return _currentUser!;
  }
}
