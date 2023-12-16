import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/model/todo_model.dart';
import 'package:take_note/utils/databases/database.dart';

class NotesController with ChangeNotifier {
  List<NoteModel> notes = [];
  List<ToDoModel> todoList = [];
  Color? selectedColor = color[0];
  int selectedColorIndex = 0;
  bool gridview = true;

  // date formatting
  dateFormat(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final monthName = DateFormat.MMMM().format(dateTime);

    if (difference.inDays > 90) {
      return '${dateTime.day} ${monthName} ${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${monthName} ${dateTime.day}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  // add note
  addNote(NoteModel note) {
    notes.add(note);
    notifyListeners();
  }

  // add todo
  addTodo(String todo) {
    todoList.add(ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    notifyListeners();
  }

  // update note
  updateNote(int noteIndex, NoteModel note) {
    notes[noteIndex] = note;
    notifyListeners();
  }

  // delete note
  deleteNote(int noteIndex) {
    notes.removeAt(noteIndex);
    notifyListeners();
  }

  // delete todo
  deleteTodoItem(int index) {
    todoList.removeAt(index);
    notifyListeners();
  }

// todo check and uncheck
  handleTodoChange(int todoIndex) {
    todoList[todoIndex].isDone = !todoList[todoIndex].isDone;
    notifyListeners();
  }
}
