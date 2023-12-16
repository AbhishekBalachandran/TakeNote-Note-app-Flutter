import 'package:flutter/material.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class ShowSnackbar {
  showSnackbar({context, content}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Color.fromARGB(255, 33, 22, 35),
      closeIconColor: ColorConstants.secondaryTxtColor,
      margin: EdgeInsets.all(10),
    ));
  }
}
