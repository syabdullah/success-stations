import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/auth/sign_up/orLine.dart';
import 'package:success_stations/view/auth/tab_bar.dart';

class Ccountry extends StatefulWidget {
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<Ccountry> {
  TextEditingController emailController = TextEditingController();
  var countrycOde, countryId, selectedIndex, lang;
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
  }

  Widget featureCountryList(countryListData) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: countryListData.length,
          itemBuilder: (BuildContext context, int index) {
            print(
                "country name .....${countryListData[index]['name'][lang] == null || countryListData[index]['name'][lang] == ' '}");
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  box.write("country", selectedIndex);
                  box.write("country_id", countryListData[index]['id']);
                  box.write(
                      "country_code", countryListData[index]['short_code']);
                  countrycOde = countryListData[index]['short_code'];
                  countryId = countryListData[index]['id'];
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(TabBarPage(), arguments: countryListData[index]);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      height: Get.height / 9,
                      width: Get.width / 4,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: selectedIndex == index
                                ? AppColors.whitedColor
                                : Colors.transparent,
                            width: 2),
                        shape: BoxShape.circle,
                        image: countryListData[index]['flag'] != null
                            ? DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    countryListData[index]['flag']['url']))
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.017),
                  Container(
                      child: Center(
                    child: Text(
                      countryListData[index]['name'][lang] != null
                          ? countryListData[index]['name'][lang]
                          : '',
                      // countryListData[index]['name'][lang] !=null && countryListData[index]['name'][lang] != ' ' ? countryListData[index]['name'][lang] :
                      // countryListData[index]['name'][lang]  == null || countryListData[index]['name'][lang] == ' ' ?  countryListData[index]['name']['en']:'',

                      style: TextStyle(color: AppColors.inputTextColor),
                    ),
                  )),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: Get.height * 0.05);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "prev".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: "andada",
              ),
            ),
            backgroundColor: AppColors.appBarBackGroundColor,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppImages.roundedBack,
                )),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                child: Center(
                    child: Text("country".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "andada",
                        ))),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // mainLogo(),
                // SizedBox(height:40),
                /*Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: chooseLanguage()),*/
                SizedBox(height: Get.height * 0.13),
                GetBuilder<ContryController>(
                  init: ContryController(),
                  builder: (data) {
                    return data.isLoading == true
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2.30,
                          )
                        : featureCountryList(data.countryListdata);
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: HorizontalOrLine(label: "oR".tr, height: 2),
                ),
                SizedBox(
                  height: Get.height * 0.018,
                ),

                Container(child: existingAccount()),
              ],
            ),
          ),
        ));
  }

  Widget mainLogo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.06),
      child: Center(
        child: Image.asset(AppImages.appLogo, height: Get.height / 4.40),
      ),
    );
  }

  Widget existingAccount() {
    return GestureDetector(
      onTap: () {
        Get.to(SignIn());
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "have_account".tr,
              style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            ),
            Text(
              "sign_in".tr,
              style: TextStyle(
                  color: AppColors.whitedColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseLanguage() {
    return Container(
        child: Text(
      "choose_country".tr,
      style: TextStyle(fontSize: 23, color: AppColors.inputTextColor),
    ));
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
      width: width,
    );
  }

  next() {
    Get.toNamed('/signUp');
  }
}
