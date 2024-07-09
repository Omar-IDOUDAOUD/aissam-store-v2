import 'dart:async';

import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/category.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_details.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/core/constants.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsFirestoreDatasourceImpl implements ProductsDatasource {
  final FirebaseFirestore _fbFirestore;
  ProductsFirestoreDatasourceImpl(this._fbFirestore);

  CollectionReference<ProductDetailsModel> _productsDetailsRef(
          ProductPreview Function(String id) productPreviewRequester) =>
      _fbFirestore
          .collection('product_details')
          .withConverter<ProductDetailsModel>(
            fromFirestore: (sn, _) => ProductDetailsModel.fromJson(
              sn.data()!,
              productPreviewRequester(sn.id),
            ),
            toFirestore: (product, _) => throw const Exception2(
                msg: 'toJson handler not available for ProducDetailsModel'),
          );

  CollectionReference<ProductPreviewModel> get _productPreviewsRef =>
      _fbFirestore
          .collection('product_previews')
          .withConverter<ProductPreviewModel>(
            fromFirestore: ProductPreviewModel.fromFirestore,
            toFirestore: (product, _) => throw const Exception2(
                msg: 'toJson handler not available for ProducPreviewModel'),
          );
  CollectionReference<CategoryModel> get _categoriesRef =>
      _fbFirestore.collection('categories').withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) =>
                CategoryModel.fromJson(snapshot.data()!),
            toFirestore: (product, _) => throw const Exception2(
                msg: 'toJson handler not available for CategoryModel'),
          );

  Future<DataPagination<T>> _getDataFromFirestore<T>(
      Query<T> q, DataPaginationParams paginationParams) async {
    q = q.limit(paginationParams.pageSize);
    if (paginationParams.indexIdentifierObj != null)
      q = q.startAfterDocument(paginationParams.indexIdentifierObj!);
    final res = await q
        .get()
        .timeout(GlobalConstnts.requestTimeoutDuration)
        .onError((TimeoutException ex, _) {
      throw NetworkException();
    });
    if (res.docs.isEmpty && res.metadata.isFromCache) throw NetworkException();
    final length = res.size;
    final lastDoc = res.docs.lastOrNull;

    return DataPagination<T>(
      items: res.docs.map((e) => e.data()).toList(),
      indexIdentifier: lastDoc,
      hasNextPage: length > BuisnessConsts.dataPaginationPageSize,
    );
  }

  @override
  Future<DataPagination<CategoryModel>> categories(
      GetCategoriesParams params) async {
    Query<CategoryModel> q = _categoriesRef.where('parent_category',
        isEqualTo: params.parentCategory);
    return await _getDataFromFirestore(q, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByCategory(
      GetProductsByCategoryParams params) {
    final q =
        _productPreviewsRef.where('categories', arrayContains: params.category);
    return _getDataFromFirestore(q, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> productsByPerformance(
      GetProductByPerformanceParams params) {
    Query<ProductPreviewModel> q = _productPreviewsRef;
    if (params.performance == ProductsPerformance.newArrivals)
      q = q.orderBy('created_at');
    if (params.performance == ProductsPerformance.bestSellers)
      q = q.orderBy('sales');
    if (params.performance == ProductsPerformance.topRated)
      q = q.orderBy('average_rating');
    return _getDataFromFirestore(q, params.paginationParams);
  }

  @override
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params) async {
    Query<ProductPreviewModel> q1 = _productPreviewsRef;
    if (params.categories != null)
      q1 = q1.where('categories', arrayContains: params.categories);
    if (params.maxPrice != null)
      q1 = q1.where('price', isLessThanOrEqualTo: params.maxPrice);
    if (params.minPrice != null)
      q1 = q1.where('price', isGreaterThanOrEqualTo: params.minPrice);
    //
    final res1 = await _getDataFromFirestore(q1, params.paginationParams);
    if (res1.items.isEmpty)
      return DataPagination(items: [], hasNextPage: false);
    Query<ProductDetailsModel> q2 = _productsDetailsRef((previewId) {
      return res1.items.singleWhere((e) => e.id == previewId);
    }).where(FieldPath.documentId, whereIn: res1.items.map((e) => e.id));
    q2 = q2.where('description',
        isLessThanOrEqualTo: params.keywords.split(' '));
    // q2 = q2.where('description',
    //     isLessThanOrEqualTo: '${params.keywords}\uf8ff');
    if (params.sizes != null) q2 = q2.where('size', isEqualTo: params.sizes);
    final res2 = await q2.get();
    //
    return res1.copyWith(
        items: res1.items
            .where(
              (e) => res2.docs
                  .map(
                    (e2) => e2.data().id,
                  )
                  .contains(e.id),
            )
            .toList());
  }

  
  @override
  Future<ProductDetailsModel> product(String id) {
    // TODO: implement product
    throw UnimplementedError();
  }
}
