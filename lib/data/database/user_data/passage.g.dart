// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassageAdapter extends TypeAdapter<Passage> {
  @override
  final int typeId = 5;

  @override
  Passage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Passage()
      ..passageId = fields[0] as int
      ..wordCount = fields[1] as int
      ..weight = fields[2] as num?
      ..startVsId = fields[3] as int?
      ..endVsId = fields[4] as int?
      ..bookId = fields[5] as int
      ..chapters = (fields[6] as List).cast<int>()
      ..startVs = fields[7] as int
      ..endVs = fields[8] as int
      ..isChapter = fields[9] as bool
      ..visited = fields[10] as bool
      ..completed = fields[11] as bool
      ..dateCompleted = fields[12] as DateTime?
      ..secondsToComplete = fields[13] as int?
      ..timesRead = fields[14] as int
      ..lexIds = (fields[15] as List).cast<int>()
      ..sampleText = fields[16] as List<String>?;
  }

  @override
  void write(BinaryWriter writer, Passage obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.passageId)
      ..writeByte(1)
      ..write(obj.wordCount)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.startVsId)
      ..writeByte(4)
      ..write(obj.endVsId)
      ..writeByte(5)
      ..write(obj.bookId)
      ..writeByte(6)
      ..write(obj.chapters)
      ..writeByte(7)
      ..write(obj.startVs)
      ..writeByte(8)
      ..write(obj.endVs)
      ..writeByte(9)
      ..write(obj.isChapter)
      ..writeByte(10)
      ..write(obj.visited)
      ..writeByte(11)
      ..write(obj.completed)
      ..writeByte(12)
      ..write(obj.dateCompleted)
      ..writeByte(13)
      ..write(obj.secondsToComplete)
      ..writeByte(14)
      ..write(obj.timesRead)
      ..writeByte(15)
      ..write(obj.lexIds)
      ..writeByte(16)
      ..write(obj.sampleText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
