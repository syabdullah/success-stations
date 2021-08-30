import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/offers/my_offers.dart';

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
        GestureDetector(
          onTap: () {
            filtrationModel(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top:12.0,right: 10,),
            child: Image.asset(
             AppImages.appBarSearch,color: Colors.white,width: 25.w,
            ),
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
        Container(
          margin: EdgeInsets.only(top:5),
          child: IconButton(
            icon: Icon(icon,
            color: AppColors.backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      //
      //  ),
      title: Container(
        margin: EdgeInsets.only(top:10),
        child: Center(
          child: Text(
            string
          )
        ),
      ), 
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
  Widget stringbar(context, string) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading:
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp,
          color: AppColors.backArrow),
         onPressed: () => Get.back()
        ),
      title: Text(string), 
      
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  filtrationModel(context) async {
    var size = MediaQuery.of(context).size;
    print(size);
   showModalBottomSheet(  
     isScrollControlled: false,
     context: context,   
     shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
        ),
      ),
      backgroundColor: Colors.white,
       builder:(BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          return Wrap(
            children: [
              Container(
                height: Get.height/1.5,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          
                        ],
                      ),
                    )
                  ],
                ),

              )
            ]

          );
          });
   
       }
   );
  }