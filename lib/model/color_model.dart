import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'color_model.g.dart';
@HiveType(typeId: 3)
class ColorModel {
  @HiveField(0)
  Color? color;
  @HiveField(1)
  int selectedIndex;

  ColorModel({required this.color, required this.selectedIndex});
}
