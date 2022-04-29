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
      saved: fields[2] as bool,
      tapCount: fields[3] as int,
      latestTap: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Vocab obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lexId)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.saved)
      ..writeByte(3)
      ..write(obj.tapCount)
      ..writeByte(4)
      ..write(obj.latestTap);
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
