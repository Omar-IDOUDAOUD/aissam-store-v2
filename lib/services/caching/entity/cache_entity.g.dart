// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheEntityAdapter extends   TypeAdapter<CacheEntity > {
  @override
  final int typeId = 0;

  @override
  CacheEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheEntity(
      key: fields[0] as String,
      data: fields[1] ,
      expirationDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.expirationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
