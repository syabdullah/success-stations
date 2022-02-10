import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/subscription_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';

class IndividualMemeberShip extends StatefulWidget {
  @override
  _StateIndividualMemeberShip createState() => _StateIndividualMemeberShip();
}

class _StateIndividualMemeberShip extends State<IndividualMemeberShip> {
  bool statustogle = false;
  bool value = true;
  final memberShipCon = Get.put(MemberShipController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> memberShipDatta = [
    "profile".tr,
    "my_ads".tr,
    "my_location".tr,
    "my_offer".tr,
    "messeges".tr,
    "notification".tr,
    "friend_requests".tr,
    "favourite".tr,
  ];

  List<String> titles = [
    "Basic",
    "Advance",
    "Pro",
    "unlimited",
  ];
  List<String> ads_items = [
    "Unlimited",
    "Unlimited",
    "Unlimited",
    "Unlimited",
  ];
  List<String> branches = [
    "5 Locations",
    "10 Locations",
    "20 Locations",
    "Unlimited",
  ];
  List<String> promotions = [
    "1 Weekly",
    "2 Weekly",
    "10 Weekly",
    "Unlimited",
  ];
List<String> prize = [
    "49",
    "99",
    "199",
    "299",
  ];

  @override
  void initState() {
    super.initState();
    memberShipCon.getMemberShip();
  }

  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(20, context));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: GestureDetector(
              child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: EdgeInsets.only(left: Get.height * 0.01, top: Get.height * 0.005),
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                ),
              ),
            ],
          )),
          centerTitle: true,
          title: Text('mmembership'.tr),
          backgroundColor: AppColors.whitedColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
         SizedBox(height: Get.height * 0.01,),
            headingMember(),
            SizedBox(height: Get.height * 0.01,),
            GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: Get.height *0.01),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Get.height *0.01,

                  childAspectRatio: Get.height <700 ?  Get.height / 2.6 / Get.width / 1.1 : Get.height / 3.0 / Get.width / 1.1 ),


              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: Get.height < 700 ? Get.height *0.4 : Get.height *0.33,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Get.height *0.002),
                            child: Column(
                              children: [
                                SizedBox(height: Get.height *0.024),
                                Text(titles[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey)),
                                Padding(
                                  padding:  EdgeInsets.only(top: Get.height *0.03),
                                  child: Text("Company Profile",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: Get.height *0.008),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Ads Items: ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        Text(ads_items[index],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.whitedColor)),
                                      ],
                                    )),Padding(
                                    padding:  EdgeInsets.only(top: Get.height *0.008),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Branches: ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        Text(branches[index],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.whitedColor)),
                                      ],
                                    )),Padding(
                                    padding:  EdgeInsets.only(top: Get.height *0.008),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Promotions: ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        Text(promotions[index],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.whitedColor)),
                                      ],

                                    )),
                                SizedBox(height:Get.height *0.02),
                                Padding(
                                    padding:  EdgeInsets.only(top: Get.height *0.008),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                GetBuilder<MemberShipController>(
                  init: MemberShipController(),
                  builder: (val) {
                    return FractionalTranslation(
                      translation: const Offset(0.0, -0.5),
                      child:
                      // val.result != null
                      //                 ? Text(
                      //                     statustogle == false
                      //                         ? "\$ ${val.result['data']['monthly'].toString()}"
                      //                         : "\$ ${val.result['data']['yearly'].toString()}",
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 18),
                      //                   )
                      //                 : Text('')),
                      Center(
                          child:  Text(
                                  statustogle == false
                                      ? "20"
                                      : "120",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              // : Text('', style: TextStyle(
                              // fontSize: 13,
                              // // fontWeight: FontWeight.w400,
                              // color:Colors.orange))),
                    ));
                  },
                ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 13),
                                          child: Text("SAR",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color:Colors.orange)),
                                        ),
                                      ],
                                    )),
                                SizedBox(height:Get.height *0.01),
                                Container(
                                  height:Get.height/26,
                                  width:Get.width/3.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:AppColors.whitedColor
                                  ),
                                  child:  Center(
                                    child: Text("Subscribe",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:Colors.white)),
                                  ),
                                )

                              ],
                            ),
                          )),
                    ),
                  ],
                );
              },
            ),
            // Container(
            //   height: Get.height / 1.75,
            //   width: Get.width / 1.5,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16.0),
            //     border: Border.all(
            //       color: Colors.blue,
            //       style: BorderStyle.solid,
            //       width: 2.0,
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       space20,
            //       imagess(context),
            //       dataBox(),
            //     ],
            //   ),
            // ),
            // GetBuilder<MemberShipController>(
            //   init: MemberShipController(),
            //   builder: (val) {
            //     return FractionalTranslation(
            //       translation: const Offset(0.0, -0.5),
            //       child: Container(
            //         height: 50,
            //         width: 120,
            //         decoration: BoxDecoration(
            //           color: AppColors.whitedColor,
            //           borderRadius: BorderRadius.circular(10),
            //           // borderRadius: Border.all()
            //         ),
            //         child: Center(
            //             child: val.result != null
            //                 ? Text(
            //                     statustogle == false
            //                         ? "\$ ${val.result['data']['monthly'].toString()}"
            //                         : "\$ ${val.result['data']['yearly'].toString()}",
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 18),
            //                   )
            //                 : Text('')),
            //       ),
            //     );
            //   },
            // ),
            // space50,
            // submitButton(
            //     buttonText: 'update_succe'.tr,
            //     bgcolor: AppColors.whitedColor,
            //     textColor: AppColors.white,
            //     callback: navigateToHomeScreen),
          ],
        ),
      ),
    );
  }

  Widget headingMember() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: Get.height *0.015),
            child: Text('head_members'.tr,
                style: TextStyle(fontSize: 17, color: Colors.grey[600]))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text("monthly".tr,
                    style: TextStyle(color: AppColors.whitedColor))),
            SizedBox(
              width: Get.height *  0.005,
            ),
            Switch.adaptive(
                activeColor: Colors.blue,
                value: statustogle,
                onChanged: (newValue) {
                  setState(() {
                    statustogle = newValue;
                    // toggleSwitch(value);
                  });
                }),
            SizedBox(
              width: 5,
            ),
            Container(
                child: Text('yearly '.tr,
                    style: TextStyle(color: Colors.grey[400]))),
            Container(
                child: Text('15% off'.tr,
                    style: TextStyle(color: Colors.grey[600]))),
          ],
        ),
      ],
    );
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
            child: Text("pro_comp".tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500]))),
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
                          color: AppColors.whitedColor)),
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
  // PageUtils.pushPage(Payments());
}
