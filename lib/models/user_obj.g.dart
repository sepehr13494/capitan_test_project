// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_obj.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserObjAdapter extends TypeAdapter<UserObj> {
  @override
  final int typeId = 0;

  @override
  UserObj read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserObj(
      id: fields[0] as int?,
      username: fields[1] as String,
      password: fields[2] as String,
      isAdmin: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserObj obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.isAdmin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserObjAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
