

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';

class BecomeMember extends StatefulWidget {
  _BecomeMemberState createState() => _BecomeMemberState();
}
class _BecomeMemberState extends State<BecomeMember> {
  Color buttonSelected = Colors.greenAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColors.appBarBackGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height/9.5*.7,),
            Center(
              child: Container(
                width: Get.width/1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("BECOME A MEMBER",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        child:  Image.asset(AppImages.cross,height: 15,)
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:20),
              height: Get.height/2,
              width: Get.width/1.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Container(
                  child: Image.asset(AppImages.memberSuccess,height: Get.height/3)
                ),
              ),
            ),
            registerButton("\$20 / Month",buttonSelected),
            registerButton("\$20 / Year Save 50%",Colors.transparent)
          ],
        ),
      ),
    );
  }
  
   Widget registerButton(text,color) {
      return GestureDetector(
        onTap: () {
          // Get.toNamed('/beMember');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal:15,vertical: 10),
          width: Get.width/1.3,
          height: Get.height/9.5*.7,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color:Colors.white),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))),
        ),
      );
    }
}