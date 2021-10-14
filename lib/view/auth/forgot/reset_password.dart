import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/rest_password_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';


class ResetPassword extends StatefulWidget {
  _ResetPasswordState createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController confirmPasswordControlller = TextEditingController();
  
   GetStorage box = GetStorage();
   
  final formKey = new GlobalKey<FormState>();
   final resetPasss = Get.put(ResetPassWordController());

 
void requiredPassword(){
   var forgetemailid = box.read('forgetEmail');
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      var json = {
        'email' : forgetemailid,
        'password' : passwordControlller.text,
        'password_confirmation' : confirmPasswordControlller.text
      };
      resetPasss.passwordreset(json);
    }
  }
  
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){Get.back();},
                child: Container(
                  padding:  EdgeInsets.only(left:15.0,top:50),
                  child:Icon(Icons.arrow_back, color:Colors.black)
                ),
              ),
              space10, 
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo, height: Get.height / 4.40
                  ),
                ),
              ),
              space50,
              resetPass(),
              space10,
              password(),
              space10,
              newpassword(),
              space20,
              Center(
                child:  submitButton(
                  width: Get.width/1.2,
                  bgcolor: AppColors.appBarBackGroundColor,  
                  textColor: AppColors.appBarBackGroun,
                  buttonText: "reset".tr,fontSize: 16.0,
                  callback: requiredPassword,
                )
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget resetPass(){
    final space20 = SizedBox(height: getSize(20, context));
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text("reset_password".tr, style: TextStyle(fontSize: 23,color: AppColors.inputTextColor))
        ),
        space20, 
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text("set_new_pass".tr, style: TextStyle(fontSize: 13, color: AppColors.inputTextColor),)
        ),
      ],
    );
  }
  Widget password() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:"new_password".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: passwordControlller,
        validator: (value) {
          if (value.isEmpty) {
            return 'EnterPassword'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }
  Widget newpassword() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "confirm_password".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: confirmPasswordControlller,
        validator: (value) {
           if (value.isEmpty) {
            return 'EnterPassword'.tr;
          }
          if(value != passwordControlller.text ){
            return "passnotMatch".tr;
          }
        return null; 
        } ,
        errorText: '',
      ),
    );
  }
}

 

 