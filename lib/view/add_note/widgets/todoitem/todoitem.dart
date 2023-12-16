import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class ToDoItem extends StatelessWidget {
  final todoIndex;
  const ToDoItem({
    super.key,
    required this.todoIndex,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () {
            providers.handleTodoChange(todoIndex);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.black26,
          leading: Icon(
            provider.todoList[todoIndex].isDone ? Icons.task_alt : Icons.radio_button_unchecked,
            color: Colors.purple,
          ),
          title: Text(
             provider.todoList[todoIndex].todoText.toString(),
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.secondaryTxtColor,
                decoration:  provider.todoList[todoIndex].isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: IconButton(
            onPressed: () {
               providers.deleteTodoItem(todoIndex);
            },
            icon: Icon(
              Icons.close,
              color: ColorConstants.secondaryTxtColor,
            ),
          )),
    );
  }
}
