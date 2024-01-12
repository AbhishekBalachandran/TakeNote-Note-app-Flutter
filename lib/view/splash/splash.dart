import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_note/utils/constants/color_constants.dart';
import 'package:take_note/view/notes/notes.dart';
import 'package:take_note/view/onboarding/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? onBoardCompleted;

  @override
  void initState() {
    // TODO: implement initState
    checkViewed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor3,
      body: Center(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Take',
                style: GoogleFonts.zeyada(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'NOTE',
                style: GoogleFonts.exo(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = ColorConstants.linearGradient))
          ]),
        ),
      ),
    );
  }

  checkViewed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    onBoardCompleted = prefs.getBool('onBoardCompleted') ?? false;
    onBoardCompleted ==true
        ? Future.delayed(Duration(seconds: 3))
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Notes(),
                )))
        : Future.delayed(Duration(seconds: 3))
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OnBoardingScreen(),
                )));
  }
}
