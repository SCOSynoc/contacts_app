import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart';

const kAppPrimaryColor = Color(0xff47BFDF);
const prefixIconColor = Color(0xff292D32);
const buttonDisabledColor = Color(0xffD9D9D9);
const kCommonIconColor = Color(0xffFFFFFF);
const kSignOutColor = Color(0xffFF6D6D);
const kSignOutCircleColor = Color(0xffFFD6D6);
const kHomeContainerColor = Color(0xffFFFFFF);
const kViewReportContainerColor = Color(0xff444E72);
const kDialogContainerColor = Color(0xffFFFFFF);
const logoutBoldColor = Color(0xff080713);
const blackBold = Color(0xff080713);
const cancelButton = Color(0xffF1EFEF);
const logOutText = Color(0xff6B6A71);
const searchBarIconCOlors = Color(0xff444E72);
const searchTextColor = Color(0xff444E72);
const hintColor = Color(0xff808080);






Future showPopUpDialog( {required BuildContext context, required String textTitle, required List<dynamic> msgText, required Function() pressed}) {
  return showDialog( //show confirm dialogue
//the return value will be from "Yes" or "No" options
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(textTitle,style:GoogleFonts.overpass(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.w600)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(msgText.length, (index) => Container(
            width: Global.getSizeWidth(context)*0.60,
            height: Global.getSizeHeight(context) *0.04,
            child: Text(msgText[index][0],style:GoogleFonts.overpass(color: searchTextColor, fontSize: 14, fontWeight: FontWeight.w400))
        )),
      ),
      actions:[
        CupertinoButton(
          onPressed: pressed,
          //return true when click on "Yes"
          child:Text('ok',style:GoogleFonts.overpass(color:Colors.orange, fontSize: 18, fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}


Future showNormalPopUpDialog( {required BuildContext context, required String textTitle, required String msgText, required Function() pressed}) {
  return showDialog( //show confirm dialogue
//the return value will be from "Yes" or "No" options
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(textTitle,style:GoogleFonts.overpass(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.w600)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Container(
            width: Global.getSizeWidth(context)*0.60,
            height: Global.getSizeHeight(context) *0.03,
            child: Text(msgText,style:GoogleFonts.overpass(color: searchTextColor, fontSize: 14, fontWeight: FontWeight.w400))
        )],
      ),
      actions:[
        CupertinoButton(
          onPressed: pressed,
          //return true when click on "Yes"
          child:Text('ok',style:GoogleFonts.overpass(color:Colors.orange, fontSize: 18, fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}