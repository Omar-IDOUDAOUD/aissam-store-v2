import 'package:aissam_store_v2/app/buisness/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/wishlist/data/models/wishlist.dart';
import 'package:aissam_store_v2/app/core/constants.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WishlistRemoteDataSource {
  Future<DataPagination<WishlistItemModel>> wishList(
      DataPaginationParams params);
  Future<void> addItem(String id);
  Future<void> deleteItems(List<String> ids);
}

class WishlistRemoteDataSourceImpl extends WishlistRemoteDataSource {
  final FirebaseFirestore _fbFirestore;
  final MongoDb _mongoDb;

  WishlistRemoteDataSourceImpl(this._fbFirestore, this._mongoDb);

  late final CollectionReference<WishlistItemModel> _userCollection =
      _fbFirestore
          .collection(GlobalConstnts.userRemoteCollection)
          .doc(
            GetAuthUser().call().fold(
                  (er) => throw er,
                  (u) => u.uid,
                ),
          )
          .collection('wishlist')
          .withConverter(
            fromFirestore: WishlistItemModel.fromFirestore,
            toFirestore: (WishlistItemModel data, _) => data.toJson(),
          );

  @override
  Future<void> addItem(String id) {
    final doc = WishlistItemModel(
      createdAt: DateTime.now(),
      productId: id,
    );
    return _userCollection.doc().set(doc);
  }

  @override
  Future<void> deleteItems(List<String> ids) async {
    const batchSize = 8;

    for (var i = 0; i < ids.length; i += batchSize) {
      final batchIds = ids.sublist(
          i, i + batchSize > ids.length ? ids.length : i + batchSize);
      await Future.wait(batchIds.map((id) => _userCollection.doc(id).delete()));
    }
  }

  @override
  Future<DataPagination<WishlistItemModel>> wishList(
      DataPaginationParams params) async {
    var fq = _userCollection.limit(BuisnessConsts.dataPaginationPageSize);
    if (params.tokenObj != null) fq = fq.startAfterDocument(params.tokenObj);
    final sn = await fq.get2();
    final res = sn.docs.map(
      (elem) {
        return elem.data();
      },
    ).toList();

    final db = await _mongoDb.db;
    final coll = db.collection('products');
    final requestIds = res.map(
      (e) => ObjectId.fromHexString(e.productId),
    );

    final q = where
        .oneFrom('_id', requestIds.toList())
        .fields(ProductPreviewModel.fields);

    final mongoRes = await coll.find(q).toList().then(
          (value) => value.map(
            (e) => ProductPreviewModel.fromJson(e),
          ),
        );

    for (var i = 0; i < res.length; i++) {
      final item = res[i];
      final productPreview =
          mongoRes.where((element) => element.id == item.productId);
      if (productPreview.isEmpty) {
        res.removeAt(i);
        continue;
      }
      res[i]
        ..productPreview = productPreview.first
        ..productPreviewModel = productPreview.first;
    }
    return DataPagination.ready(
      params: params,
      items: res,
    );
  }
}
