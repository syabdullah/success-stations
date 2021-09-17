
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';

class SnackBarWidget {
  showToast(String msg,String text) {
   Get.snackbar(msg,  text,snackPosition:SnackPosition.TOP, backgroundColor:AppColors.appBarBackGroundColor,colorText: Colors.white,duration: Duration(seconds: 
   5));
  } 
}