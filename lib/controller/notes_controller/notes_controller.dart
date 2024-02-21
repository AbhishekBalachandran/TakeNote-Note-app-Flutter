import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/model/todo_model.dart';
import 'package:take_note/utils/databases/database.dart';

class NotesController with ChangeNotifier {
  final Box<NoteModel> box = Hive.box<NoteModel>('noteBox');
  List<NoteModel> notes = [];
  List<ToDoModel>? todoList = [];
  Color? selectedColor = color[0];
  int selectedColorIndex = 0;
  bool isGridView = true;
  bool isTodo = false;
  String fontSize = 'default';
  bool isBold = false;
  bool isItalic = false;
  List<Uint8List>? images = [];
  bool isRecording = false;
  List recordings = [];
  List<NoteModel> filteredNotes = [];

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

  // get notes
  getNote() async {
    notes = await box.values.toList();
    notifyListeners();
  }

  // add note
  addNote(NoteModel note) async {
    await box.add(note);
    getNote();
    notifyListeners();
  }

  // add todo
  addTodo(String todo) {
    todoList!.add(ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    notifyListeners();
  }

  // update note
  updateNote(int noteIndex, NoteModel note) async {
    await box.putAt(noteIndex, note);
    getNote();
    notifyListeners();
  }

  // delete note
  deleteNote(int noteIndex) async {
    await box.deleteAt(noteIndex);
    getNote();
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
        var imageByte = await XFile(image.path).readAsBytes();
        images?.add(imageByte);
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
          var imageByte = await File(listImages[i].path).readAsBytes();
          images?.add(imageByte);
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
}
