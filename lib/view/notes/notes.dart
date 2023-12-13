import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/view/add_note/add_note.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 10,
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
              Icons.note_add_outlined,
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
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Good Morning.',
                          style: TextStyle(
                              color: ColorConstants.primaryTxtColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Wake upColor.fromARGB(255, 44, 37, 54)',
                      style: TextStyle(
                        color: ColorConstants.secondaryTxtColor,
                        fontSize: 16,
                        height: 1.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Jan 25',
                          style: TextStyle(
                              color: ColorConstants.secondaryTxtColor,
                              fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
