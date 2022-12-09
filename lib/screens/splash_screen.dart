import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:contacts_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer timer;

  Map<String, dynamic> decodedUserData = {};
  int Token = 0;

  Future<SharedPreferences> getShared() async{
    return await SharedPreferences.getInstance();
  }

  void getPrefsData() async{
    SharedPreferences pRefs = await getShared();
    String encodeMap  = pRefs.getString("UserData") ?? "";
    int token = pRefs.getInt("sessionToken") ?? 0;
    if(encodeMap != "") {
      decodedUserData = json.decode(encodeMap);
    }

    if(token != 0) {
      setState(() {
        Token = token;
      });

    }

  }

  @override
  void initState() {
    super.initState();
    getPrefsData();
    timer = Timer(Duration(seconds: 5),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Token == 0?  RegisterScreen() : ProfileScreen())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Container(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText("CUPIDKNOT", textStyle: GoogleFonts.overpass(
                fontSize:24,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ))
            ],

          ),
        ),
      ),
    );
  }
}
