
import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/model/color_model.dart';
import 'package:take_note/model/note_model.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/utils/databases/database.dart';
import 'package:take_note/view/add_note/widgets/dialog_page/dialog_page.dart';
import 'package:take_note/view/add_note/widgets/todoitem/todoitem.dart';
import 'package:take_note/view/common_widgets/snackbar/snackbar.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController todoController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<NotesController>(context);
    final providers = Provider.of<NotesController>(context, listen: false);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        clearFun();
      },
      child: Scaffold(
        backgroundColor: provider.selectedColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorConstants.secondaryTxtColor),
          elevation: 0,
          backgroundColor: provider.selectedColor,
          actions: [
            Center(
              child: InkWell(
                onTap: () async {
                  if (provider.isTodo) {
                    // is todo
                    if (provider.todoList!.isNotEmpty) {
                      providers.addNote(NoteModel.todo(
                          title: titleController.text,
                          todo: provider.todoList,
                          color: ColorModel(
                              color: provider.selectedColor,
                              selectedIndex: provider.selectedColorIndex),
                          datetime: DateTime.now(),
                          isBold: provider.isBold,
                          isItalic: provider.isItalic,
                          fontSize: provider.fontSize,
                          isTodo: provider.isTodo));
                      ShowSnackbar().showSnackbar(
                          content: 'Note added successfully', context: context);
                      Navigator.pop(context);
                      clearFun();
                    } else {
                      ShowSnackbar().showSnackbar(
                          content: 'Please add atleast a todo',
                          context: context);
                    }
                  } else {
                    // not todo
                    if (contentController.text.isNotEmpty ||
                        provider.images!.isNotEmpty) {
                      providers.addNote(NoteModel(
                          title: titleController.text,
                          content: contentController.text,
                          color: ColorModel(
                              color: provider.selectedColor,
                              selectedIndex: provider.selectedColorIndex),
                          isBold: provider.isBold,
                          isItalic: provider.isItalic,
                          fontSize: provider.fontSize,
                          datetime: DateTime.now(),
                          isTodo: provider.isTodo,
                          images: provider.images));
                      ShowSnackbar().showSnackbar(
                          content: 'Note added successfully', context: context);
                      Navigator.pop(context);
                      clearFun();
                    } else {
                      ShowSnackbar().showSnackbar(
                          content: 'Empty note discarded', context: context);
                      Navigator.pop(context);
                      clearFun();
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: ColorConstants.secondaryTxtColor, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            provider.isTodo
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
                              textAlign: TextAlign.center,
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.todoList!.length,
                          itemBuilder: (context, index) => ToDoItemChecked(
                            todoIndex: index,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: todoController,
                                cursorColor: Color.fromARGB(255, 157, 81, 255),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add todo',
                                    hintStyle: TextStyle(
                                        color:
                                            ColorConstants.secondaryTxtColor)),
                                style: TextStyle(
                                    color: ColorConstants.secondaryTxtColor,
                                    fontSize: provider.fontSize == 'small'
                                        ? 18
                                        : provider.fontSize == 'large'
                                            ? 28
                                            : 22,
                                    fontWeight: provider.isBold
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontStyle: provider.isItalic
                                        ? FontStyle.italic
                                        : FontStyle.normal),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                if (todoController.text.isNotEmpty) {
                                  providers.addTodo(todoController.text);
                                  todoController.clear();
                                } else {
                                  ShowSnackbar().showSnackbar(
                                      content: 'Empty todo discarded',
                                      context: context);
                                }
                              },
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Checked items',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstants.secondaryTxtColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.todoList!.length,
                          itemBuilder: (context, index) => ToDoItemUnChecked(
                            todoIndex: index,
                          ),
                        ),
                      ],
                    ),
                  ))
                : Expanded(
                    child: SingleChildScrollView(
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
                                  padding: EdgeInsets.all(8),
                                  child: TextField(
                                    controller: titleController,
                                    textAlign: TextAlign.center,
                                    autofocus: false,
                                    cursorColor:
                                        Color.fromARGB(255, 157, 81, 255),
                                    cursorWidth: 2,
                                    style: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Input Title',
                                        hintStyle: TextStyle(
                                            color:
                                                ColorConstants.primaryTxtColor,
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
                                fontSize: provider.fontSize == 'small'
                                    ? 18
                                    : provider.fontSize == 'large'
                                        ? 28
                                        : 22,
                                fontWeight: provider.isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontStyle: provider.isItalic
                                    ? FontStyle.italic
                                    : FontStyle.normal),
                            minLines: 1,
                            maxLines: 10,
                          ),
                          // images
                          provider.images!.length == 1
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => FluidDialog(
                                          // Use a custom curve for the alignment transition
                                          alignmentCurve:
                                              Curves.easeInOutCubicEmphasized,
                                          // Setting custom durations for all animations.
                                          sizeDuration:
                                              const Duration(milliseconds: 300),
                                          alignmentDuration:
                                              const Duration(milliseconds: 600),
                                          transitionDuration:
                                              const Duration(milliseconds: 300),
                                          reverseTransitionDuration:
                                              const Duration(milliseconds: 50),
                                          // Here we use another animation from the animations package instead of the default one.
                                          transitionBuilder:
                                              (child, animation) =>
                                                  FadeScaleTransition(
                                            animation: animation,
                                            child: child,
                                          ),
                                          // Configuring how the dialog looks.
                                          defaultDecoration: BoxDecoration(
                                            color: ColorConstants.bgColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          rootPage: FluidDialogPage(
                                            builder: (context) =>
                                                DialogPage(imageIndex: 0),
                                            alignment: Alignment.topRight,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.memory(
                                      provider.images![0],
                                      height: 300,
                                      width: double.infinity,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: height * 0.7,
                                  child: MasonryGridView.count(
                                    itemCount: provider.images!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 3,
                                    itemBuilder: (context, index) => InkWell(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => FluidDialog(
                                            // Use a custom curve for the alignment transition
                                            alignmentCurve:
                                                Curves.easeInOutCubicEmphasized,
                                            // Setting custom durations for all animations.
                                            sizeDuration: const Duration(
                                                milliseconds: 300),
                                            alignmentDuration: const Duration(
                                                milliseconds: 600),
                                            transitionDuration: const Duration(
                                                milliseconds: 300),
                                            reverseTransitionDuration:
                                                const Duration(
                                                    milliseconds: 50),
                                            // Here we use another animation from the animations package instead of the default one.
                                            transitionBuilder:
                                                (child, animation) =>
                                                    FadeScaleTransition(
                                              animation: animation,
                                              child: child,
                                            ),
                                            // Configuring how the dialog looks.
                                            defaultDecoration: BoxDecoration(
                                              color: ColorConstants.bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            rootPage: FluidDialogPage(
                                              builder: (context) =>
                                                  DialogPage(imageIndex: index),
                                              alignment: Alignment.topRight,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Image.memory(
                                          provider.images![index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
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
                            child: provider.isTodo
                                ? SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) => StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setStateSheet) {
                                          return Container(
                                            height: height * 0.26,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: ColorConstants.bgColor),
                                            child: Column(children: [
                                              ListTile(
                                                onTap: () {
                                                  providers.pickCameraImage();
                                                  Navigator.pop(context);
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
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
                                                onTap: () {
                                                  providers.pickGalleryImages();
                                                  Navigator.pop(context);
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
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
                                              InkWell(
                                                onTap: () {
                                                  provider.isTodo = true;
                                                  Navigator.pop(context);
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
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
                                          );
                                        }),
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
                                  builder: (context) => StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter inBottomSetState) {
                                    return Container(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                inBottomSetState(() {
                                                  provider.selectedColor =
                                                      color[index];
                                                  provider.selectedColorIndex =
                                                      index;
                                                });
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                    );
                                  }),
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
                                  builder: (context) => StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setStateSheet) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.bgColor),
                                      padding: EdgeInsets.all(10),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              InkWell(
                                                onTap: () {
                                                  provider.fontSize = 'small';
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: provider
                                                                  .fontSize !=
                                                              'small'
                                                          ? Colors.transparent
                                                          : ColorConstants
                                                              .secondaryTxtColor,
                                                      border: provider
                                                                  .fontSize !=
                                                              'small'
                                                          ? Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor)
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.format_size,
                                                      size: 18,
                                                      color: provider
                                                                  .fontSize !=
                                                              'small'
                                                          ? ColorConstants
                                                              .secondaryTxtColor
                                                          : ColorConstants
                                                              .bgColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  provider.fontSize = 'default';
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: provider
                                                                  .fontSize !=
                                                              'default'
                                                          ? Colors.transparent
                                                          : ColorConstants
                                                              .secondaryTxtColor,
                                                      border: provider
                                                                  .fontSize !=
                                                              'default'
                                                          ? Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor)
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.format_size,
                                                      size: 22,
                                                      color: provider
                                                                  .fontSize !=
                                                              'default'
                                                          ? ColorConstants
                                                              .secondaryTxtColor
                                                          : ColorConstants
                                                              .bgColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  provider.fontSize = 'large';
                                                  setStateSheet(() {});
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: provider
                                                                  .fontSize !=
                                                              'large'
                                                          ? Colors.transparent
                                                          : ColorConstants
                                                              .secondaryTxtColor,
                                                      border: provider
                                                                  .fontSize !=
                                                              'large'
                                                          ? Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor)
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.format_size,
                                                      size: 26,
                                                      color: provider
                                                                  .fontSize !=
                                                              'large'
                                                          ? ColorConstants
                                                              .secondaryTxtColor
                                                          : ColorConstants
                                                              .bgColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(
                                            color: ColorConstants
                                                .secondaryTxtColor,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                provider.isBold =
                                                    !provider.isBold;
                                                setStateSheet(() {});
                                                setState(() {});
                                              },
                                              child: provider.isBold
                                                  ? Container(
                                                      width: 55,
                                                      height: 55,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstants
                                                              .secondaryTxtColor,
                                                          border: Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      45)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.format_bold,
                                                          size: 35,
                                                          color: ColorConstants
                                                              .bgColor,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.format_bold,
                                                          color: ColorConstants
                                                              .secondaryTxtColor,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                provider.isItalic =
                                                    !provider.isItalic;
                                                setStateSheet(() {});
                                                setState(() {});
                                              },
                                              child: provider.isItalic
                                                  ? Container(
                                                      width: 55,
                                                      height: 55,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstants
                                                              .secondaryTxtColor,
                                                          border: Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      45)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.format_italic,
                                                          size: 35,
                                                          color: ColorConstants
                                                              .bgColor,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: ColorConstants
                                                                  .secondaryTxtColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.format_italic,
                                                          color: ColorConstants
                                                              .secondaryTxtColor,
                                                        ),
                                                      ),
                                                    ),
                                            )
                                          ],
                                        )
                                      ]),
                                    );
                                  }),
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
                                ShowSnackbar().showSnackbar(
                                    content: 'Note discarded',
                                    context: context);
                                Navigator.pop(context);
                                clearFun();
                              },
                              icon: Icon(
                                CupertinoIcons.trash,
                                size: 26,
                                color: ColorConstants.secondaryTxtColor,
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: IconButton(
                              onPressed: () {
                                print(
                                    'Recordings length - ${provider.recordings.length}');
                              },
                              icon: Icon(
                                Icons.ios_share,
                                size: 28,
                                color: ColorConstants.secondaryTxtColor,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void clearFun() {
    titleController.clear();
    contentController.clear();
    todoController.clear();
    Provider.of<NotesController>(context, listen: false).selectedColor =
        color[0];
    Provider.of<NotesController>(context, listen: false).selectedColorIndex = 0;
    Provider.of<NotesController>(context, listen: false).isTodo = false;
    Provider.of<NotesController>(context, listen: false).todoList = [];
    Provider.of<NotesController>(context, listen: false).fontSize = 'default';
    Provider.of<NotesController>(context, listen: false).isBold = false;
    Provider.of<NotesController>(context, listen: false).isItalic = false;
    Provider.of<NotesController>(context, listen: false).images = [];
  }
}
