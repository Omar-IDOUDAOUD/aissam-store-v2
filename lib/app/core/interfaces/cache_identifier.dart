abstract mixin class CacheIdentifier {
  String buildCacheIdentifier();

  static String from(Object? object) => object.toString();
}
