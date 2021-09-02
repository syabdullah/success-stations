import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/member_ship/payment_tap.dart';
import 'package:success_stations/view/membership/userOrderInformation.dart';

class IndividualMemeberShip extends StatefulWidget {
  @override
  _StateIndividualMemeberShip createState() => _StateIndividualMemeberShip();
}

class _StateIndividualMemeberShip extends State<IndividualMemeberShip> {
  bool statustogle = false;

  List<String> memberShipDatta = [
    "Profile",
    "My Ads",
    "My Locations",
    "My Offers",
    "Messages",
    "Notifications",
    "Friend Requests",
    "Favourites",
  ];
  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: getSize(50, context));
    final space20 = SizedBox(height: getSize(20, context));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: sAppbar(context, Icons.arrow_back_ios, AppImages.appBarLogo)),
      body: Column(
        children: [
          space20,
          headingMember(),
          space20,
          Container(
            height: Get.height / 1.9,
            width: Get.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.blue,
                style: BorderStyle.solid,
                width: 1.0,
              ),
            ),
            child: Column(
              children: [
                space20,
                imagess(context),
                dataBox(),
              ],
            ),
          ),
          space50,
          submitButton(
              buttonText: 'UPDATE SUBSCRITIPN',
              bgcolor: AppColors.appBarBackGroundColor,
              textColor: AppColors.appBarBackGroun,
              callback: navigateToHomeScreen),
        ],
      ),
    );
  }

  Widget headingMember() {
    return Container(
        margin: EdgeInsets.only(left: 0),
        child: Text("You can use following services in Pro Company",
            style: TextStyle(fontSize: 17, color: Colors.grey[600])));
  }

  Widget imagess(context) {
    final space20 = SizedBox(height: getSize(20, context));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            child: Image.asset(
          AppImages.memberShip,
          height: 30,
        )),
        space20,
        Container(
            child: Text("PRO(Company)",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500]))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text("Monthly",
                    style: TextStyle(color: AppColors.appBarBackGroundColor))),
                    SizedBox(width: 5,),
            Container(
                child: FlutterSwitch(
              width: 50.0,
              height: 25.0,
              valueFontSize: 25.0,
              toggleSize: 45.0,
              value: statustogle,
              borderRadius: 30.0,
              // padding: 8.0,
              // showOnOff: true,
              onToggle: (val) {
                setState(() {
                  print("object......$val");
                  statustogle = val;
                });
              },
            )),
            SizedBox(width: 5,),
            Container(
                child:
                    Text("Yearly", style: TextStyle(color: Colors.grey[400]))),
          ],
        ),
      ],
    );
  }

  Widget dataBox() {
    return Flexible(
      child: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
    
          //shrinkWrap: true,
          itemCount: memberShipDatta.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(memberShipDatta[index],
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.appBarBackGroundColor)),
                ),
              ],
            );
          }),
    );
  }

  Widget submitButton(
      {buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      fontWeight}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
}

void navigateToHomeScreen() {
  // Get.to(UserInformation());
  PageUtils.pushPage(Payments());
}
