import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/data/models/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/core/constants.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';
import 'package:aissam_store_v2/utils/extensions.dart';

const int _limitPopularProducts = 4;
const int _limitPopularSuggestions = 4;

abstract class SearchRemoteDataSource {
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params);

  /// if terms is null, most first 4 popular suggestions is returned
  Future<List<String>> suggestions([String? terms]);
  Future<List<PopularProductSearchType>> popularProducts();
  Future<void> markFirstProductClick(String id);
  Future<void> markSeachSuggestionClick(String terms);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final MongoDb _mongodb;

  SearchRemoteDataSourceImpl(this._mongodb);

  Future<DbCollection> _getCollection(String collactionName) async {
    final db = await _mongodb.db;
    return db.collection(collactionName);
  }

  Future<DbCollection> get _productsCollection => _getCollection('products');
  Future<DbCollection> get _searchTermsCollection =>
      _getCollection('search_terms');

  @override
  Future<void> markFirstProductClick(String id) async {
    final coll = await _productsCollection;
    await coll.updateOne(where.id2(id), modify.inc('search_clicks', 1));
  }

  @override
  Future<List<PopularProductSearchType>> popularProducts() async {
    final coll = await _productsCollection;
    final res = await coll
        .find(where
            .limit(_limitPopularProducts)
            .sortBy('search_clicks', descending: true))
        .toList();
    return res
        .map<PopularProductSearchType>(
          (e) => (
            image: e['image'],
            name: e['name'],
          ),
        )
        .toList();
  }

  @override
  Future<DataPagination<ProductPreviewModel>> searchProducts(
      SearchProductsParams params) async {
    final coll = await _productsCollection;
    final query = where
        .limit(BuisnessConsts.dataPaginationPageSize)
        .skip(params.paginationParams.tokenObj ?? 0)
        .fields(ProductPreviewModel.fields);
    final filters = params.filterParams;
    query.eq(r'$text', {r'$search': filters.keywords});
    if (filters.categories != null && filters.categories!.isNotEmpty)
      query.oneFrom('categories', filters.categories!);
    if (filters.sizes != null && filters.sizes!.isNotEmpty)
      query.oneFrom('sizes', filters.sizes!);
    if (filters.colorNames != null && filters.colorNames!.isNotEmpty)
      query.oneFrom('available_colors', filters.colorNames!);
    query.inRange(
        'price', filters.minPrice ?? 0, filters.maxPrice ?? double.infinity);

    final res = await coll.find(query).toList();
    return DataPagination.ready(
      items: res.map((e) => ProductPreviewModel.fromJson(e)).toList(),
      params: params.paginationParams,
      tokenObj: (params.paginationParams.tokenObj ?? 0) + res.length,
    );
  }

  @override
  Future<void> markSeachSuggestionClick(String terms) async {
    final coll = await _searchTermsCollection;
    await coll.updateOne(where.eq('terms', terms), modify.inc('clicks', 1));
  }

  @override
  Future<List<String>> suggestions([String? terms]) async {
    final coll = await _searchTermsCollection;
    final q = where
        .limit(_limitPopularSuggestions)
        .fields(['terms']).sortBy('clicks', descending: true);
    if (terms != null) q.match('terms', '.*$terms.*', caseInsensitive: true);
    final res = await coll.find(q).toList();
    return res.map<String>((e) => e['terms']).toList();
  }
}
