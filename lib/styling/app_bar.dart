import 'package:flutter/material.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_style.dart';

Widget appbar(String text) {
  return AppBar(
    title: Text( 
      text, style: AppTextStyles.appTextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600)
    ),
    centerTitle: false,
    // leading:
    //   IconButton(icon: iconButton, color: Colors.white, onPressed: (){}),
    
    flexibleSpace: Container(
      decoration:  BoxDecoration(
        image: DecorationImage( 
          image: AssetImage(""),
          fit: BoxFit.cover,
        ),
      ),
    ),
    backgroundColor: AppColors.appBar,
  );
}