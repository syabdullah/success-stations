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

class Contact extends StatefulWidget {
  ContactPageState createState() => ContactPageState();
}
class ContactPageState extends State<Contact> {
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
      //  padding:EdgeInsets.only(top:8),
      child: stringAppbar('',Icons.arrow_back_ios_new_sharp, 'CONTACT US',AppImages.appBarSearch)),
    ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              space50, 
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo, height: Get.height / 4.40
                  ),
                ),
              ),
              space10,
              name(),
              space20,
              phoneNumber(),
              space20,
              textArea(),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: AppString.send,
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
        hintText:AppString.name,
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
  Widget phoneNumber() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText:AppString.phoneNumber,
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
        hintText: "Write here", hintStyle: TextStyle(color:Colors.grey),
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
 