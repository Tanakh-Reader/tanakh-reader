// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabAdapter extends TypeAdapter<Vocab> {
  @override
  final int typeId = 1;

  @override
  Vocab read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vocab(
      lexId: fields[0] as int,
      status: fields[1] as VocabStatus,
    )
      ..userUpdated = fields[2] as bool?
      ..saved = fields[3] as bool
      ..dateSaved = fields[4] as DateTime?
      ..wordInstanceIds = (fields[5] as List).cast<int>()
      ..definitions = (fields[6] as List).cast<String>()
      ..exported = fields[7] as bool
      ..tapCount = fields[8] as int
      ..latestTap = fields[9] as DateTime?
      ..glossTapCount = fields[10] as int;
  }

  @override
  void write(BinaryWriter writer, Vocab obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.lexId)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.userUpdated)
      ..writeByte(3)
      ..write(obj.saved)
      ..writeByte(4)
      ..write(obj.dateSaved)
      ..writeByte(5)
      ..write(obj.wordInstanceIds)
      ..writeByte(6)
      ..write(obj.definitions)
      ..writeByte(7)
      ..write(obj.exported)
      ..writeByte(8)
      ..write(obj.tapCount)
      ..writeByte(9)
      ..write(obj.latestTap)
      ..writeByte(10)
      ..write(obj.glossTapCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VocabStatusAdapter extends TypeAdapter<VocabStatus> {
  @override
  final int typeId = 2;

  @override
  VocabStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VocabStatus.unkown;
      case 1:
        return VocabStatus.learning;
      case 2:
        return VocabStatus.known;
      default:
        return VocabStatus.unkown;
    }
  }

  @override
  void write(BinaryWriter writer, VocabStatus obj) {
    switch (obj) {
      case VocabStatus.unkown:
        writer.writeByte(0);
        break;
      case VocabStatus.learning:
        writer.writeByte(1);
        break;
      case VocabStatus.known:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
