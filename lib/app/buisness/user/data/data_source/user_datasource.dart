import 'dart:async';

import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/utils/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;
import 'package:get_it/get_it.dart';

abstract interface class UserDataSource {
  Future loadUser();
  Future createUser(UserModel user);

  Future<UserModel> getPublicUser(String userId);

  /// throws [NoUserAvailableInException]
  UserModel getUser();
  Future updateUser(UpdateUserParams params);

  // /// throws []
  // Future checkEmailExistence(String email);
  // Future checkPhoneNumberExistence(String phoneNumber);
  Future deleteUser();
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore _fbFirestore;
  UserDataSourceImpl(this._fbFirestore);

  UserModel? _currentUser;

  CollectionReference<UserModel> get _ref => _fbFirestore
      .collection(GlobalConstnts.userRemoteCollection)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Future loadUser() async {
    final authUser = GetAuthUser().call().fold((err) => throw err, (r) => r);
    try {
      _currentUser = await getPublicUser(authUser.uid);
    } on UserNotFoundFailure {
      await createUser(
        UserModel(
          id: authUser.uid,
          displayName:
              authUser.displayName ?? 'Guest-${generateRandomString(5)}',
          authInfo: authUser.isAnonymous
              ? null
              : AuthInfo(
                  email: authUser.email,
                  phoneNumber: authUser.phoneNumber,
                ),
          photoUrl: authUser.photoURL,
        ),
      );
      _currentUser = await getPublicUser(authUser.uid);
    }
  }

  fb.User _getAuthUser() {
    final res = GetAuthUser().call();
    return res.fold(
      (failure) => throw failure,
      (authUser) => authUser,
    );
  }

  @override
  Future createUser(UserModel user) async {
    await _ref.doc(user.id).set(user);
    await loadUser();
  }

  @override
  Future deleteUser() {
    return _ref.doc(_getAuthUser().uid).delete();
  }

  @override
  Future<UserModel> getPublicUser(String userId) async {
    final res = await _ref.doc(userId).get();

    throwIf(!res.exists, const UserNotFoundFailure('E-8941'));
    return res.data()!;
  }

  @override
  Future updateUser(UpdateUserParams params) async {
    final newUser = getUser().copyWith(
      currency: params.currency,
      language: params.languageCode,
      photoUrl: params.photoUrl,
    );
    await _ref.doc(newUser.id).set(newUser);
  }

  @override
  UserModel getUser() {
    final authUser = GetAuthUser().call();
    authUser.fold(
      (_) {
        _currentUser = null;
      },
      (authUser) {
        if (authUser.uid != _currentUser?.id)
          throw const UserNotLoadedFailure('E-8596');
      },
    );
    throwIf(_currentUser == null, const NoUserLoggedInFailure('E-5236'));
    return _currentUser!;
  }
}
