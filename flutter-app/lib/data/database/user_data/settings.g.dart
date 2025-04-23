// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 6;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..theme = fields[0] as String
      ..readingTextSize = fields[1] as int
      ..readingTextFont = fields[2] as String
      ..showPhrase = fields[3] as bool
      ..showClause = fields[4] as bool
      ..showVerse = fields[5] as bool
      ..showParagraph = fields[6] as bool;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.readingTextSize)
      ..writeByte(2)
      ..write(obj.readingTextFont)
      ..writeByte(3)
      ..write(obj.showPhrase)
      ..writeByte(4)
      ..write(obj.showClause)
      ..writeByte(5)
      ..write(obj.showVerse)
      ..writeByte(6)
      ..write(obj.showParagraph);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
