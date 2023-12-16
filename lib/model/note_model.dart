import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/todo_model.dart';

class NoteModel {
  String? title;
  String? content;
  ColorModel color;
  bool isBold;
  bool isItalic;
  DateTime datetime;
  ToDoModel? todo;

  NoteModel(
      {this.title,
      this.content,
      required this.color,
      required this.isBold,
      required this.isItalic,
      required this.datetime});

  NoteModel.todo(
      {required this.todo,
      required this.color,
      required this.datetime,
      required this.isBold,
      required this.isItalic});
}
