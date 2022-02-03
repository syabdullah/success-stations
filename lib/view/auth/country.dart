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
      height: MediaQuery.of(context).size.height / 1.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20.0,
              // mainAxisSpacing: 7.0,
              childAspectRatio: Get.height*0.5/Get.width*0.6
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
                    // SizedBox(height: Get.height * 0.017),
                    Container(
                        child: Text(
                          countryListData[index]['name'][lang] != null
                              ? countryListData[index]['name'][lang]
                              : '',
                          textAlign: TextAlign.center,

                          // countryListData[index]['name'][lang] !=null && countryListData[index]['name'][lang] != ' ' ? countryListData[index]['name'][lang] :
                          // countryListData[index]['name'][lang]  == null || countryListData[index]['name'][lang] == ' ' ?  countryListData[index]['name']['en']:'',

                          style: TextStyle(color: AppColors.inputTextColor),
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: Get.height * 0.05);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: AppColors.appBarBackGroundColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leadingWidth: 500,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppImages.roundedBack,
                          height: Get.height * 0.05,
                        )),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      "prev".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: "andada",
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.09),
                  child: Center(
                    child: Text("country".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "andada",
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: Divider(
                          color: Colors.black,
                        )),
                    Text(
                      " or ".tr,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
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
                // SizedBox(
                //   height: Get.height * 0.018,
                // ),

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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.002, vertical: Get.height * 0.005),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("have_account".tr,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey)),
              Text("sign_in".tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.appBarBackGroundColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
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
