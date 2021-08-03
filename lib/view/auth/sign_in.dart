import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/facebook_signIn.dart';
import 'package:success_stations/utils/google_signIn.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/bottom_bar.dart';

import 'forgot/forgot_code.dart';

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

   void signIn() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var jsonData = {
        "email":fulNameController.text,
        "password":password.text
      };
      dataStore.write('email', fulNameController.text);
      dataStore.write('password', password.text);
       loginCont.loginUserdata(jsonData);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GetBuilder<LoginController>( 
        init: LoginController(),
        builder: (val){
          return Center(
            child: ListView(
              children: [
                Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height:Get.height/6.0),
                        Container(
                          margin: EdgeInsets.only(bottom:20),
                          child: Image.asset(AppImages.appLogo,height: Get.height/6), 
                        ),
                        eMail(),
                        SizedBox(height:10),
                        passwordW(),
                      loginCont.resultInvalid.isTrue ? Container(
                        child: Container(
                          child: Text(loginCont.logindata['errors'],style: TextStyle(color: Colors.red),),
                        ),
                      ):Container(),
                        SizedBox(height:10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotPass');

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
                          callback: signIn
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,bottom:10),
                          child: Text("OR"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            submitButton(
                              textColor: AppColors.appBarBackGroun,
                              buttonText: AppString.facebook,
                              callback: navigateToGoogleFaceBook,
                              width: Get.width/2.3,
                              image: AppImages.fb
                            ),
                            SizedBox(width:20),
                            submitButton( 
                              textColor: AppColors.google,
                              buttonText: AppString.facebook,
                              borderColor: AppColors.google,
                              callback: navigateToGoogleLogin,
                              width: Get.width/2.3,
                              image: AppImages.google
                            ),
                          ],
                        ), 
                        bottomW()                 
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }

    Widget eMail() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:AppString.loginEmail,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        textController: fulNameController,
        validator: (value) => value == '' ?  'Email Required' :  !GetUtils.isEmail(value)  ? 'Enter valid Email':null,
        errorText: '',
      ),
    );
  }

  Widget passwordW() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: Container(
        child: TextFormField(
          obscureText: passwordVisible,
          decoration: InputDecoration(
            hintText:('Password') ,
            // labelStyle: TextStyle(color: AppColors.basicColor),
            fillColor: AppColors.inputColor,
              filled: true,
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.red
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.red
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.outline
                ),
              ),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible
                ? Icons.visibility_off
                : Icons.visibility,
                color: Theme.of(context).primaryColor
              ),
              onPressed: () {
                setState(() {
                    passwordVisible = !passwordVisible;
                });
              },
            ),
          ),
          validator: (val) => val == ''
          ? 'Enter a Password ' :
            val!.length < 4
          ? 'Password too short'
          : null,
          onSaved: (val) => password = TextEditingController(text:val),
        ),
      // child: CustomTextFiled(
      //   isObscure: true,
      //   hintText:AppString.password,
      //   hintStyle: TextStyle(fontSize: 13,),
      //   hintColor: AppColors.inputTextColor,
      //   onChanged: (value) {  },
      //   onSaved: (String? newValue) {  }, 
      //   onFieldSubmitted: (value) {  }, 
      //   textController: password,
      //   validator: (val) => val == ''
      //     ? 'Enter a Password ' :
      //       val.length < 4
      //     ? 'Password too short'
      //     : null,
      //     errorText: '',
      // ),
    ));
  }
  
  Widget bottomW() {
    return Container(
      margin: EdgeInsets.only(top:50),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppString.goForSignup),
          GestureDetector(
            onTap: (){
              print("ontap itmemmm.....>!!!");
             Navigator.pushNamed(context, '/signUp');
            },
            child: Text(AppString.signUp,style: TextStyle(color:AppColors.appBarBackGroundColor, ),)
          ),
        ],
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

    void navigateToGoogleLogin() {
    GoogleSignInC().handleSignIn();
  }
  void navigateToGoogleFaceBook() {
    FaceBookSignIn().login();
  }
  void navaigateToTabs() {
   PageUtils.pushPage(BottomTabs());
  }
}
 