import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/user/data/models/payment_card.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/utils/extentions/firebase_query.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class PaymentRemoteDatasource {
  Future<int> countCards();
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final FirebaseFirestore _fbFirestore;
  PaymentRemoteDatasourceImpl(this._fbFirestore);

  late final CollectionReference<PaymentCardModel> _ref = _fbFirestore
      .collection(GlobalConstnts.userRemoteCollection)
      .doc(
        GetAuthUser().call().fold(
              (er) => throw er,
              (u) => u.uid,
            ),
      )
      .collection('payment_cards')
      .withConverter(
        fromFirestore: PaymentCardModel.fromFirestore,
        toFirestore: (PaymentCardModel data, _) => data.toJson(),
      );
  @override
  Future<int> countCards() async {
    final res = await _ref.count().get2();

    if (res.count == null)
      throw const Failure('E-2275', message: "Can't get payment cards count");

    return res.count!;
  }
}
