import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class DialogNotePage extends StatelessWidget {
  final int noteIndex;
  const DialogNotePage({super.key, required this.noteIndex});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.bgColor,
          borderRadius: BorderRadius.circular(10)),
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                provider.deleteNote(noteIndex);
                Navigator.pop(context);
              },
              title: Text(
                'Delete',
                style: TextStyle(color: ColorConstants.primaryTxtColor),
              ),
            ),
            ListTile(
              title: Text(
                'Share',
                style: TextStyle(color: ColorConstants.primaryTxtColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
