import 'dart:async';

import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreQueryGet2<T> on Query<T> {
  Future<QuerySnapshot<T>> get2() async {
    final ConnectionChecker connectionChecker = sl();
    late final QuerySnapshot<T> res;
    if (connectionChecker.currentState) {
      try {
        res = await get().timeout(GlobalConstnts.requestTimeoutDuration);
      } on TimeoutException {
        throw const NetworkFailure();
      }
    } else {
      res = await get(const GetOptions(source: Source.cache));
      if (res.size == 0) throw const NoCachedDataFailure();
    }
    return res;
  }
}

// extension FirestoreCollectionGet2<T> on CollectionReference<T> {
//   Future<QuerySnapshot<T>> get2() async {
//     final ConnectionChecker connectionChecker = sl();
//     late final QuerySnapshot<T> res;
//     if (connectionChecker.currentState) {
//       try {
//         res = await get().timeout(GlobalConstnts.requestTimeoutDuration);
//       } on TimeoutException {
//         throw const NetworkFailure();
//       }
//     } else {
//       res = await get(const GetOptions(source: Source.cache));
//       if (res.size == 0) throw const NoCachedDataFailure();
//     }
//     return res;
//   }
// }

extension FirestoreDocumentGet2<T> on DocumentReference<T> {
  Future<DocumentSnapshot<T>> get2() async {
    final ConnectionChecker connectionChecker = sl();
    late final DocumentSnapshot<T> res;
    if (connectionChecker.currentState) {
      try {
        res = await get().timeout(GlobalConstnts.requestTimeoutDuration);
      } on TimeoutException {
        throw const NetworkFailure();
      }
    } else {
      try {
        res = await get(const GetOptions(source: Source.cache));
      } on FirebaseException catch (e) {
        throw const NoCachedDataFailure();
      }
    }
    return res;
  }
}
