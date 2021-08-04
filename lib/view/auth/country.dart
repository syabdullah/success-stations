import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/country_controller.dart';
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
  Widget featureCountryList(countryListData){
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: Get.width < 420 ? Get.height/3.6: Get.height/4.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: countryListData.length, 
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ClipRRect(
                  // shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(80),
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60), bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                // padding: EdgeInsets.all(10),
                height: Get.height * 0.25,
                width: Get.width/4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    // color:Colors.grey
                      color: Colors.grey 
                   ),
                ),
                  // decoration: BoxDecoration(
                    
                  //   shape: BoxShape.circle,
                  //   border: Border.all(width: 5.0, color: Colors.white),
                  // ),
                  // width: Get.width < 420 ? Get.width/2.4: Get.width/2.3,
                  // height: Get.width < 420 ? Get.height/7.0:  Get.height/7.5,
                  child: Image.asset(AppImages.profileBg,)
                ),
              ),
              Container(
                child: Text(
                  countryListData[index]['name']
                )
              )

            ],
             
            ); 
       
        }
      ),
    );

  }

  // List<Widget> settingData(countryListData) {
  //   print(" sheeza setting data of the country ...!!!!!!!!!!!@@@@@@@@@@@@@@@@~~~~~~~~~~~~    $countryListData");
  //   List<Widget> settingz = [];
  //   for (int j = 0; j < countryListData.length; j++ ) {
  //     // var key = _dataSettings.keys.elementAt(j);
  //       settingz.add(
  //         Column(
  //           children: [
  //             // SizedBox(height:5),
  //             Container(
  //               height: Get.height/ 2,
  //               width: Get.width/ 7.0,
  //               child: ListView(
  //                 scrollDirection: Axis.horizontal,
  //                 children: [
  //                   Container(
  //                     // margin: EdgeInsets.only(left: 10),
  //                     // padding: EdgeInsets.only(top: 9),
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       border: Border.all(color: Colors.black),
  //                     ),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(60),
  //                       child: Icon(Icons.access_alarm_outlined),
  //                     ),
  //                   ),
  //                   SizedBox(height: 20),
  //                   Container(
  //                     // height: 100,
  //                     child: Center(
  //                       child: Text(
  //                         countryListData[j]['name']
  //                       )
  //                     )
  //                   )
  //                 ]
  //               ),
  //             ),
  //           ]
  //         ),
  //       );
  //   }
  //   return settingz; 
  // }


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
           SizedBox(height:40),
          chooseLanguage(),
          // SizedBox(height:40),
          GetBuilder<ContryController>(
            init: ContryController(),
            builder: (data){
              return data.isLoading == true ? CircularProgressIndicator(): 
             featureCountryList(data.countryListdata);
            
            },
          ),
          
          SizedBox(height:20),
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: "next".tr,
            fontSize: 18.toDouble()
            // callback: signIn
          ),
         SizedBox(height: 10),
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
            Text("have_account".tr, 
              style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300
              ),
            ),
            Text("sign_in".tr, style: TextStyle(fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
          ],
        ), 
      ),
    );
  }
  
  Widget chooseLanguage(){
    return Container(
      child: Text("choose_country".tr, style: TextStyle(fontSize: 23, color: AppColors.black),)
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
 