import 'dart:async';

import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/errors/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;
import 'package:get_it/get_it.dart';

abstract interface class UserDataSource {
  Future loadUser();
  Future createUser(UserModel user);

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
      _fbFirestore.collection(GlobalConstnts.userRemoteCollection).withConverter<UserModel>(
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
        _currentUser = await getPublicUser(authUser.uid);
      } on UserNotFoundException {
        await createUser(
          UserModel(
            id: authUser.uid,
            email: authUser.email!,
            fullName: authUser.displayName ?? 'no name',
            photoUrl: authUser.photoURL,
            phoneNumber: authUser.phoneNumber,
          ),
        );
        _currentUser = await getPublicUser(authUser.uid);
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
    await _ref.doc(user.id).set(user);
  }

  @override
  Future deleteUser() {
    return _ref.doc(_getAuthUser().uid).delete();
  }

  @override
  Future<UserModel> getPublicUser(String userId) async {
    final res = await _ref.doc(userId).get();
    throwIf(!res.exists, UserNotFoundException());
    return res.data()!;
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    await _ref.doc(user.id).set(user);
    return user;
  }

  @override
  UserModel getUser() {
    final authUser = GetAuthUser().call();
    authUser.fold(
      (_) {
        _currentUser = null;
      },
      (authUser) {
        if (authUser.uid != _currentUser?.id) throw UserNotLoadedException();
      },
    );
    throwIf(_currentUser == null, NoUserAvailableException());
    return _currentUser!;
  }
}
