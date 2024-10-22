import 'dart:async';

import 'package:aissam_store_v2/app/buisness/features/user/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/data/models/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extentions/firebase_query.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;
import 'package:get_it/get_it.dart';

abstract interface class UserDataSource {
  Future loadUser(fb.User authUser);
  Future createUser(UserModel user);
  Future<UserModel> getPublicUser(String userId);
  UserModel getUser(String userId);
  Future updateUser(UpdateUserParams params, String userId);
  Future deleteUser();
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore _fbFirestore;
  UserDataSourceImpl(this._fbFirestore);

  UserModel? _currentUser;

  CollectionReference<UserModel> _ref([AuthInfo? authInfo]) => _fbFirestore
      .collection(GlobalConstnts.userRemoteCollection)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) {
          return UserModel.fromJson(
            snapshot.data()!,
            authInfo,
          );
        },
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Future loadUser(fb.User authUser) async {
    final authInfo = authUser.isAnonymous
        ? null
        : AuthInfo(
            email: authUser.email,
            phoneNumber: authUser.phoneNumber,
          );
    try {
      _currentUser = await getPublicUser(authUser.uid, authInfo);
    } on UserNotFoundFailure {
      final resp = await CreateUserAfterAuth()
          .call(CreateUserAfterAuthParams(user: authUser));
      resp.leftMap((failure) => throw failure);
      _currentUser = await getPublicUser(authUser.uid, authInfo);
    }
  }

  @override
  Future createUser(UserModel user) async {
    await _ref().doc(user.id).set(user);
    // await loadUser();
  }

  @override
  Future deleteUser() {
    if (_currentUser == null) throw const UserNotLoadedFailure('E-8465');
    return _ref().doc(_currentUser!.id).delete();
  }

  @override
  Future<UserModel> getPublicUser(String userId, [AuthInfo? authInfo]) async {
    final res = await _ref(authInfo).doc(userId).get2();

    throwIf(!res.exists, const UserNotFoundFailure('E-8941'));
    return res.data()!;
  }

  @override
  Future updateUser(UpdateUserParams params, String userId) async {



    final newUser = getUser(userId).copyWith(
      firstName: params.firstName,
      lastName: params.lastName,
      currency: params.currency,
      language: params.language,
      photoUrl: params.photoUrl,
    );
    await _ref().doc(newUser.id).set(newUser);
  }

  @override
  UserModel getUser(String userId) {
    if (userId != _currentUser?.id) throw const UserNotLoadedFailure('E-8596');
    return _currentUser!;
  }
}
