import 'package:flutter/material.dart';

class ColorConstants {
  static Color bgColor = Color.fromARGB(255, 44, 37, 54);
  static Color bgColor2 = Color.fromARGB(182, 16, 3, 18);
  static Color primaryTxtColor = Color.fromARGB(255, 213, 211, 211);
  static Color secondaryTxtColor = Color.fromARGB(255, 160, 160, 160);
  static Color purple = const Color.fromARGB(255, 63, 14, 71);
  static List<Color> bannerColor = [
    Colors.purple,
    Colors.indigo,
  ];
  static Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
