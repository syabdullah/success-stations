import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/rest_password_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/sign_in.dart';


class ResetPassword extends StatefulWidget {
  _ResetPasswordState createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController confirmPasswordControlller = TextEditingController();
  
   GetStorage box = GetStorage();
   
  final formKey = new GlobalKey<FormState>();
   final resetPasss = Get.put(ResetPassWordController());
  void _showModal() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.appBarBackGroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Container(
            margin:EdgeInsets.only(top: 60, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[   
                Text(
                  AppString.changedPasww  ,style:  TextStyle(fontSize: 20, color: Colors.white)
                ),
                SizedBox(height:10),
                Text(
                  AppString.successResetPass ,style:  TextStyle(fontSize: 14, color: Colors.white)
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:20),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.white,
                        child: Container(
                          width: Get.width / 2,
                          child: Center(child: Text(AppString.login, style: TextStyle(color: AppColors.appBarBackGroundColor )))
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                          // Get.to(SignIn());
                        
                        }
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
 
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
      print(json);
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
              resetPass(),
              space10,
              password(),
              space10,
              newpassword(),
              space20,
              // ignore: deprecated_member_use
              RaisedButton(
                color: AppColors.appBarBackGroundColor,
                child: Container(
                  width: Get.width / 1.3,
                  height: Get.height * 0.05,
                  child: Center(
                    child: Text(
                      AppString.resetButton, style: TextStyle(color: AppColors.backArrow )
                    )
                  )
                ),
                onPressed: () {
                  requiredPassword();
                 
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resetPass(){
    final space20 = SizedBox(height: getSize(20, context));
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.resetPassword, style: TextStyle(fontSize: 23,color: AppColors.inputTextColor))
        ),
        space20, 
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left:30),
          child: Text(AppString.resetSetPass, style: TextStyle(fontSize: 13, color: AppColors.inputTextColor),)
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
        hintText:AppString.newPass,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: passwordControlller,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter Password';
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
        hintText:AppString.confirmPass,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: confirmPasswordControlller,
        validator: (value) {
           if (value.isEmpty) {
            return 'Enter Password';
          }
          if(value != passwordControlller.text ){
            return "password does'nt match ";
          }
        return null; 
        } ,
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
      width: width,  
    );
  }
void navigateToHomeScreen() {
    PageUtils.pushPage(SignIn());
  }
}

 