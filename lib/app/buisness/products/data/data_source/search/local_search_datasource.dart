import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/config/constants/global_consts.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:aissam_store_v2/services/caching/cache_manager.dart';

const int _maxHistoryLength = 20;

abstract class SearchLocalDataSource {
  // Cache data
  Future<void> cachePopularSuggestions(List<String> terms);
  Future<void> cachePopularProducts(List<PopularProductSearchType> products);
  Future<void> saveHistory(SearchProductFilterParams params);

  // Get data
  Future<List<String>> popularSuggestions();
  Future<List<PopularProductSearchType>> popularProducts();
  Future<List<SearchProductFilterParams>> history();

  Future<void> deleteHistoryItem(int index);
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final CacheManager _cacheManager;
  final LocalDb _localDb;

  SearchLocalDataSourceImpl(this._cacheManager, this._localDb);

  List<String> get _defPath => ['products/search'];

  String get _popularProducts => 'popular_products';
  @override
  Future<void> cachePopularProducts(
      List<PopularProductSearchType> products) async {
    await _cacheManager.addToDocument(
        path: _defPath,
        document: _popularProducts,
        cleanUpFirst: true,
        data: products.map(
          (e) => {
            'image': e.image,
            'name': e.name,
          },
        ));
  }

  String get _popularSuggestions => 'popular_suggestions';

  @override
  Future<void> cachePopularSuggestions(List<String> terms) async {
    await _cacheManager.addToDocument(
      path: _defPath,
      document: _popularSuggestions,
      cleanUpFirst: true,
      data: terms,
    );
  }

  @override
  Future<List<SearchProductFilterParams>> history() async {
    final box = await _localDb
        .openBox(path: [GlobalConstnts.userLocalDataDir], name: _history);
    final res = box.values.map<SearchProductFilterParams>(
      (e) {
        return SearchProductFilterParams(
          keywords: e['keywords'],
          categories: e['categories'],
          colorNames: e['colors'],
          sizes: e['sizes'],
          minPrice: e['min_price'],
          maxPrice: e['max_price'],
        );
      },
    ).toList();
    await box.close();
    return res;
  }

  @override
  Future<List<PopularProductSearchType>> popularProducts() async {
    final res = await _cacheManager.getDocument(
        document: _popularProducts, path: _defPath);
    if (res == null) throw NoCachedDataException();
    return List<PopularProductSearchType>.from(
        res.values.map<PopularProductSearchType>(
      (e) => (
        name: e['name'],
        image: e['image'],
      ),
    ));
  }

  @override
  Future<List<String>> popularSuggestions() async {
    final res = await _cacheManager.getDocument(
        document: _popularSuggestions, path: _defPath);
    if (res == null) throw NoCachedDataException();
    return List<String>.from(res.values);
  }

  String get _history => 'history';
  @override
  Future<void> saveHistory(SearchProductFilterParams params) async {
    final box = await _localDb
        .openLazyBox(path: [GlobalConstnts.userLocalDataDir], name: _history);
    if (box.length >= _maxHistoryLength) await box.deleteAt(0);
    if (box.length > 0 &&
        (await box.getAt(box.length - 1))['keywords'] == params.keywords) {
      await box.close();
      return;
    }
    await box.add({
      'created_at': DateTime.now(),
      'keywords': params.keywords,
      'categories': params.categories,
      'min_price': params.minPrice,
      'max_price': params.maxPrice,
      'color': params.colorNames,
      'sizes': params.sizes,
    });
    await box.close();
  }

  @override
  Future<void> deleteHistoryItem(int index) async {
    final box = await _localDb
        .openLazyBox(path: [GlobalConstnts.userLocalDataDir], name: _history);
    await box.deleteAt(index);
    await box.close();
  }
}
