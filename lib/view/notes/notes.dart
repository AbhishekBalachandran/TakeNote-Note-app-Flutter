import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/view/add_note/add_note.dart';
import 'package:take_note/view/detail/detail.dart';
import 'package:take_note/view/notes/widgets/todo.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        elevation: 0,
        toolbarHeight: 80,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Take',
                style: GoogleFonts.zeyada(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'NOTE',
                style: GoogleFonts.exo(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = ColorConstants.linearGradient))
          ]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  Provider.of<NotesController>(context, listen: false)
                          .notes
                          .isNotEmpty
                      ? print(
                          Provider.of<NotesController>(context, listen: false)
                              .notes[0]
                              .todo?[0]
                              .todoText)
                      : null;
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: ColorConstants.secondaryTxtColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  providers.switchViewType();
                },
                icon: Icon(
                  provider.isGridView == true
                      ? CupertinoIcons.rectangle_grid_1x2
                      : CupertinoIcons.rectangle_grid_2x2,
                  color: ColorConstants.secondaryTxtColor,
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(4),
          //   child: Center(
          //     child: Container(
          //       width: 25,
          //       height: 25,
          //       decoration: BoxDecoration(
          //           border: Border.all(color: ColorConstants.secondaryTxtColor),
          //           borderRadius: BorderRadius.circular(30)),
          //       child: Center(
          //           child: Icon(
          //         Icons.more_horiz_outlined,
          //         size: 20,
          //       )),
          //     ),
          //   ),
          // )
        ],
      ),
      floatingActionButton: SpeedDial(
        childMargin: EdgeInsets.all(25),
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: ColorConstants.purple,
        foregroundColor: ColorConstants.primaryTxtColor,
        buttonSize: Size(70, 70),
        visible: true,
        closeManually: false,
        curve: Curves.decelerate,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          // add images
          SpeedDialChild(
            child: Icon(CupertinoIcons.camera_circle_fill),
            shape: CircleBorder(),
            backgroundColor: Colors.orange,
            foregroundColor: ColorConstants.primaryTxtColor,
            label: 'Add Images',
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            labelBackgroundColor: ColorConstants.secondaryTxtColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(),
                  ));
              providers.pickGalleryImages();
            },
          ),

          // add todo
          SpeedDialChild(
            child: Icon(CupertinoIcons.check_mark_circled_solid),
            shape: CircleBorder(),
            backgroundColor: Colors.amber,
            foregroundColor: ColorConstants.primaryTxtColor,
            label: 'Add To-do',
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            labelBackgroundColor: ColorConstants.secondaryTxtColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(),
                  ));
              provider.isTodo = true;
            },
          ),

          // add note
          SpeedDialChild(
            child: Icon(CupertinoIcons.create),
            shape: CircleBorder(),
            backgroundColor: Colors.blueAccent,
            foregroundColor: ColorConstants.primaryTxtColor,
            label: 'Add Note',
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            labelBackgroundColor: ColorConstants.secondaryTxtColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(),
                  ));
            },
          ),
        ],
      ),
      body: provider.notes.isNotEmpty
          ? provider.isGridView
              // isGridView
              ? MasonryGridView.count(
                  padding: EdgeInsets.all(5),
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 3,
                  itemCount: provider.notes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(noteIndex: index),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  provider.notes[index].color.selectedIndex == 0
                                      ? Colors.black38
                                      : provider.notes[index].color.color,
                              borderRadius: BorderRadius.circular(20)),
                          child: provider.notes[index].isTodo
                              ? Column(
                                  children: [
                                    // title
                                    provider.notes[index].title != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: provider.notes[index]
                                                              .title !=
                                                          null
                                                      ? SizedBox(
                                                          width: width * 0.3,
                                                          child: Text(
                                                            providers
                                                                .notes[index]
                                                                .title
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: ColorConstants
                                                                    .primaryTxtColor,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )
                                                      : SizedBox()),
                                            ],
                                          )
                                        : SizedBox(),
                                    // to-dos
                                    SizedBox(
                                      width: width * 0.3,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: (provider
                                                    .notes[index].todo!.length >
                                                5
                                            ? 5
                                            : provider
                                                .notes[index].todo!.length),
                                        itemBuilder: (context, todoIndex) =>
                                            !provider.notes[index]
                                                    .todo![todoIndex].isDone
                                                ? ToDoItem(
                                                    todoIndex: todoIndex,
                                                    noteIndex: index,
                                                  )
                                                : SizedBox(),
                                      ),
                                    ),
                                    // date & time
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${provider.dateFormat(providers.notes[index].datetime)}',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    // image
                                    provider.notes[index].images == null ||
                                            provider.notes[index].images!
                                                    .length ==
                                                0
                                        ? SizedBox()
                                        : Container(
                                            child: Image.file(
                                              File(
                                                provider.notes[index]
                                                    .images![0]!.path,
                                              ),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                    // title
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (provider.notes[index]
                                                            .title !=
                                                        null &&
                                                    provider.notes[index]
                                                            .title !=
                                                        '')
                                                ? SizedBox(
                                                    width: width * 0.3,
                                                    child: Text(
                                                      providers
                                                          .notes[index].title
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: ColorConstants
                                                              .primaryTxtColor,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : SizedBox()),
                                      ],
                                    ),
                                    // content
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        (provider.notes[index].content !=
                                                    null &&
                                                provider.notes[index].content !=
                                                    '')
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    providers
                                                        .notes[index].content
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: ColorConstants
                                                          .secondaryTxtColor,
                                                      fontWeight: provider
                                                              .notes[index]
                                                              .isBold
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      fontStyle: provider
                                                              .notes[index]
                                                              .isItalic
                                                          ? FontStyle.italic
                                                          : FontStyle.normal,
                                                      fontSize: 16,
                                                      height: 1.5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 5,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    // date & time
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${provider.dateFormat(providers.notes[index].datetime)}',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                )

              // Listview
              : ListView.builder(
                  itemBuilder: (context, index) => Container(),
                )

          // If not is empty
          : Container(),
    );
  }
}
