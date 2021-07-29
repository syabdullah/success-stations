import 'package:flutter/material.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Widget appbar(context ,image,searchImage,) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back,
          color: AppColors.backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      //
       ),
      title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ), 
      actions: [
        Padding(
          padding: const EdgeInsets.only(top:12.0,right: 10,),
          child: Image.asset(
             searchImage,color: Colors.white,width: 20.w,
          ),
        )
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

 Widget stringAppbar(context ,string ,searchImage,) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top:10.0),
      //   child: IconButton(
      //     icon: Icon(icon,
      //     color: AppColors.backArrow),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //
       ),
      title: Text(string), 
      actions: [
        Padding(
          padding: const EdgeInsets.only(top:12.0,right: 10,),
          child: Image.asset(
           AppImages.appBarSearch,color: Colors.white,width: 25.w,
          ),
        )
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
