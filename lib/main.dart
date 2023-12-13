import 'package:flutter/material.dart';
import 'package:take_note/view/notes/notes.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'assets/fonts/Ubuntu/Ubuntu-Regular.ttf'),
      home: Notes(),
    );
  }
}
