import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class ToDoItemChecked extends StatelessWidget {
  final todoIndex;
  const ToDoItemChecked({
    super.key,
    required this.todoIndex,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: !provider.todoList![todoIndex].isDone
          ? ListTile(
              onTap: () {
                providers.handleTodoChange(todoIndex);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tileColor: Colors.black26,
              leading: Icon(
                provider.todoList![todoIndex].isDone
                    ? Icons.task_alt
                    : Icons.radio_button_unchecked,
                color: Colors.purple,
              ),
              title: Text(
                provider.todoList![todoIndex].todoText.toString(),
                style: TextStyle(
                    fontSize: provider.fontSize == 'small'
                        ? 18
                        : provider.fontSize == 'large'
                            ? 28
                            : 22,
                    fontWeight:
                        provider.isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle:
                        provider.isItalic ? FontStyle.italic : FontStyle.normal,
                    color: ColorConstants.secondaryTxtColor,
                    decoration: provider.todoList![todoIndex].isDone
                        ? TextDecoration.lineThrough
                        : null),
              ),
              trailing: IconButton(
                onPressed: () {
                  providers.deleteTodoItem(todoIndex);
                },
                icon: Icon(
                  Icons.close,
                  color: ColorConstants.secondaryTxtColor,
                ),
              ))
          : SizedBox(),
    );
  }
}

class ToDoItemUnChecked extends StatelessWidget {
  final todoIndex;
  const ToDoItemUnChecked({
    super.key,
    required this.todoIndex,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: provider.todoList![todoIndex].isDone
          ? ListTile(
              onTap: () {
                providers.handleTodoChange(todoIndex);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tileColor: Colors.black26,
              leading: Icon(
                provider.todoList![todoIndex].isDone
                    ? Icons.task_alt
                    : Icons.radio_button_unchecked,
                color: Colors.purple,
              ),
              title: Text(
                provider.todoList![todoIndex].todoText.toString(),
                style: TextStyle(
                    fontSize: provider.fontSize == 'small'
                        ? 18
                        : provider.fontSize == 'large'
                            ? 28
                            : 22,
                    fontWeight:
                        provider.isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle:
                        provider.isItalic ? FontStyle.italic : FontStyle.normal,
                    color: ColorConstants.secondaryTxtColor,
                    decoration: provider.todoList![todoIndex].isDone
                        ? TextDecoration.lineThrough
                        : null),
              ),
              trailing: IconButton(
                onPressed: () {
                  providers.deleteTodoItem(todoIndex);
                },
                icon: Icon(
                  Icons.close,
                  color: ColorConstants.secondaryTxtColor,
                ),
              ))
          : SizedBox(),
    );
  }
}
