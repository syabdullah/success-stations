
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  showToast(String msg,String text) {
   Get.snackbar(msg,  text,snackPosition:SnackPosition.TOP, backgroundColor:Colors.blue,colorText: Colors.white,duration: Duration(seconds: 
   5));
  } 
}