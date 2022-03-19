import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/shimmer.dart';

class UserProfile extends StatefulWidget {
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with AutomaticKeepAliveClientMixin<UserProfile> {
  var lang, userimage, id;
  bool liked = false;
  final dataUser = Get.put(UserProfileController());
  final banner = Get.put(BannerController());
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
    userimage = box.read('user_image');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserProfileController>(
          init: UserProfileController(),
          builder: (val) {
            return val.userData != null
                ? Column(
                    children: [
                      profileDetail(val.userData['data']),
                      general(val.userData['data'])
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(top: Get.width * 0.04),
                    child: friendProfileShimmer(),
                  );
          }),
    );
  }

  Widget profileDetail(userData) {
    return Stack(
      children: [
        Container(
          child: Container(
            height: Get.height<700?Get.height / 2.3:Get.height / 2.7,
            width: Get.width,
            child: Image.asset(AppImages.profileBg, fit: BoxFit.fill),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Get.width * 0.08),
          child:
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width *0.015,vertical:Get.height *0.005 ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
                  onTap: () {
                    Get.back();
                    banner.bannerController();
                  },
                  child: Image.asset(
                    AppImages.profileBack,
                    height: Get.width * 0.1,
                  )),

            InkWell(
                  onTap: () {

                  },
                  child: Image.asset(
                    AppImages.profileEdit,
                    height: Get.width * 0.1,
                  )),
          ]),
              ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(
                          left: Get.width * 0.010,
                          right: Get.width * 0.010,
                          top: Get.height < 700 ? 70 : 70),
                      child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          // backgroundColor: Colors.black,
                          radius:Get.height < 700 ?40: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: userData['image'] == null
                                ? Image.asset(AppImages.person)
                                : Image.network(
                                    userData['image']['url'],
                                    fit: BoxFit.fill,
                                    height: Get.height / 5,
                                  ),
                          ))),
                ),
                Positioned(
                  top: Get.height < 700 ? 138 : 155,
                  left: Get.width * 0.458,
                  child: InkWell(
                      onTap: () {
                        // Get.back();
                        // banner.bannerController();
                      },
                      child: Image.asset(
                        AppImages.profileEdit,
                        height: Get.width * 0.09,
                      )),
                ),
              ],
            ),
            userData["name"] != null
                ? Container(
                    margin: EdgeInsets.only(top: Get.width * 0.06),
                    child: Text(userData["name"].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  )
                : Container(),

            //
            userData["address"] != null
                ? Container(
              width: Get.width/2,
                    margin: EdgeInsets.only(top: Get.width * 0.01),
                    child: Text(
                      userData["address"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ))
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget general(userData) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: Get.width * 0.12,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFf2f2f2),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Personal Info".tr ,style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,

                        color: AppColors.black),),
                            Text(
                              "Edit".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.darkblue),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // margin: lang == 'ar'? EdgeInsets.only(right:20,top: 10) :EdgeInsets.only(left: 20,top: 10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Get.width * 0.02,
                                    bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Text("name".tr + ":  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black
                                        )),
                                    userData["name"] != null
                                        ? Container(
                                            // margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                userData["name"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black
                                                )),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      //
                                      child: Text(
                                        'email'.tr + ":  ",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black
                                            ),
                                      ),
                                    ),
                                    userData["email"] != null
                                        ? Container(
                                            // margin: EdgeInsets.only(top:5),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: Container(
                                                          height:
                                                              Get.height / 7,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  // margin: EdgeInsets.only(left:20,top:10),
                                                                  child: Text(
                                                                      "email"
                                                                          .tr)),
                                                              Container(
                                                                  margin: lang ==
                                                                          'ar'
                                                                      ? EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              Get.width * 0.05,
                                                                        )
                                                                      : EdgeInsets
                                                                          .only(
                                                                          left: Get.width *
                                                                              0.05,
                                                                        ),
                                                                  child: Text(
                                                                    userData[
                                                                            "email"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                  userData["email"].length > 20
                                                      ? userData["email"]
                                                              .substring(
                                                                  0, 20) +
                                                          '...'
                                                      : userData["email"],
                                                  style: TextStyle()),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    userData["mobile"] != null
                                        ? Container(
                                            // margin: EdgeInsets.only(top:),
                                            child: Text(
                                              "phone".tr + ":  ",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Colors.grey
                                                  ),
                                            ),
                                          )
                                        : Container(),
                                    Text(userData["mobile"].toString(),
                                        style: TextStyle()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top:25),
                                      child: Text(
                                        "country".tr + ":  ",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.grey
                                            ),
                                      ),
                                    ),
                                    Text(
                                        userData["country"]["name"][lang] !=
                                                null
                                            ? userData["country"]["name"][lang]
                                                .toString()
                                            : userData["country"]["name"]
                                                        [lang] ==
                                                    null
                                                ? userData["country"]["name"]
                                                    ['en']
                                                : '',
                                        style: TextStyle()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top:25),
                                      child: Text(
                                        "region".tr + ":  ",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.grey
                                            ),
                                      ),
                                    ),
                                    userData["region"] != null
                                        ? Text(
                                            userData["region"]["region"]
                                                        [lang] !=
                                                    null
                                                ? userData["region"]["region"]
                                                        [lang]
                                                    .toString()
                                                : userData["region"]["region"]
                                                            [lang] ==
                                                        null
                                                    ? userData["region"]
                                                        ["region"]['en']
                                                    : '',
                                            style: TextStyle())
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    userData["city"] != null
                                        ? Container(
                                            child: Text(
                                              "city".tr + ":  ",
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Colors.grey
                                                  ),
                                            ),
                                          )
                                        : Container(),
                                    userData["city"] != null
                                        ? Text(
                                            userData["city"]["city"][lang] !=
                                                    null
                                                ? userData["city"]["city"][lang]
                                                : userData["city"]["city"]
                                                            [lang] ==
                                                        null
                                                    ? userData["city"]["city"]
                                                        ['en']
                                                    : '',
                                            style: TextStyle())
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.width * 0.01,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 5),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Container(
                    //           // margin: EdgeInsets.only(top:15),
                    //           child: GestureDetector(
                    //               child: Text(
                    //             "address".tr,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.grey),
                    //           )),
                    //         ),
                    //         userData["address"] != null
                    //             ? Container(
                    //                 // margin: EdgeInsets.only(bottom:20,top: 5),
                    //                 child: GestureDetector(
                    //                   onTap: () {
                    //                     showDialog(
                    //                         context: context,
                    //                         builder: (context) {
                    //                           return Dialog(
                    //                             child: Container(
                    //                               height: Get.height / 7,
                    //                               child: Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .start,
                    //                                 children: [
                    //                                   Container(
                    //                                       margin:
                    //                                           EdgeInsets.only(
                    //                                               top: 10),
                    //                                       child: Text(
                    //                                           "Address".tr)),
                    //                                   Container(
                    //                                       margin:
                    //                                           EdgeInsets.only(
                    //                                               top: 5),
                    //                                       child: Text(
                    //                                         userData["address"]
                    //                                             .toString(),
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             color: Colors
                    //                                                 .black),
                    //                                       )),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           );
                    //                         });
                    //                   },
                    //                   child: Text(
                    //                       userData["address"].length > 20
                    //                           ? userData["address"]
                    //                                   .substring(0, 20) +
                    //                               '...'
                    //                           : userData["address"],
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.w600)),
                    //                 ),
                    //               )
                    //             : Container(
                    //                 height: 45,
                    //               ),
                    //
                    //         userData["account_types"] != null
                    //             ? Container(
                    //                 child: Text(
                    //                   "Account_type".tr,
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Colors.grey),
                    //                 ),
                    //               )
                    //             : Container(),
                    //         Text(userData["account_type"].toString(),
                    //             style: TextStyle(fontWeight: FontWeight.w600)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Container(
              height: Get.width * 0.12,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFf2f2f2),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Study Info".tr,style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,

                        color: AppColors.black)),
                    Text(
                      "Edit".tr,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.darkblue,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.width * 0.02),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(top:14,),
                                    child: Text(
                                      'university'.tr + ":  ",
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.grey
                                          ),
                                    ),
                                  ),
                                  userData != null &&
                                          userData['university'] != null
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: Get.width * 0.01),
                                          child: Text(
                                              userData['university']['name']
                                                          [lang] !=
                                                      null
                                                  ? userData['university']
                                                      ['name'][lang]
                                                  : userData['university']
                                                              ['name'][lang] ==
                                                          null
                                                      ? userData['university']
                                                          ['name']['en']
                                                      : '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle()),
                                        )
                                      : Container(),
                                ],
                              ),

                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.width * 0.01),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "college".tr + ':  ',
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.grey
                                            ),
                                      ),
                                    ),
                                    userData != null &&
                                            userData['college'] != null
                                        ? Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                                userData['college']['college']
                                                            [lang] !=
                                                        null
                                                    ? userData['college']
                                                        ['college'][lang]
                                                    : userData['college']
                                                                    ['college']
                                                                [lang] ==
                                                            null
                                                        ? userData['college']
                                                            ['college']['en']
                                                        : '',
                                                style: TextStyle()),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "degree".tr + ":  ",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.grey
                                            ),
                                      ),
                                    ),
                                    userData["degree"] != null
                                        ? Container(
                                            child: Text(
                                                userData["degree"].length > 30
                                                    ? userData["degree"]
                                                            .substring(0, 30) +
                                                        '...'
                                                    : userData["degree"],
                                                style: TextStyle()),
                                          )
                                        : Container(
                                            height: Get.width * 0.04,
                                          )
                                  ],
                                ),
                              ),
                              // Container(
                              //   // margin: EdgeInsets.only(top:23,),
                              //   child: Text(
                              //     "Semester" + ":  ",
                              //     style: TextStyle(
                              //         // fontWeight: FontWeight.bold,
                              //         // color: Colors.grey
                              //     ),
                              //   ),
                              // ),
                              // userData["semester"] != null
                              //     ? Container(
                              //         // margin: EdgeInsets.only(bottom:20,),
                              //         child: Text(
                              //             userData["semester"].toString(),
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.w600)),
                              //       )
                              //     : Container(
                              //         height: 20,
                              //       ),
                              SizedBox(
                                height: Get.width * 0.02,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.width * 0.12,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFf2f2f2),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("aboutme".tr,style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,

                        color: AppColors.black)),
                    Text(
                      "Edit".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: AppColors.darkblue),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: lang == 'ar'
                      ? EdgeInsets.only(
                          right: Get.width * 0.02,
                        )
                      : EdgeInsets.only(
                          left: Get.width * 0.01,
                        ),
                  child: userData["about"] != null
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: Text("     " + userData["about"],
                                style: TextStyle(color: Colors.black)),
                          ))
                      : Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
