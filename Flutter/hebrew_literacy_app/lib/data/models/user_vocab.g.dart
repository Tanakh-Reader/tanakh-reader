// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vocab.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVocabAdapter extends TypeAdapter<UserVocab> {
  @override
  final int typeId = 0;

  @override
  UserVocab read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVocab()
      ..lexId = fields[0] as int?
      ..status = fields[1] as int?
      ..tapCount = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, UserVocab obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lexId)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.tapCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVocabAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
