import 'package:aissam_store_v2/app/buisness/user/domain/entities/payment_card.dart';
import 'package:aissam_store_v2/core/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentCardModel extends PaymentCard {
  PaymentCardModel({required super.id});

  Map2 toJson() {
    return {};
  }

  factory PaymentCardModel.fromFirestore(DocumentSnapshot<Map2> doc, _) {
    return PaymentCardModel(
      id: doc.id,
    );
  }
}