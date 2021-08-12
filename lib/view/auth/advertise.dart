import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/forgot/forgot_code.dart';

class AdvertisePage extends StatefulWidget {
  AdvertiseStatePage createState() => AdvertiseStatePage();
}
class AdvertiseStatePage extends State<AdvertisePage> {
    FocusNode textSecondFocusNode = new FocusNode();

  TextEditingController emailController = TextEditingController();
  
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    final space20 = SizedBox(height: getSize(20, context));
    final space50 = SizedBox(height: getSize(50, context));
    return Scaffold(
      appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),    
       child: Container(
        //  padding:EdgeInsets.only(top:8)R,
         child: stringAppbar(context,Icons.arrow_back_ios_new_sharp, 'ADVERTISE WITH US',AppImages.appBarSearch)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              space50, 
              // Container(
              //   margin: EdgeInsets.only(top: 60),
              //   child: Center(
              //     child: Image.asset(
              //       AppImages.appLogo, height: Get.height / 4.40
              //     ),
              //   ),
              // ),
              space10,
              text(),
              space50,
              name(),
              space20,
              phoneNumber(),
              space20,
              textArea(),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: "send".tr,
                fontSize: 18.toDouble(),
                callback: navigateToHomeScreen
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget name() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:"name".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.forgotPassText),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: emailController,
        validator: (value) => !GetUtils.isEmail(value)  ? 'Insert valid email':null,
        errorText: '',
      ),
    );
  }
  Widget text() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      // width: Get.width * 0.9,
      child: Column(
        children: [
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

      ],)
    );
  }
  Widget phoneNumber() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
         isObscure: false,
        hintText:"phone".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.forgotPassText),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: emailController,
        validator: (value) => !GetUtils.isEmail(value)  ? 'Insert valid email':null,
        errorText: '',
      ),
    );
  }

  Widget textArea() {
  final maxLines = 5;

  return Container(
    width:Get.width/1.0,
    margin: EdgeInsets.all(12),
    height: maxLines * 24.0,
    child: TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        focusColor: Colors.grey,
        
         border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        hintText: "writeHere".tr, hintStyle: TextStyle(color:Colors.grey),
        fillColor:AppColors.inputColor,
        filled: true,
      ),
    ),
  );
}
  //  }
   Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor,image}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,    
      // borderColor: borderColor,
      image: image,
      width: width,  
    );
  }
  void navigateToHomeScreen() {
    PageUtils.pushPage(ForgotCode());
  } 
}
 