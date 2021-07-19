import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/facebook_signIn.dart';
import 'package:success_stations/utils/google_signIn.dart';

class SignIn extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}
class _SignPageState extends State<SignIn> {
  
  final formKey = new GlobalKey<FormState>();

  TextEditingController fulNameController = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = true;
  GetStorage dataStore = GetStorage();
  
  final loginCont = Get.put(LoginController());
  
  @override
  void initState() {
    super.initState();
    GoogleSignInC().singIn();
  }

   signIn() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var jsonData = {
        "email":fulNameController.text,
        "password":password.text
      };
      dataStore.write('email', fulNameController.text);
      dataStore.write('password', password);
       loginCont.loginUserdata(jsonData);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:Get.height/3.5),
                  eMail(),
                  SizedBox(height:10),
                  passwordW(),
                  SizedBox(height:10),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(bottom:10,right: 10,top: 10),
                      child: Text(AppString.forgotPass,textAlign:TextAlign.end),
                    ),
                  ),
                  submitButton(
                    bgcolor: AppColors.appBarBackGroundColor,  
                    textColor: AppColors.appBarBackGroun,
                    buttonText: AppString.signIn,
                    callback: navigateToHomeScreen
                  ),
                  // SizedBox(height:Get.height/10.5*0.5),
                  Container(
                    margin: EdgeInsets.only(top:10,bottom:10),
                    child: Text("OR"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      submitButton(
                      bgcolor: AppColors.appBarBackGroundColor,  
                      textColor: AppColors.appBarBackGroun,
                      buttonText: AppString.facebook,
                      callback: navigateToHomeScreen,
                      width: Get.width/2.3
                    ),
                    SizedBox(width:20),
                    submitButton(
                      bgcolor: AppColors.appBarBackGroundColor,  
                      textColor: AppColors.appBarBackGroun,
                      buttonText: AppString.google,
                      callback: navigateToHomeScreen,
                      width: Get.width/2.3
                    ),
                      // TextButton(
                      //   onPressed: () {
                      //      GoogleSignInC().handleSignIn();
                      //   },
                      //   child: Container(
                      //     color: Colors.blue,
                      //     height: 50,
                      //     width: 100,
                      //     child: Text("Google",style: TextStyle(color: Colors.white))
                      //   )
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //   FaceBookSignIn().login();
                      //   },
                      //   child: Container(
                      //     color: Colors.blue,
                      //     height: 50,
                      //     width: 100,
                      //     child: Text("FaceBook",style: TextStyle(color: Colors.white),)
                      //   )
                      // )
                    ],
                  ),                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

    Widget eMail() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText:AppString.loginEmail,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: false,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

  Widget passwordW() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText:AppString.password,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }


   Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight, height, width,}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,    
      // height: height,
      width: width,  
    );
  }

    void navigateToHomeScreen() {
    print("................");
    // PageUtils.pushPage(SignupOption());
  }
}
 