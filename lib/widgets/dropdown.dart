import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/constants.dart';
import '../global/globals.dart';


class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key, required this.itemsList, required this.itemValue, this.changed}) : super(key: key);
  final List<String> itemsList;
  final String? itemValue;
  final Function(String?)? changed;

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 24),
      child: Container(
        width: Global.getSizeWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonHideUnderline(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              icon:const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.chevron_down),
              ),
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '    Gender',
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    fontSize: 14,
                    color: hintColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              items: widget.itemsList
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  "   $item",
                  style:GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    fontSize: 14,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
                  .toList(),
              value: widget.itemValue,
              onChanged: widget.changed,
            ),
          ),
        ),
      ),
    );
  }
}
