import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/todo_model.dart';

class NoteModel {
  String? title;
  String? content;
  ColorModel color;
  bool isBold;
  bool isItalic;
  String fontSize;
  DateTime datetime;
  bool isTodo;
  List<ToDoModel>? todo;
  List? images;

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
