import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/country_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/auth/tab_bar.dart';

class Ccountry extends StatefulWidget {
  _CountryPageState createState() => _CountryPageState();
}
class _CountryPageState extends State<Ccountry> {
  TextEditingController emailController = TextEditingController();

  var selectedIndex;
  GetStorage box = GetStorage();
  Widget featureCountryList(countryListData){
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height /4.30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: countryListData.length, 
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
                print(selectedIndex);
                box.write("country",selectedIndex);
              });
            },
            child: Column(
              children: [
                Container(
                  margin:EdgeInsets.only(left:20),
                  height: Get.height /6.25,
                  width: Get.width/3.4,
                  decoration: BoxDecoration(
                    border: Border.all( color: selectedIndex == index ? AppColors.appBarBackGroundColor: AppColors.grey,width: 5),
                    shape: BoxShape.circle,
                    image:  countryListData[index]['flag'] != null ?DecorationImage(
                      fit: BoxFit.fill,
                      image:  NetworkImage(countryListData[index]['flag']['url'])
                    ): null,
                  ),
                ),
                Container(
                  child: countryListData[index]['name'] !=null ? Text(
                    countryListData[index]['name']
                  ): Container()
                )
              ],
            ),
          ); 
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: getSize(50, context));
    final space100 = SizedBox(height: getSize(100, context));
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            space50, 
            mainLogo(),
            SizedBox(height:40),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: chooseLanguage()
            ),
            SizedBox(height:40),
            GetBuilder<ContryController>(
              init: ContryController(),
              builder: (data){
                return data.isLoading == true ? Container(
                 height: MediaQuery.of(context).size.height /4.30,
                ): featureCountryList(data.countryListdata);
              
              },
            ),
            submitButton(
              bgcolor: AppColors.appBarBackGroundColor,  
              textColor: AppColors.appBarBackGroun,
              buttonText: "next".tr,
              fontSize: 18.toDouble(),
              callback: (){
                Get.off(TabBarPage());
              }
               // callback: signIn
            ),
            space100,
            Container(
              child: existingAccount()
            ),
          ],
        ),
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
              style: TextStyle( fontSize: 17, fontWeight: FontWeight.w300
              ),
            ),
            Text("sign_in".tr, style: TextStyle(fontSize: 17,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
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
  next() {
    Get.toNamed('/signUp');
  }
}
 