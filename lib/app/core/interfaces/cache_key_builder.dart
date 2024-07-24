abstract mixin class CacheKeyBuilder {
  String buildCacheKey();

  static String from(Object? object) => object.toString();
}
