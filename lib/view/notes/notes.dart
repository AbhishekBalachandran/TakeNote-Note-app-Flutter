import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:take_note/controller/notes_controller/notes_controller.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/view/add_note/add_note.dart';
import 'package:take_note/view/detail/detail.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

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
            child: Icon(CupertinoIcons.search),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  providers.gridview = !providers.gridview;
                },
                icon: Icon(provider.gridview
                    ? CupertinoIcons.rectangle_grid_1x2
                    : CupertinoIcons.rectangle_grid_2x2)),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.secondaryTxtColor),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Icon(
                  Icons.more_horiz_outlined,
                  size: 20,
                )),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ));
        },
        child: Container(
          width: 60,
          height: 60,
          child: Center(
            child: Icon(
              CupertinoIcons.pencil_outline,
              size: 30,
              color: ColorConstants.secondaryTxtColor,
            ),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xffDA44bb), Color(0xff8921aa)])),
        ),
      ),
      body: provider.notes.isNotEmpty
          ? provider.gridview
              // gridview
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: provider.notes[index].title != ''
                                          ? SizedBox(
                                              width: width * 0.3,
                                              child: Text(
                                                providers.notes[index].title
                                                    .toString(),
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .primaryTxtColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          : null),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width * 0.3,
                                      child: Text(
                                        providers.notes[index].content
                                            .toString(),
                                        style: TextStyle(
                                          color:
                                              ColorConstants.secondaryTxtColor,
                                          fontSize: 16,
                                          height: 1.5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 5,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${provider.dateFormat(providers.notes[index].datetime)}',
                                      style: TextStyle(
                                          color:
                                              ColorConstants.secondaryTxtColor,
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
