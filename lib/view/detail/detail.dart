import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/model/todo_model.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/utils/databases/database.dart';
import 'package:take_note/view/add_note/widgets/todoitem/todoitem.dart';
import 'package:take_note/view/common_widgets/snackbar/snackbar.dart';

class Detail extends StatefulWidget {
  final noteIndex;
  const Detail({super.key, required this.noteIndex});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController todoController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isTodo = false;
  // final todoList = ToDoModel.todoList();

  @override
  void initState() {
    detailPageInitial();
    super.initState();
  }

  detailPageInitial() {
    Provider.of<NotesController>(context, listen: false).selectedColor =
        Provider.of<NotesController>(context, listen: false)
            .notes[widget.noteIndex]
            .color
            .color;
    Provider.of<NotesController>(context, listen: false).selectedColorIndex =
        Provider.of<NotesController>(context, listen: false)
            .notes[widget.noteIndex]
            .color
            .selectedIndex;
    titleController.text = Provider.of<NotesController>(context, listen: false)
        .notes[widget.noteIndex]
        .title
        .toString();
    contentController.text =
        Provider.of<NotesController>(context, listen: false)
            .notes[widget.noteIndex]
            .content
            .toString();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);

    return Scaffold(
      backgroundColor: provider.selectedColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: provider.selectedColor,
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                providers.updateNote(
                    widget.noteIndex,
                    NoteModel(
                        color: ColorModel(
                            color: provider.selectedColor,
                            selectedIndex: provider.selectedColorIndex),
                        isBold: false,
                        isItalic: false,
                        datetime: DateTime.now()));
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: ColorConstants.secondaryTxtColor, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          isTodo
              ? Expanded(
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            controller: titleController,
                            autofocus: false,
                            cursorColor: Color.fromARGB(255, 157, 81, 255),
                            cursorWidth: 2,
                            style: TextStyle(
                                color: ColorConstants.primaryTxtColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Input Title',
                                hintStyle: TextStyle(
                                    color: ColorConstants.primaryTxtColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      // for (ToDoModel todo in todoList)
                      //   ToDoItem(
                      //     todo: todo,
                      //     onTodoChanged: handleTodoChange,
                      //     onDeleteTodo: deleteTodoItem,
                      //   ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: todoController,
                              cursorColor: Color.fromARGB(255, 157, 81, 255),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add todo',
                                  hintStyle: TextStyle(
                                      color: ColorConstants.secondaryTxtColor)),
                              style: TextStyle(
                                  color: ColorConstants.secondaryTxtColor),
                            ),
                          ),
                          trailing: InkWell(
                            // onTap: () {
                            //   addTodo(todoController.text);
                            //   todoController.clear();
                            // },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: ColorConstants.bannerColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: ColorConstants.secondaryTxtColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              : Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: width * 0.5,
                              child: TextField(
                                controller: titleController,
                                textAlign: TextAlign.center,
                                autofocus: false,
                                cursorColor: Color.fromARGB(255, 157, 81, 255),
                                cursorWidth: 2,
                                style: TextStyle(
                                    color: ColorConstants.primaryTxtColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Input Title',
                                    hintStyle: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: contentController,
                        cursorColor: Color.fromARGB(255, 157, 81, 255),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type something here...',
                            hintStyle: TextStyle(
                                color: ColorConstants.secondaryTxtColor,
                                fontSize: 20)),
                        style: TextStyle(
                            color: ColorConstants.secondaryTxtColor,
                            fontSize: 20),
                        minLines: 1,
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: width * 0.7,
              child: Center(
                child: Text(
                  'Edited on ${provider.notes[widget.noteIndex].datetime.day} - ${provider.notes[widget.noteIndex].datetime.month} - ${provider.notes[widget.noteIndex].datetime.year}',
                  style: TextStyle(color: ColorConstants.secondaryTxtColor),
                ),
              ),
            ),
          ]),
          Container(
            decoration: BoxDecoration(color: provider.selectedColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: isTodo
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => Container(
                                        height: height * 0.36,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: ColorConstants.bgColor),
                                        child: Column(children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.photo_camera,
                                              color: ColorConstants
                                                  .secondaryTxtColor,
                                            ),
                                            title: Text(
                                              'Take photo',
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .primaryTxtColor,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.image_outlined,
                                              color: ColorConstants
                                                  .secondaryTxtColor,
                                            ),
                                            title: Text(
                                              'Add image',
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .primaryTxtColor,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.mic_outlined,
                                              color: ColorConstants
                                                  .secondaryTxtColor,
                                            ),
                                            title: Text(
                                              'Recording',
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .primaryTxtColor,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => setState(() {
                                              isTodo = true;
                                              Navigator.pop(context);
                                            }),
                                            child: ListTile(
                                              leading: Icon(
                                                CupertinoIcons
                                                    .list_bullet_indent,
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                              ),
                                              title: Text(
                                                'Tick  boxes',
                                                style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryTxtColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                    color: ColorConstants.secondaryTxtColor,
                                  ),
                                )),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  padding: EdgeInsets.all(10),
                                  height: height * 0.2,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.bgColor),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Color',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants
                                                    .secondaryTxtColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // list of colors
                                    Container(
                                      height: 60,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: color.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            providers.selectedColor =
                                                color[index];
                                            providers.selectedColorIndex =
                                                index;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: color[index],
                                                  border: Border.all(
                                                      color: ColorConstants
                                                          .secondaryTxtColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: index == 0
                                                  ? provider.selectedColorIndex ==
                                                          index
                                                      ? Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 30,
                                                            color: ColorConstants
                                                                .secondaryTxtColor,
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Icon(
                                                            Icons
                                                                .format_color_reset_outlined,
                                                            size: 30,
                                                            color: ColorConstants
                                                                .secondaryTxtColor,
                                                          ),
                                                        )
                                                  : provider.selectedColorIndex ==
                                                          index
                                                      ? Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 30,
                                                            color: ColorConstants
                                                                .secondaryTxtColor,
                                                          ),
                                                        )
                                                      : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.palette_outlined,
                              size: 28,
                              color: ColorConstants.secondaryTxtColor,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.bgColor),
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants
                                                    .secondaryTxtColor),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .secondaryTxtColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Icon(
                                                Icons.format_size,
                                                size: 18,
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .secondaryTxtColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Icon(
                                                Icons.format_size,
                                                size: 22,
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .secondaryTxtColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Icon(
                                                Icons.format_size,
                                                size: 26,
                                                color: ColorConstants
                                                    .secondaryTxtColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        color: ColorConstants.secondaryTxtColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorConstants
                                                      .secondaryTxtColor),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Center(
                                            child: Icon(
                                              Icons.format_bold,
                                              color: ColorConstants
                                                  .secondaryTxtColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorConstants
                                                      .secondaryTxtColor),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Center(
                                            child: Icon(
                                              Icons.format_italic,
                                              color: ColorConstants
                                                  .secondaryTxtColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.text_format,
                              size: 32,
                              color: ColorConstants.secondaryTxtColor,
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              providers.deleteNote(widget.noteIndex);

                              ShowSnackbar().showSnackbar(
                                  content: 'Note deleted successfully',
                                  context: context);
                            },
                            icon: Icon(
                              CupertinoIcons.trash,
                              size: 26,
                              color: ColorConstants.secondaryTxtColor,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.ios_share,
                          size: 28,
                          color: ColorConstants.secondaryTxtColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleTodoChange(ToDoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // void addTodo(String todo) {
  //   setState(() {
  //     todoList.add(ToDoModel(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         todoText: todo));
  //   });
  // }

  // void deleteTodoItem(String id) {
  //   setState(() {
  //     todoList.removeWhere((element) => element.id == id);
  //   });
  // }
}
