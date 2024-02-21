import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/todo_model.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? content;
  @HiveField(2)
  ColorModel color;
  @HiveField(3)
  bool isBold;
  @HiveField(4)
  bool isItalic;
  @HiveField(5)
  String fontSize;
  @HiveField(6)
  DateTime datetime;
  @HiveField(7)
  bool isTodo;
  @HiveField(8)
  List<ToDoModel>? todo;
  @HiveField(9)
  List<Uint8List>? images;

  NoteModel(
      {this.title,
      this.content,
      required this.color,
      required this.isBold,
      required this.isItalic,
      required this.fontSize,
      required this.datetime,
      required this.isTodo,
      this.images});

  NoteModel.todo(
      {this.title,
      required this.todo,
      required this.color,
      required this.datetime,
      required this.isBold,
      required this.isItalic,
      required this.fontSize,
      required this.isTodo});
}
