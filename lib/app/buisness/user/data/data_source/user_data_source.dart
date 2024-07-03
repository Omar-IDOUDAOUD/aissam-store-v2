import 'package:aissam_store_v2/app/buisness/user/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/user.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

abstract interface class UserDataSource {
  Future createUser(UserModel user);
  Future<UserModel> getUser(String userId);
  Future<UserModel> updateUser(UserModel user);
  Future deleteUser(String userId);
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore _fbFirestore;
  UserDataSourceImpl(this._fbFirestore);

  CollectionReference<UserModel> get _ref =>
      _fbFirestore.collection('users').withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  @override
  Future createUser(UserModel user) async {
    await _ref.doc(user.id).set(user);
  }

  @override
  Future deleteUser(String userId) {
   return  _ref.doc(userId).delete();
  }

  @override
  Future<UserModel> getUser(String userId) {
    return _ref.doc(userId).get().then((value) {
      throwIf(!value.exists, UserNotFound()); 
      return value.data()!;
    }); 
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    await _ref.doc(user.id).set(user); 
    return getUser(user.id);  
  }
}
