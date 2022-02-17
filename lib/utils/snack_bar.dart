import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';

class SnackBarWidget {
  showToast(String msg, String text) {
    Get.snackbar(msg, text,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        borderRadius: 0,
        borderWidth: 1,
        borderColor: AppColors.border,
        duration: Duration(seconds: 3));
  }
}
