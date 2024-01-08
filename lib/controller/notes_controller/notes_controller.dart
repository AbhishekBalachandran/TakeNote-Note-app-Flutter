import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/model/todo_model.dart';
import 'package:take_note/utils/databases/database.dart';

class NotesController with ChangeNotifier {
  List<NoteModel> notes = [];
  List<ToDoModel>? todoList = [];
  Color? selectedColor = color[0];
  int selectedColorIndex = 0;
  bool isGridView = true;
  bool isTodo = false;
  String fontSize = 'default';
  bool isBold = false;
  bool isItalic = false;
  List? images = [];
  bool isRecording = false;
  List recordings = [];

  // date formatting
  dateFormat(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final monthName = DateFormat.MMMM().format(dateTime);

    if (difference.inDays > 90) {
      return '${dateTime.day} ${monthName} ${dateTime.year}';
    } else if (difference.inDays > 1) {
      return '${monthName} ${dateTime.day}';
    } else if (difference.inDays > 0) {
      return 'yesterday';
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
    todoList!.add(ToDoModel(
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
    todoList!.removeAt(index);
    notifyListeners();
  }

// todo check and uncheck
  handleTodoChange(int todoIndex) {
    todoList![todoIndex].isDone = !todoList![todoIndex].isDone;
    notifyListeners();
  }

  // camera
  Future<void> pickCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        images?.add(XFile(image.path));
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    notifyListeners();
  }

  // gallery
  Future<void> pickGalleryImages() async {
    try {
      final pickedImage = await ImagePicker().pickMultiImage(imageQuality: 100);
      List<XFile> listImages = pickedImage;
      if (listImages.isNotEmpty) {
        for (var i = 0; i < listImages.length; i++) {
          images?.add(File(listImages[i].path));
        }
      }
      print('Images added length - ${images!.length}');
    } catch (e) {
      print('Error picking image: $e');
    }
    notifyListeners();
  }

  // removeImage
  removeImage(int imageIndex) {
    images!.removeAt(imageIndex);
    notifyListeners();
  }

  // switching grid view
  switchViewType() {
    isGridView = !isGridView;
    notifyListeners();
  }
}
