// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      email: fields[2] as String,
      readingLevel: fields[3] as ReadingLevel,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.readingLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReadingLevelAdapter extends TypeAdapter<ReadingLevel> {
  @override
  final int typeId = 4;

  @override
  ReadingLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReadingLevel.beginner;
      case 1:
        return ReadingLevel.elementary;
      case 2:
        return ReadingLevel.intermediate;
      case 3:
        return ReadingLevel.advanced;
      case 4:
        return ReadingLevel.expert;
      default:
        return ReadingLevel.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, ReadingLevel obj) {
    switch (obj) {
      case ReadingLevel.beginner:
        writer.writeByte(0);
        break;
      case ReadingLevel.elementary:
        writer.writeByte(1);
        break;
      case ReadingLevel.intermediate:
        writer.writeByte(2);
        break;
      case ReadingLevel.advanced:
        writer.writeByte(3);
        break;
      case ReadingLevel.expert:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
