import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global/constants.dart';
import '../../global/globals.dart';


class CommonTextFeild extends StatefulWidget {
  const CommonTextFeild({Key? key, required this.hint, required this.textEditingController, this.obscure, this.icon, this.keyboardType, this.length}) : super(key: key);
  final String hint;
  final TextEditingController textEditingController;
  final bool? obscure;
  final Widget? icon;
  final TextInputType? keyboardType;
  final int? length;

  @override
  _CommonTextFeildState createState() => _CommonTextFeildState();
}

class _CommonTextFeildState extends State<CommonTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 24),
      child: Container(
          width: Global.getSizeWidth(context),
          height: 54.0,
          child: TextField(
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
            keyboardType: widget.keyboardType,
            maxLength: widget.length,
            obscureText: widget.obscure == null ? false : widget.obscure!,
            controller: widget.textEditingController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                suffixIcon: widget.icon,
                prefixIconColor: prefixIconColor,
                hintText: widget.hint,
                hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: hintColor,
                    fontWeight: FontWeight.w600
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(15.0),),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )
            ),
          )),
    );
  }
}
