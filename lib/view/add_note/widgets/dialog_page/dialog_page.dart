import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';

class DialogPage extends StatelessWidget {
  final int imageIndex;
  const DialogPage({super.key, required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context, listen: false);
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                provider.removeImage(imageIndex);
                Navigator.pop(context);
              },
              tileColor: ColorConstants.bgColor,
              leading: Icon(
                CupertinoIcons.trash,
                color: ColorConstants.secondaryTxtColor,
              ),
              title: Text(
                'Delete',
                style: TextStyle(color: ColorConstants.secondaryTxtColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
