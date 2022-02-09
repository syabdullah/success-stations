import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/messages/chatting_page.dart';
import 'package:success_stations/view/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendProfile extends StatefulWidget {
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile>
    with SingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  final friCont = Get.put(FriendsController());
  final chatCont = Get.put(ChatController());
  bool liked = false;
  var city,
      id,
      selectedUser,
      requister,
      textHolder,
      notifyid,
      adID,
      dtaaa,
      lang;
  bool choice = false;

  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
    selectedUser = box.read("selected");
    requister = box.read("requister");
    dtaaa = Get.arguments;
    id = dtaaa[1];
    friCont.friendDetails(id);
    friCont.profileAds(id);
  }

  List<String> title = [
    'Damascum University',
    'Syrian Center For Computer Studies'
  ];
  List<String> subtitle = ['Bachelor dgrees', 'academic , software '];
  List<String> time = ['2005 - 2010', '2003 - 2005'];
  List<String> grade = ['A1', 'Good'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: GetBuilder<FriendsController>(
            init: FriendsController(),
            builder: (val) {
              return val.friendProfileData == null || val.userAds == null
                  ? SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(top: 40),
                      child: friendProfileShimmer()))
                  : val.friendProfileData['success'] == false &&
                  val.friendProfileData['errors'] ==
                      'No Profile Available'
                  ? Container(
                child: Center(
                    child: Text(val.friendProfileData['errors'])),
              )
                  : Column(
                children: [
                  profileDetail(val.friendProfileData['data']),
                  tabs(val.friendProfileData['data']),
                  general(val.friendProfileData['data'],
                      val.userAds['data']),
                ],
              );
            }),
      ),
    );
  }

  var image;
  var country;

  Widget profileDetail(data) {
    if (data != null) {
      country = data['country'];
    }

    if (data != null && data['image'] != null) {
      image = data['image']['url'];
      box.write('chat_image', image);
    } else {
      image = null;
      box.remove('chat_image');
    }
    return Stack(
      children: [
        Container(
          height:Get.height<700?Get.height/2.5:Get.height/2.6,
          width: Get.width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            child: Container(
                child: Image.asset(
                  AppImages.topImage,
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.05,
              right: Get.width * 0.03,
              left: Get.width * 0.03),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                AppImages.roundedBack,
                height: Get.height * 0.04,
              )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                margin: EdgeInsets.only(
                    left: 0.0, right: 10.0, top: Get.height / 16),
                child: data != null && data['image'] != null
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(data['image']['url']),
                  radius: 50.0,
                )
                    : CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: Get.height*0.06,
                    child: Icon(
                      Icons.person,
                      size: Get.height * 0.07,
                      color: Colors.black,
                    )),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: Get.height * 0.01),
                child: data != null
                    ? Text(data['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:lang =='ar' ?20:25,
                        fontWeight: FontWeight.w600))
                    : Text(
                  " ",
                )),
            // Container(
            //   margin: EdgeInsets.only(top: 0, left:Get.width*0.015),
            //   child: data != null && data['degree'] != null
            //       ? Text(data['degree'].toString(),
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.w400))
            //       : Text(""),
            // ),
            country != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Get.height * 0.015),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        country['name'][lang] != null
                            ? country['name'][lang]
                            : country['name'][lang] == null
                            ? country['name']['en']
                            : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          // fontWeight: FontWeight.w400
                        )),
                  ),
                ),
              ],
            )
                : Container(),

            GestureDetector(
                onTap: () {
                  setState(() {
                    choice = !choice;
                    if (data['is_user_friend'].length == 0 ||
                        data['is_user_friend'] == null) {
                      var json = {'friend_send_request_to': id};
                      friCont.sendFriend(json);
                    } else {
                      friCont.deleteFriend(
                          data['is_user_friend'][0]['id'], 'pro');
                    }
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(top: Get.height * 0.015),
                    width: Get.width / 2.5,
                    height: Get.height * 0.055,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: data == null || data['is_user_friend'] == null
                        ? Center(
                      child: Text("addFriend".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    )
                        : Center(
                      child: choice == false ||
                          data['is_user_friend'].length != 0
                          ? Text("cancel".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))
                          : Text(
                        "addFriend".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ))),
          ],
        ),
      ],
    );
  }

  Widget tabs(name) {
    return Container(
      height:Get.height<700?Get.height*0.065:Get.height*0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.outline, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: Get.height * 0.06,
            width: Get.width /2 ,
            child: TabBar(
                unselectedLabelColor: Color(0xFF0d0d0d),
                unselectedLabelStyle: TextStyle(
                  // fontWeight: FontWeight.w700,
                  fontSize:16,
                  color: Colors.black,
                ),
                labelColor: AppColors.appBarBackGroundColor,
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                labelStyle: TextStyle(
                  // fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                indicatorColor: Colors.transparent,
                // indicator: UnderlineTabIndicator(
                //   borderSide:
                //   BorderSide(color: AppColors.whitedColor, width: 2.0),
                // ),
                tabs: [
                  Stack(
                    children: [
                      _individualTabwithoutline('about'.tr),
                      Padding(
                        padding: lang == 'ar' ? EdgeInsets.only(right: Get.width * 0.19,top: Get.width * 0.03,bottom: Get.width * 0.03,) :EdgeInsets.only(left: Get.width * 0.19,top: Get.width * 0.03,bottom: Get.width * 0.03,),
                        child: VerticalDivider(thickness: 2,color: Color(0xFF0d0d0d),),
                      ),
                    ],
                  ),
                  _individualTabwithoutline(
                    'item'.tr,
                  )
                ]),
          ),
          Row(children: [
            SizedBox(width: Get.width * 0.015),
            InkWell(child: Image.asset(AppImages.callerImage, height: Get.height * 0.035),onTap: ()  {
              launch("tel:123456789");
            },),
            SizedBox(width: Get.width * 0.015),
            GestureDetector(
                onTap: () {
                  chatCont.createConversation(id);
                  Get.to(ChattinPagePersonal(), arguments: [0, name['name']]);
                },
                child:
                Image.asset(AppImages.chating, height: Get.height * 0.045)),
            SizedBox(width: Get.width * 0.015),
            InkWell(child: Image.asset(AppImages.whatsapp, height: Get.height * 0.035),onTap: (){
              const url = "https://wa.me/?text=Your Message here";
              var encoded = Uri.encodeFull(url);
              launch(encoded);
            },),
            SizedBox(width: Get.width * 0.015),
          ])
        ],
      ),
    );
  }

  Widget _individualTab(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
      child: Container(
        height: Get.height * 0.02,
        padding: EdgeInsets.all(0),
        width: Get.width,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    color: AppColors.border,
                    width: 2,
                    style: BorderStyle.solid))),
        child: Tab(
            child: Text(title,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12,
                ))),
      ),
    );
  }

  Widget _individualTabwithoutline(String title) {
    return Container(
      height: 60 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.all(0),
      width: 100,
      decoration: BoxDecoration(),
      child: Tab(
          child: Text(title,
              style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize:  Get.height<700?10:11.4,
              ))),
    );
  }

  Widget general(data, adsData) {
    return Expanded(
      flex: 1,
      child: TabBarView(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text("about".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                          data != null && data["about"] != null
                              ? Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  data["about"] != null
                                      ? data["about"].toString()
                                      : '',
                                  style: TextStyle(color: Colors.black)))
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical:Get.height * 0.015),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text('education'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                          data != null && data["about"] != null
                              ? SizedBox(
                            height: Get.height * 0.3,
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (cntx, i) {
                                return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Get.height * 0.03),
                                        child: Row(children: [
                                          Padding(
                                            padding:  EdgeInsets.only(bottom:Get.height * 0.05),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                Colors.grey,
                                                radius: 20.0,
                                                child: Icon(
                                                  Icons.person,
                                                  size: Get.height * 0.04,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                Get.width * 0.02),
                                            child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(title[i],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                  SizedBox(
                                                    height: Get.height *
                                                        0.005,
                                                  ),
                                                  Text(subtitle[i]),
                                                  Text(time[i],
                                                      style: TextStyle(
                                                          color:
                                                          Color(0XFFB9B9B9))),

                                                  Row(
                                                    children: [

                                                      Text('Grade: '.tr,
                                                          style: TextStyle(
                                                          )),  Text(grade[i],
                                                          style: TextStyle(
                                                          )),
                                                    ],
                                                  ),
                                                ]),
                                          )
                                        ]),
                                      ),

                                    ]);
                              },
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                )
                /*   Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: lang == 'ar'
                                  ? EdgeInsets.only(
                                      right: 20,
                                    )
                                  : EdgeInsets.only(
                                      left: 20,
                                    ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "name".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  data != null && data['name'] != null
                                      ? Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(data['name'].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.only(top: 25),
                                    child: Text(
                                      "mobile".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  data != null && data['mobile'] != null
                                      ? Text(data['mobile'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.only(top: 25),
                                    child: Text(
                                      "country".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  data != null && data['country'] != null
                                      ? Text(
                                          data['country']['name'][lang] != null
                                              ? data['country']['name'][lang]
                                              : data['country']['name'][lang] ==
                                                      null
                                                  ? data['country']['name']
                                                      ['en']
                                                  : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'email'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                data != null
                                    ? Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Container(
                                                      height: Get.height / 7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      top: 10),
                                                              child: Text(
                                                                  "email".tr)),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 5,
                                                                      left: 20),
                                                              child: Text(
                                                                data["email"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                              data["email"].length > 20
                                                  ? data["email"]
                                                          .substring(0, 20) +
                                                      '...'
                                                  : data["email"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: GestureDetector(
                                      child: Text(
                                    "address".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )),
                                ),
                                data != null
                                    ? Container(
                                        margin:
                                            EdgeInsets.only(bottom: 20, top: 5),
                                        child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: Get.height / 7,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child: Text(
                                                                    "Address"
                                                                        .tr)),
                                                            data["address"] !=
                                                                    null
                                                                ? Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      data["address"]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ))
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: data["address"] != null
                                                ? Text(
                                                    data["address"].length > 20
                                                        ? data["address"]
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : data["address"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600))
                                                : Container()),
                                      )
                                    : Container(height: 45),
                                Container(
                                  child: GestureDetector(
                                      child: Text(
                                    "city".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )),
                                ),
                                data != null && data['city'] != null
                                    ? Text(
                                        data['city']['city'][lang] != null
                                            ? data['city']['city'][lang]
                                            : data['city']['city'][lang] == null
                                                ? data['city']['city']['en']
                                                : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600))
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                /* Card(
                  elevation: 2,
                  child: Container(
                    padding: lang == 'ar'
                        ? EdgeInsets.only(
                            right: 20,
                          )
                        : EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 25),
                                      child: Text(
                                        "college".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    data != null && data['college'] != null
                                        ? Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                                data['college']['college']
                                                            [lang] !=
                                                        null
                                                    ? data['college']['college']
                                                        [lang]
                                                    : data['college']['college']
                                                                [lang] ==
                                                            null
                                                        ? data['college']
                                                            ['college']['en']
                                                        : '',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        : Container(),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "degree".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    data != null && data["degree"] != null
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20, top: 5),
                                            child: Text(
                                                data["degree"] != null
                                                    ? data["degree"].length > 13
                                                        ? data["degree"]
                                                                .substring(
                                                                    0, 13) +
                                                            '...'
                                                        : data["degree"]
                                                    : ' ',
                                                // data["degree"].length > 13 ? data["degree"] .substring(0, 13) +'...': data["degree"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        : Container(height: 20)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 14),
                                    child: Text(
                                      'university'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  data != null && data['university'] != null
                                      ? Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                              data['university']['name']
                                                          [lang] !=
                                                      null
                                                  ? data['university']['name']
                                                      [lang]
                                                  : data['university']['name']
                                                              [lang] ==
                                                          null
                                                      ? data['university']
                                                          ['name']['en']
                                                      : '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.only(top: 23),
                                    child: Text(
                                      "semester".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  data != null && data["semester"] != null
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20, top: 5),
                                          child: Text(
                                              data["semester"] != null
                                                  ? data["semester"].toString()
                                                  : '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      : Container(height: 20)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          ads(adsData),
        ],
      ),
    );
  }

  Widget ads(adsData) {
    return ListView.builder(
      itemCount: adsData != null ? adsData.length : 0,
      itemBuilder: (BuildContext context, index) {
        return adsData != null
            ? GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width*0.015,vertical: Get.height*0.004),
            decoration: BoxDecoration(
                color:Colors.white,
                border: Border.all(
                    color: AppColors.outline
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: Get.height*0.15,
                    child: Padding(
                      padding:  EdgeInsets.all(Get.height*0.01),
                      child: GestureDetector(
                          child:  ClipRRect(
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: adsData[index]['image'].length != 0
                                  ? Image.network(
                                adsData[index]['image'][0]['url'],
                                width: Get.width / 6,
                                fit: BoxFit.cover,
                              ):Container(
                                  height: Get.height / 7,
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                  ))
                          )
                      ),
                    )),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding:  EdgeInsets.only(bottom: Get.height*0.005),
                        child: Container(
                            child: Text(
                              "Teaching the brain to read book\n at a special price from",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Source_Sans_Pro",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: Get.height*0.005),
                        child: Container(
                            child: Text(
                              "55.22 " + "SAR",
                              style: TextStyle(
                                  fontFamily: "Source_Sans_Pro",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(bottom: Get.height*0.005),
                        child: Container(
                            child: Text(
                              "Jarir Bookstore",
                              style: TextStyle(
                                fontFamily: "Source_Sans_Pro",
                                color: Colors.black,
                                // fontWeight: FontWeight.w600
                              ),
                            )),
                      ),

                    ]),
                Column(

                    children: [

                      Padding(
                        padding:  EdgeInsets.only(left: Get.width<700?Get.width*0.07:Get.width*0.09,
                            right:Get.width<700?Get.width*0.07: Get.width*0.09,top: Get.height * 0.045),
                        child: Container(
                            child: Text(
                              "New",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Source_Sans_Pro",
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),




                    ]),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       width: Get.width / 3,
                //       child: Text(
                //         adsData[index]['title']['en'],
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     SizedBox(height: 5),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(AppImages.location, height: 15),
                //       ],
                //     ),
                //     SizedBox(height: 5),
                //     Row(
                //       children: [
                //         Image.asset(
                //           AppImages.person,
                //           height: 15,
                //         ),
                //         SizedBox(width: 5),
                //         Container(
                //           child: Text(adsData[index]['contact_name'],
                //               style:
                //                   TextStyle(fontWeight: FontWeight.w600)),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                // Column(
                //   children: [
                //     image != null
                //         ? CircleAvatar(
                //             backgroundImage: NetworkImage(image),
                //             radius: 20.0,
                //           )
                //         : CircleAvatar(
                //             backgroundColor: Colors.grey,
                //             radius: 20.0,
                //             child: Icon(
                //               Icons.person,
                //               size: 20,
                //               color: Colors.black,
                //             )),
                //     SizedBox(height: 5),
                //     Container(
                //       margin: EdgeInsets.only(left: 20, right: 30),
                //       child: Row(
                //         children: [
                //           GestureDetector(
                //               onTap: () {
                //                 var json = {
                //                   'ads_id': adsData[index]['id']
                //                 };
                //                 liked = !liked;
                //                 adsData[index]['is_favorite'] == false
                //                     ? friCont.profileAdsToFav(json, id)
                //                     : friCont.profileAdsRemove(json, id);
                //               },
                //               child: adsData[index]['is_favorite'] == true
                //                   ? Image.asset(AppImages.redHeart,
                //                       height: 20)
                //                   : Image.asset(
                //                       AppImages.blueHeart,
                //                       height: 20,
                //                     )),
                //           SizedBox(width: 5),
                //           GestureDetector(
                //               onTap: () {
                //                 launch.call("tel:12345678912");
                //               },
                //               child: Image.asset(
                //                 AppImages.call,
                //                 height: 20,
                //               ))
                //         ],
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        )
            : Container(
          child: Text("No_Ads_Yet".tr),
        );
      },
    );
  }
}
