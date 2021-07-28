import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/country.dart';

class Language extends StatefulWidget {
  _LanguagePageState createState() => _LanguagePageState();
}
class _LanguagePageState extends State<Language> {
  var languageList = ["English", "العربية",]; 
  TextEditingController emailController = TextEditingController();

  Widget getTextWidgets(List<String> strings){
    List<Widget> list = [];
    for(var i = 0; i < strings.length; i++){
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              // padding: EdgeInsets.all(10),
              height: Get.height * 0.25,
              width: Get.width/4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(strings[i]),
              ),
            ),
          ],
        )
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list
    );
  }


  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    final space20 = SizedBox(height: getSize(20, context));
    final space50 = SizedBox(height: getSize(50, context));
    return Scaffold(
      body:Column(
        children: [
          space50, 
          mainLogo(),
          space50,
          chooseLanguage(),
          getTextWidgets(languageList),
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: AppString.next,
            fontSize: 18.toDouble(),
            callback: navigateToHomeScreen
          ),
         SizedBox(height: Get.height * 0.13),
          Container(
            alignment: Alignment.bottomRight,
            child: existingAccount()),
          space50,
          
        ],
      ),
    );
  }

  Widget mainLogo() {
    return  Container(
      margin: EdgeInsets.only(top: 60),
      child: Center(
        child: Image.asset(
          AppImages.appLogo, height: Get.height / 4.40
        ),
      ),
    );
  }

  Widget existingAccount(){
    return Container(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppString.existAccount, 
            style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300
            ),
          ),
          Text(AppString.signIn, style: TextStyle(fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
        ],
      ), 
    );
  }
  
  Widget chooseLanguage(){
    return Container(
      child: Text("اختر اللغة", style: TextStyle(fontSize: 23, color: AppColors.black),)
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
    PageUtils.pushPage(Ccountry());
  } 
}
 