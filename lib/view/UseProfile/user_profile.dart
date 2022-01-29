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
                    padding: const EdgeInsets.only(top: 30.0),
                    child: friendProfileShimmer(),
                  );
          }),
    );
  }

  Widget profileDetail(userData) {
    return Stack(
      children: [
        Container(
          height: Get.height / 2.8,
          width: Get.width,
          child: ClipRRect(
              // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30)),
              child: Image.asset(AppImages.profileBg, fit: BoxFit.fill)),
        ),
        Positioned(
          top: 150,
          left: 172,
          child: InkWell(
              onTap: () {
                // Get.back();
                // banner.bannerController();
              },
              child: Image.asset(
                AppImages.profileEdit,
                height: 60,
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
                onTap: () {
                  Get.back();
                  banner.bannerController();
                },
                child: Image.asset(
                  AppImages.profileBack,
                  height: 60,
                )),
            SizedBox(width: 225),
            InkWell(
                onTap: () {
                  // Get.back();
                  // banner.bannerController();
                },
                child: Image.asset(
                  AppImages.profileEdit,
                  height: 60,
                )),
          ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: Get.height / 8.5),
                  child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 40.0,
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
            userData["name"] != null
                ? Container(
                    margin: EdgeInsets.only(top: 10),
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
                    margin: EdgeInsets.only(top: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        userData["address"].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
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
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFf2f2f2),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("Personal Info"),
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: AppColors.darkblue),
                        )
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
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Text("Name" + ":  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          // color: Colors.grey
                                        )),
                                    userData["name"] != null
                                        ? Container(
                                            // margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                userData["name"].toString(),
                                                style: TextStyle()),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      //
                                      child: Text(
                                        'Email' + ":  ",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.grey
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
                                                                              20,
                                                                        )
                                                                      : EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    userData["mobile"] != null
                                        ? Container(
                                            // margin: EdgeInsets.only(top:),
                                            child: Text(
                                              "Phone" + ":  ",
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top:25),
                                      child: Text(
                                        "Country" + ":  ",
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top:25),
                                      child: Text(
                                        "Region".tr + ":  ",
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    userData["city"] != null
                                        ? Container(
                                            child: Text(
                                              "City" + ":  ",
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
                                height: 5,
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
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFf2f2f2),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("Study Info"),
                    ),
                    Text(
                      "Edit",
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
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
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
                                      'University' + ":  ",
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.grey
                                          ),
                                    ),
                                  ),
                                  userData != null &&
                                          userData['university'] != null
                                      ? Container(
                                          margin: EdgeInsets.only(top: 5),
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "College" + ':  ',
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Degree" + ":  ",
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
                                            height: 20,
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
                                height: 5,
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
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFf2f2f2),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("About me"),
                    ),
                    Text(
                      "Edit",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: lang == 'ar'
                      ? EdgeInsets.only(
                          right: 10,
                        )
                      : EdgeInsets.only(
                          left: 5,
                        ),
                  child: userData["about"] != null
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text("     " + userData["about"],
                              style: TextStyle(color: Colors.black)))
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
