import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/reset_password_action.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/sign_in.dart';

class ResetPassWordController extends GetxController {
  
  var result = true;
  var email;
  RxBool isLoading = false.obs;
  passwordreset(data) async {
    isLoading(true);
    await restPasswordAction(data).then((res) { 
      if(res.statusCode == 200 || res.statusCode < 400){
        Get.bottomSheet( 
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
            height:Get.height/3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[   
                Container(
                  margin:EdgeInsets.only(top: 60, left: 20),
                  child: Text(
                    "changedPassword".tr  ,style:  TextStyle(fontSize: 20, color: AppColors.appBarBackGroundColor)
                  ),
                ),
                SizedBox(height:10),
                Container(
                  margin:EdgeInsets.only(left: 20),
                  child: Text(
                    "login_Can".tr,style:  TextStyle(fontSize: 14, color: AppColors.resetText)
                  ),
                ),
                SizedBox(height: 30),
                submitButton(
                  width: Get.width/1.2,
                  bgcolor: AppColors.appBarBackGroundColor,  
                  textColor: AppColors.appBarBackGroun,
                  buttonText: 'capsLogin'.tr,fontSize: 16.0,
                  callback: navaigateToTabs,
                )
              ]
            )
          )
        );
       isLoading(false);
      } 
      if(res.statusCode >=  400){
        Get.snackbar("You Enter Wrong Email Address",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }
  Widget submitButton(
    {
      buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      width,
      fontWeight
    }
  ) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      width:width,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  void navaigateToTabs() {
    PageUtils.pushPage(SignIn());
  }
}