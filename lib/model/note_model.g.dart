// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      title: fields[0] as String?,
      content: fields[1] as String?,
      color: fields[2] as ColorModel,
      isBold: fields[3] as bool,
      isItalic: fields[4] as bool,
      fontSize: fields[5] as String,
      datetime: fields[6] as DateTime,
      isTodo: fields[7] as bool,
      images: (fields[9] as List?)?.cast<dynamic>(),
    )..todo = (fields[8] as List?)?.cast<ToDoModel>();
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.isBold)
      ..writeByte(4)
      ..write(obj.isItalic)
      ..writeByte(5)
      ..write(obj.fontSize)
      ..writeByte(6)
      ..write(obj.datetime)
      ..writeByte(7)
      ..write(obj.isTodo)
      ..writeByte(8)
      ..write(obj.todo)
      ..writeByte(9)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
