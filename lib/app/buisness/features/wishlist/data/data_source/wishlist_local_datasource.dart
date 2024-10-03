import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/features/wishlist/data/models/wishlist.dart';
import 'package:aissam_store_v2/app/buisness/core/constants/constants.dart';
import 'package:aissam_store_v2/app/buisness/core/data_pagination.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/core/global_consts.dart';
import 'package:aissam_store_v2/core/types.dart';
import 'package:aissam_store_v2/services/caching/cache_manager.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WishlistLocalDataSource {
  Future<void> cacheWishList(
      DataPaginationParams params, List<ProductPreviewModel> items);

  Future<DataPagination<WishlistItemModel>> wishList(
      DataPaginationParams params);
}

class WishlistLocalDataSourceImpl extends WishlistLocalDataSource {
  final FirebaseFirestore _fbFirestore;
  final CacheManager _cacheManager;

  WishlistLocalDataSourceImpl(this._fbFirestore, this._cacheManager);

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

  List<String> get _defPath => ['wishlist'];

  @override
  Future<DataPagination<WishlistItemModel>> wishList(
      DataPaginationParams params) async {
    var fq = _userCollection.limit(BuisnessConsts.dataPaginationPageSize);
    if (params.tokenObj != null) fq = fq.startAfterDocument(params.tokenObj);
    final sn = await fq.get2();
    final res = sn.docs
        .map(
          (elem) => elem.data(),
        )
        .toList();

    final List<ProductPreviewModel> localRes = await _cacheManager
        .getDocument(
      document: params.page.toString(),
      path: _defPath,
    )
        .then(
      (value) {
        if (value == null) throw const NoCachedDataFailure();
        final values = value.values;
        return values
            .map(
              (e) => ProductPreviewModel.fromCache(Map2.from(e)),
            )
            .toList();
      },
    );

    for (var i = 0; i < res.length; i++) {
      final item = res[i];
      final productPreview =
          localRes.where((element) => element.id == item.productId);
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

  @override
  Future<void> cacheWishList(
      DataPaginationParams params, List<ProductPreviewModel> items) async {
    await _cacheManager.addToDocument(
      cleanUpFirst: true,
      path: _defPath,
      document: params.page.toString(),
      data: items.map((e) => e.toCacheJson()),
    );
  }
}
