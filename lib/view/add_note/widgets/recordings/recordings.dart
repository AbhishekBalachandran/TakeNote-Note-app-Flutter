import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';

class AudioRecordings extends StatelessWidget {
  const AudioRecordings({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<NotesController>(context);
    return Container(
      height: height * 0.7,
      child: ListView.builder(
        itemCount: provider.recordings.length,
        itemBuilder: (context, index) => provider.recordings[index] != null
            ? Container(
                width: width * 0.5,
                height: 100,
                child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.play_arrow_sharp))),
              )
            : SizedBox(),
      ),
    );
  }
}
