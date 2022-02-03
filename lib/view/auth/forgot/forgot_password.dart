import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/forget_password_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/forgot/forgot_code.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPageState createState() => _ForgotPageState();
}
class _ForgotPageState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final pwdforget = Get.put(ForgetPasswordController());
  final formKey = new GlobalKey<FormState>();
  GetStorage box = GetStorage();
  var lang ;
  void requiredEmail(){
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      var json= {
        'email' : emailController.text
      };
      pwdforget.forgetPassword(json);
     box.write('forgetEmail', emailController.text); 
    }
  }
  @override
  void initState() {
    lang =  box.read('lang_code');
    super.initState();
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
                onTap: (){
                  Get.back();
                },
                child: Container(
                  padding: lang =='en'? EdgeInsets.only(left:15.0,top:50): EdgeInsets.only(right:20, top:50),
                  child: Icon(
                    Icons.arrow_back, color: Colors.black
                  )
                ),
              ),
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
                bgcolor: AppColors.whitedColor,  
                textColor: AppColors.white,
                buttonText: "next".tr,
                fontSize: 18.toDouble(),
                callback: requiredEmail
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textHint(){
    final space10 = SizedBox(height: getSize(10, context));
    return Column(
      children: [
        Container(
          alignment:lang== 'en'?  Alignment.topLeft:Alignment.topRight ,
          margin: lang == 'en'? EdgeInsets.only(left:30):EdgeInsets.only(right:22),
          child: Text("forgot_password".tr, style: TextStyle(fontSize: 23,color: AppColors.forgotPassText))
        ),
        // space10, 
        Container(
          alignment: Alignment.topLeft,
          margin: lang == 'en'? EdgeInsets.only(left:30):EdgeInsets.only(right:30),
          child: Text("forget_Desc".tr, style: TextStyle(fontSize: 13, color: AppColors.forgotPassText),)
        ),
      ],
    );
  }
  Widget eMail() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'emails'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.forgotPassText),
        hintColor: AppColors.textInput,
        onChanged: (value) {},
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: emailController,
        validator: (value) => !GetUtils.isEmail(value)  ? 'enter_valid_email'.tr: value == '' ? 'emailAdd'.tr : null,
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
      image: image,
      width: width,  
    );
  }
  void navigateToHomeScreen() {
    PageUtils.pushPage(ForgotCode());
  } 
}
 