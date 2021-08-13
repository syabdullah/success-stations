import 'package:flutter/material.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Widget appbar(GlobalKey<ScaffoldState> globalKey,context ,image,searchImage,) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        iconSize: 20,
        icon: Icon(Icons.menu,color: Colors.white),
        onPressed: () => globalKey.currentState!.openDrawer()),
      title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ), 
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

Widget sAppbar(context ,icon,image,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
      // Padding(
        // padding: const EdgeInsets.only(top:10.0),
        IconButton(
          icon: Icon(icon,
          color: AppColors.backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      //
      //  ),
    title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ),
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

  Widget stringAppbar(context ,icon,string ,searchImage,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
      // Padding(
        // padding: const EdgeInsets.only(top:10.0),
        IconButton(
          icon: Icon(icon,
          color: AppColors.backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      //
      //  ),
      title: Text(string), 
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10,),
          child:  Image.asset(
           AppImages.appBarSearch,color: Colors.white,width: 25.w,
          ),
        )
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  Widget stringbar(context ,icon,string) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading:
        IconButton(
          icon: Icon(icon,
          color: AppColors.backArrow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      title: Text(string), 
      
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
