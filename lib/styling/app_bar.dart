import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';


 Widget appbar(context, icon ,image) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(icon,
        color: AppColors.backArrow),
        onPressed: () => Get.back()
      ),
      title: Image.asset(image, height: 40), 
      // actions: [
      //   Container(
      //     alignment: Alignment.center,
      //     child: Image.asset(
      //       image
      //     ),
      //   )
      // ],
      backgroundColor: AppColors.appBarBackGroundColor
    );
  }
