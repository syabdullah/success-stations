import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/language_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/auth/country.dart';
import 'package:success_stations/view/i18n/app_language.dart';

class Language extends StatefulWidget {
  _LanguagePageState createState() => _LanguagePageState();
}
class _LanguagePageState extends State<Language> {
  final getLang = Get.put(LanguageController());
  GetStorage box = GetStorage();
  // bool _colorContainer = Colors.grey;
  bool pressAttention = false;
 String selected = "first";

  @override
  void initState() {
  
    getLang.getLanguas();
    super.initState();
  }
  TextEditingController emailController = TextEditingController();

  List<Widget> getTextWidgets(dataLanguage){
    List<Widget> langua = [];
    if( dataLanguage['data'] !=null || dataLanguage['data'].length !=null ) {
      for(var i = 0; i < dataLanguage['data'].length; i++){
      print("printed dat aof the field ..............${dataLanguage['data'][i]['id']}");
      langua.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                // color: pressAttention ? Colors.grey : Colors.blue,
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(10),
                height: Get.height * 0.25,
                width: Get.width/4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    // color:Colors.grey
                      color: pressAttention ? Colors.grey : Colors.blue,
                   ),
                ),
                child: dataLanguage['data'][i]['name'] != null ? Center(
                  child: Text(dataLanguage['data'][i]['name']),
                ): Container()
              ),
              onTap: () {
                setState(() {
                  pressAttention = true;
                  pressAttention = !pressAttention;
                  box.write('lang_id',dataLanguage['data'][i]['id']);
                  LocalizationServices().changeLocale(dataLanguage['data'][i]['short_code']);
                  
                });
              },
            ),
          ],
        )
      );
    }

    }
   
    return langua;
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
          GetBuilder<LanguageController>(
            init: LanguageController(),
            builder:(data){
             return  data.isLoading == true ? CircularProgressIndicator():  Row(
                children: getTextWidgets(data.languageList)
              );
            }
          ),
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: "next".tr,
            fontSize: 18.toDouble(),
            callback: navigateToHomeScreen
          ),
          SizedBox(height: Get.height * 0.13),
          Container(
            alignment: Alignment.bottomRight,
            child: existingAccount()
          ),
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
          Text("have_account".tr, 
            style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300
            ),
          ),
          Text("sign_in".tr, style: TextStyle(fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
        ],
      ), 
    );
  }
  
  Widget chooseLanguage(){
    return Container(
      child: Text("choose_language".tr, style: TextStyle(fontSize: 23, color: AppColors.black),)
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
 