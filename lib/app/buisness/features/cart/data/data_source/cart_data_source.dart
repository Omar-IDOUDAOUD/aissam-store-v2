import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/data/models/cart_item.dart';
import 'package:aissam_store_v2/app/buisness/features/products/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_details.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/usecases/products_usecases.dart';
import 'package:aissam_store_v2/app/buisness/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/core/data_pagination.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CartDataSource {
  Future<DataPagination<CartItemModel>> cart(DataPaginationParams params);
  Future addItem(AddAndModifyCartItemParams item);
  Future removeItem(List<String> itemsIds);
  Future setQuantity(String itemId, bool inc);
  Future saveModifications(AddAndModifyCartItemParams params);
  Future updateData(List<({String itemId, String productId})> elements);
}

class CartDataSourceImpl implements CartDataSource {
  final FirebaseFirestore _fbFirestore;

  CartDataSourceImpl(this._fbFirestore);

  late final CollectionReference<CartItemModel> _userCollection = _fbFirestore
      .collection(GlobalConstnts.userRemoteCollection)
      .doc(
        GetAuthUser().call().fold(
              (er) => throw er,
              (u) => u.uid,
            ),
      )
      .collection('cart')
      .withConverter(
        fromFirestore: CartItemModel.fromFirestore,
        toFirestore: (CartItemModel data, _) => data.toFirestore(),
      );

  @override
  Future addItem(AddAndModifyCartItemParams item) async {
    final product = await GetProductMap()
        .call(
          ProductMapParams(fields: [
            'name',
            'price',
            'discount_percent',
            'discount_exp_date',
          ], ids: [
            item.productId!
          ]),
        )
        .then(
          (res) => res.fold((fail) {
            throw fail;
          }, (res) => res.firstOrNull),
        );

    if (product == null) throw const ProductNotFoundFailure();

    await _userCollection.add(
      CartItemModel(
        productId: item.productId!,
        quantity: item.quantity,
        color: item.color,
        size: item.size,
        discountPercent: product['discount_percent'],
        discountExpirationDate: product['discount_exp_date'],
        productTitle: product['name'],
        productPrice: product['price'],
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        lastDataUpdate: DateTime.now(),
      ),
    );
  }

  @override
  Future<DataPagination<CartItemModel>> cart(
      DataPaginationParams params) async {
    var q = _userCollection.limit(params.pageSize);
    if (params.tokenObj != null) q = q.startAfterDocument(params.tokenObj);
    final data = await q.get2();
    final res = data.docs.map((e) => e.data()).toList();
    return DataPagination.ready(
      params: params,
      items: res,
      tokenObj: data.docs.lastOrNull,
    );
  }

  @override
  Future setQuantity(String itemId, bool inc) {
    return _userCollection
        .doc(itemId)
        .update({'quantity': FieldValue.increment(inc ? 1 : -1)});
  }

  @override
  Future removeItem(List<String> itemsIds) async {
    const batchSize = 8;

    for (var i = 0; i < itemsIds.length; i += batchSize) {
      final batchIds = itemsIds.sublist(
          i, i + batchSize > itemsIds.length ? itemsIds.length : i + batchSize);
      await Future.wait(batchIds.map((id) => _userCollection.doc(id).delete()));
    }
  }

  @override
  Future saveModifications(AddAndModifyCartItemParams params) {
    return _userCollection.doc(params.itemId).update({
      'quantity': params.quantity,
      'size': params.size,
      'color': params.color,
    });
  }

  @override
  Future updateData(List<({String itemId, String productId})> elements) async {
    final newProductsData = await GetProductMap()
        .call(
          ProductMapParams(
            fields: [
              'name',
              'price',
              'discount_percent',
              'discount_exp_date',
            ],
            ids: elements.map((e) => e.productId).toList(),
          ),
        )
        .then(
          (res) => res.fold((fail) {
            throw fail;
          }, (res) => res),
        );

    const batchSize = 8;

    for (var i = 0; i < elements.length; i += batchSize) {
      final batchIds = elements.sublist(
          i, i + batchSize > elements.length ? elements.length : i + batchSize);
      await Future.wait(
        batchIds.map(
          (e) {
            final newData = newProductsData
                .where((product) => product['id'] == e.productId);
            if (newData.isEmpty) return Future.value();
            final newProduct = newData.first;
            return _userCollection.doc(e.itemId).update(
              {
                'product_title': newProduct['name'],
                'product_price': newProduct['price'],
                'discount': newProduct['discount'],
                'discount_exp_date': newProduct['discount_exp_date'],
                'last_data_update': DateTime.now(),
              },
            );
          },
        ),
      );
    }
  }
}
