import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class ToDoItem extends StatelessWidget {
  final todoIndex;
  final noteIndex;
  const ToDoItem({
    super.key,
    required this.todoIndex,
    required this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            provider.notes[noteIndex].todo![todoIndex].isDone
                ? Icons.task_alt
                : Icons.radio_button_unchecked,
            color: Colors.purple,
            size: 15,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.25,
            child: Text(
              provider.notes[noteIndex].todo![todoIndex].todoText.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: provider.notes[noteIndex].isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontStyle: provider.notes[noteIndex].isItalic
                    ? FontStyle.italic
                    : FontStyle.normal,
                color: ColorConstants.secondaryTxtColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
