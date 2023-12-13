import 'package:flutter/material.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/utils/databases/database.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.bgColor,
        leading: Icon(
          Icons.chevron_left,
          size: 30,
        ),
        title: Text(
          'Save',
          style: TextStyle(color: ColorConstants.secondaryTxtColor),
        ),
        titleSpacing: 0.2,
      ),
      body: Column(
        children: [
          Expanded(
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
                          textAlign: TextAlign.center,
                          autofocus: false,
                          cursorColor: ColorConstants.secondaryTxtColor,
                          cursorWidth: 2,
                          style: TextStyle(
                              color: ColorConstants.primaryTxtColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
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
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something here...',
                      hintStyle: TextStyle(
                          color: ColorConstants.secondaryTxtColor,
                          fontSize: 20)),
                  style: TextStyle(
                      color: ColorConstants.secondaryTxtColor, fontSize: 20),
                  minLines: 1,
                  maxLines: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
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
                                      color: ColorConstants.secondaryTxtColor,
                                    ),
                                    title: Text(
                                      'Take photo',
                                      style: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.image_outlined,
                                      color: ColorConstants.secondaryTxtColor,
                                    ),
                                    title: Text(
                                      'Add image',
                                      style: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.mic_outlined,
                                      color: ColorConstants.secondaryTxtColor,
                                    ),
                                    title: Text(
                                      'Recording',
                                      style: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.check_box_outlined,
                                      color: ColorConstants.secondaryTxtColor,
                                    ),
                                    title: Text(
                                      'Tick  boxes',
                                      style: TextStyle(
                                        color: ColorConstants.primaryTxtColor,
                                      ),
                                    ),
                                  ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      itemBuilder: (context, index) => Padding(
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
                                                  BorderRadius.circular(40)),
                                          child: index == 0
                                              ? Center(
                                                  child: Icon(
                                                    Icons
                                                        .format_color_reset_outlined,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                      child: Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: ColorConstants.secondaryTxtColor,
                      ),
                    ),
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
          )
        ],
      ),
    );
  }
}
