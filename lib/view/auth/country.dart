import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';

class Ccountry extends StatefulWidget {
  _CountryPageState createState() => _CountryPageState();
}
class _CountryPageState extends State<Ccountry> {
  var languageList = ["English", "العربية",]; 
  final Map<String, dynamic> _dataSettings= {
  "First Name": [
    { 
      "images": "assets/images/saudia flags.png",
      "text": "Misar",
    },
    {
      "images": "assets/images/misar.png",
      "text": "Saudia",
    
    },
    {
       "images": "assets/images/arab.png",
      "text": "Arab",
     
    },
  ],
};
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

  List<Widget> settingData() {
    List<Widget> settingz = [];
    for ( int j = 0; j < _dataSettings.length; j++ ) {
      var key = _dataSettings.keys.elementAt(j);
      for ( int k =0 ; k < _dataSettings[key].length; k++ ) {
        settingz.add(
          Column(
            children: [
              SizedBox(height:5),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(top: 9),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                child:
                 ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(_dataSettings[key][k]['images'],
                    width: 110.0, height: 110.0),
              )),
                //  Image.asset(_dataSettings[key][k]['images'])
              
              SizedBox(height: 20),
              Container(
                child:Center(
                  child: Text(_dataSettings[key][k]['text'])
                )
              ),
            ]
          ),
        );
      }
    }
    return settingz; 
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
           SizedBox(height:50),
          chooseLanguage(),
           SizedBox(height:50),
          Row(
           children:
             settingData()
          ),
          SizedBox(height:50),
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: AppString.next,
            fontSize: 18.toDouble()
            // callback: signIn
          ),
         SizedBox(height: 30),
          Container(
            alignment: Alignment.bottomRight,
            child: existingAccount()),
          // space50,
          
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
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
}
 