import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/forgot/forgot_code.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPageState createState() => _ForgotPageState();
}
class _ForgotPageState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    final space20 = SizedBox(height: getSize(20, context));
    final space50 = SizedBox(height: getSize(50, context));
    return Scaffold(
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
              space50,
              textHint(),
              space10,
              eMail(),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: AppString.next,
                fontSize: 18.toDouble(),
                callback: navigateToHomeScreen
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textHint(){
    final space20 = SizedBox(height: getSize(20, context));
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.forgotPassText, style: TextStyle(fontSize: 23,color: AppColors.forgotPassText))
        ),
        space20, 
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.recieveEmailID, style: TextStyle(fontSize: 13, color: AppColors.forgotPassText),)
        ),
      ],
    );
  }
  Widget eMail() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText:AppString.emailAddress,
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
 