import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Global {
  static double  getSizeWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double  getSizeHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static String url = "http://flutter-intern.cupidknot.com/api/";

  static TextStyle commonTextStyle = GoogleFonts.overpass(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w600);

}