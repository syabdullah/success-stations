import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/language_controller.dart';
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
import 'package:success_stations/view/i18n/app_language.dart';

class SignIn extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignIn> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passwordVisible = true;
  GetStorage dataStore = GetStorage();

  final loginCont = Get.put(LoginController());
  bool errorCheck = true;
  var selectedLang;
  var hintTextLang;
  GetStorage box = GetStorage();
  var lang;
  var choose;

  @override
  void initState() {
    super.initState();
    lang = box.read('lang');
    choose = box.read('lang_code');
    GoogleSignInC().singIn();
    loginCont.resultInvalid(false);
    errorCheck = true;
  }

  signIn() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var jsonData = {"email": email.text, "password": password.text};
      loginCont.loginUserdata(jsonData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: GetBuilder<LanguageController>(
              init: LanguageController(),
              builder: (val) {
                return val.languageList == null
                    ? Container()
                    : language(val.languageList['data']);
              },
            ),
          ),
          bottomNavigationBar:   bottomW(),
          body: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (val) {
                return Center(
                  child: ListView(



                      physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: Get.height*0.02),
                              Container(
                                margin: EdgeInsets.only(bottom: Get.height*0.05),
                                child: Image.asset(AppImages.appLogo,
                                    height: Get.height / 6),
                              ),
                              SizedBox(height: Get.height*0.02),
                              eMail(),
                              SizedBox(height:Get.height*0.008),
                              passwordW(),
                              loginCont.resultInvalid.isTrue &&
                                      errorCheck == true
                                  ? Container(
                                      child: Container(
                                        child: Text(
                                          loginCont.logindata['errors'],
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: Get.height*0.008),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.pushNamed(context, '/forgotPass');
                              //   },
                              //   child: Container(
                              //     alignment: Alignment.bottomRight,
                              //     margin: EdgeInsets.only(
                              //         bottom: 10, right: 18, top: 6),
                              //     child: Text('forgot_password'.tr,
                              //         style: TextStyle(color: Colors.grey),
                              //         textAlign: TextAlign.end),
                              //   ),
                              // ),
                              submitButton(
                                  bgcolor: AppColors.darkblue,
                                  textColor: AppColors.white,
                                  buttonText: "login".tr,
                                  fontSize: 15.0,
                                  width: Get.width * 0.9,
                                  height:  Get.height *0.065,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "andada",
                                  callback: signIn),
                              SizedBox(
                                height:  Get.height*0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("forgot_your_log_in_details".tr,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Source_Sans_Pro",
                                          fontSize: 15)),
                                  Text(

                                    " "+"help_login".tr ,


                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Source_Sans_Pro",
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Get.height*0.01, horizontal: Get.height*0.04),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Divider(
                                        color: Colors.black,
                                      )),
                                      Text(
                                        " or ".tr,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color: Colors.black,
                                      )),

                                      /*SizedBox(
                                        width: 3,
                                      ),*/
                                    ]),
                              ),
                              SizedBox(
                                height: Get.height*0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  submitButton(
                                      textColor: AppColors.white,
                                      buttonText: AppString.facebook,
                                      fontFamily: "Source_Sans_Pro",
                                      callback: navigateToGoogleFaceBook,
                                      width: Get.width / 2.3,
                                      image: AppImages.fb),
                                  SizedBox(width: 10),
                                  submitButton(
                                      textColor: AppColors.google,
                                      buttonText: AppString.facebook,
                                      fontFamily: "Source_Sans_Pro",
                                      borderColor: AppColors.google,
                                      callback: navigateToGoogleLogin,
                                      width: Get.width / 2.3,
                                      image: AppImages.google),
                                ],
                              ),
                              SizedBox(
                                height: Get.height*0.04,
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }

  // Widget eMail() {
  //   return Container(
  //     decoration: BoxDecoration(border: Border.all(width: 0.3),borderRadius: BorderRadius.circular(10)),
  //     margin: EdgeInsets.only(left: 20, right: 20),
  //     width: Get.width * 0.9,
  //     child: CustomTextFiled(
  //       isObscure: false,
  //       hintText: "emails".tr,
  //       hintStyle: TextStyle(
  //         fontSize: lang == 'ar' ? 14 : 16,
  //         color: Colors.grey,
  //       ),
  //
  //       contentPadding:
  //       new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  //       hintColor: AppColors.inputTextColor,
  //       onChanged: (value) {},
  //       onSaved: (String? newValue) {},
  //       onFieldSubmitted: (value) {},
  //       textController: email,
  //       validator: (value) => value == ''
  //           ? 'email_required'.tr
  //           : !value.contains('@') || !value.contains('.')
  //           ? 'enter_valid_email'.tr
  //           : null,
  //       errorText: '',
  //     ),
  //   );
  // }

  Widget language(List data) {
    return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          hint: hintTextLang != null
              ? Text(hintTextLang,
                  style: TextStyle(
                      fontSize: lang == 'ar' ? 14 : 16,
                      color: AppColors.inputTextColor))
              : hintTextLang == null && lang == null
                  ? Text("English")
                  : Text(lang),
          dropdownColor: AppColors.inPutFieldColor,
          icon: Icon(
            Icons.expand_more_outlined,
            color: AppColors.inputTextColor,
          ),
          items: data.map((coun) {
            return DropdownMenuItem(
              value: coun,
              child: coun['name'] != null
                  ? Text(
                      coun['name'],
                      style: TextStyle(color: AppColors.inputTextColor),
                    )
                  : Container(),
            );
          }).toList(),
          onChanged: (val) {
            var mapLang;
            setState(() {
              mapLang = val as Map;
              hintTextLang = mapLang['name'];
              selectedLang = mapLang['id'];
              box.write('lang_id', mapLang['id']);
              box.write('lang_code', mapLang['short_code']);
              LocalizationServices().changeLocale(mapLang['short_code']);
            });
          },
        )));
  }

  Widget eMail() {
    return Container(
        // decoration: BoxDecoration(
        //     border: Border.all(width: 0.3),
        //     borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: Get.width*0.02),
        width: Get.width * 0.9,
        // height:  Get.height *0.065,
        child: TextFormField(

          controller:email ,
          // obscureText: passwordVisible,
          decoration: InputDecoration(
            contentPadding:
            new EdgeInsets.symmetric(vertical:Get.height*0.01, horizontal:Get.width*0.04),
            hintText: ("emails".tr),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: lang == 'ar' ? 14 : 16,
            ),
            // labelStyle: TextStyle(color: AppColors.basicColor),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.outline,width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red,width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red,width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //borderRadius: BorderRadius.circular(20.0),

              borderSide: BorderSide(color: AppColors.outline,width: 1.5),
            ),
          ),
          validator: (value) => value == ''
              ? 'email_required'.tr
              : !value!.contains('@') || !value.contains('.')
                  ? 'enter_valid_email'.tr
                  : null,
          // errorText: '',
          // onSaved: (val) => email = TextEditingController(text: val),
        ));
  }

  Widget passwordW() {
    return Container(
        // decoration: BoxDecoration(
        //     border: Border.all(width: 0.3),
        //     borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: Get.width*0.02),
        width: Get.width * 0.9,
        // height:  Get.height *0.065,
        child: TextFormField(
          obscureText: passwordVisible,
          decoration: InputDecoration(
            contentPadding:
                new EdgeInsets.symmetric(vertical:Get.height*0.01, horizontal:Get.width*0.04),
            hintText: ('password'.tr),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: lang == 'ar' ? 14 : 16,
            ),
            // labelStyle: TextStyle(color: AppColors.basicColor),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.outline,width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red,width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red,width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //borderRadius: BorderRadius.circular(20.0),

              borderSide: BorderSide(color: AppColors.outline,width: 1.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
          ),
          validator: (val) => val == ''
              ? 'enter_password'.tr
              : val!.length < 4
                  ? 'pass_to_short'.tr
                  : null,
          onSaved: (val) => password = TextEditingController(text: val),
        ));
  }

  Widget bottomW() {
    return Container(
      height: Get.height*0.08,
      margin: EdgeInsets.only( bottom:  Get.height*0.006,),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Divider(
            color: Colors.black,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dont_have_account".tr,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Source_Sans_Pro",
                    fontSize: 17),
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed('/langua');
                  },
                  child: Text(
                    'sign_up_text'.tr,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Source_Sans_Pro",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget submitButton(
      {buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      fontWeight,
      height,
      width,
      borderColor,
      image}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      image: image,
      height: height,
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
