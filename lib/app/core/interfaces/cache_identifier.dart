abstract mixin class CacheIdentifier {
  String buildCacheKey();

  static String from(Object? object) => object.toString();
}
