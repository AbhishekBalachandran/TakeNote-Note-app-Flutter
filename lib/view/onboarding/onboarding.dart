import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/view/notes/notes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: ColorConstants.bgColor3,
        body: Center(
          child: Container(
            height: height * 0.8,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: height * 0.3,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: 40,
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        112, 255, 255, 255),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0))
                              ]),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 20,
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        112, 255, 255, 255),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0))
                              ]),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 80,
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        112, 255, 255, 255),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0))
                              ]),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 80,
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        112, 255, 255, 255),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0))
                              ]),
                        ),
                      ),
                      Positioned(
                          bottom: 60,
                          left: 50,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(66, 155, 39, 176),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(59, 155, 39, 176),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 5))
                                ]),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(107, 155, 39, 176),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(147, 155, 39, 176),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          top: 30,
                          right: 60,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(29, 0, 179, 255),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(29, 0, 179, 255),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 5))
                                ]),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(96, 0, 179, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(57, 0, 179, 255),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: width * 0.6,
                                  height: height * 0.4,
                                  color: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      // blur effect
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 4.0,
                                          sigmaY: 4.0,
                                        ),
                                        child: Container(),
                                      ),
                                      // gradient effect
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  45, 43, 67, 0.414)),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(74, 74, 155, 0.235),
                                            Color.fromRGBO(65, 65, 152, 0.192),
                                            Color.fromRGBO(72, 72, 154, 0.173)
                                          ]),
                                        ),
                                      ),

                                      // child
                                      Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 6,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    180, 106, 106, 106),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          Container(
                                            height: 6,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    180, 106, 106, 106),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          Container(
                                            height: 6,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    180, 106, 106, 106),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          Container(
                                            height: 6,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    180, 106, 106, 106),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                      Positioned(
                          bottom: height * 0.01,
                          right: width * 0.1,
                          child: Container(
                            width: 85,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(66, 255, 251, 0),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(66, 126, 176, 39),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 5))
                                ]),
                            child: Center(
                              child: Container(
                                width: 75,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(66, 126, 176, 39),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(66, 126, 176, 39),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.edit_outlined,
                                      color: ColorConstants.secondaryTxtColor,
                                      size: 30,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Take Note',
                      style: GoogleFonts.genos(
                          color: ColorConstants.secondaryTxtColor,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.65,
                  child: Text(
                    'Take notes, to-dos, collect resources like images and secure privacy.',
                    style: GoogleFonts.genos(
                        color: ColorConstants.secondaryTxtColor, fontSize: 20),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await _storeOnBoard();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notes(),
                        ));
                  },
                  child: Container(
                    height: 70,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(111, 111, 200, 100),
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: ColorConstants.secondaryTxtColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _storeOnBoard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoardCompleted', true);
  }
}
