





import 'package:hive_flutter/hive_flutter.dart';

part 'cache_entity.g.dart';


@HiveType(typeId: 0)
class CacheEntity {
  
  @HiveField(0)
  final String key;
  
  @HiveField(1)
  /// should be a primitive type
  final Object data;
  
  @HiveField(2)
  final DateTime expirationDate;

  CacheEntity(
      {required this.key, required this.data, required this.expirationDate});
}
