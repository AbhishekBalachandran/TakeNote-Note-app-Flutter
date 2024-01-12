import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/model/todo_model.dart';
import 'package:take_note/view/splash/splash.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(ColorModelAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox<NoteModel>('noteBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'assets/fonts/Ubuntu/Ubuntu-Regular.ttf'),
        home: Splash(),
      ),
    );
  }
}
