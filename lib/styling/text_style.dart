import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle appTextStyle(
    {required double fontSize, required FontWeight fontWeight, required Color color}) {
    return GoogleFonts.poppins(
      color: color ,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight
    );
  }
}
