import 'package:flutter/material.dart';

class ColorConstants {
  static Color bgColor = Color.fromARGB(255, 44, 37, 54);
  static Color primaryTxtColor = Color.fromARGB(255, 213, 211, 211);
  static Color secondaryTxtColor = Color.fromARGB(255, 160, 160, 160);
  static List<Color> bannerColor = [
    Colors.purple,
    Colors.indigo,
  ];
  static Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
