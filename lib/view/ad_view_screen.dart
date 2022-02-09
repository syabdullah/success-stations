import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shimmer.dart';

class AdViewScreen extends StatefulWidget {
  const AdViewScreen({Key? key}) : super(key: key);

  @override
  _AdViewScreenState createState() => _AdViewScreenState();
}

class _AdViewScreenState extends State<AdViewScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final adpostingController = Get.put(AdPostingController());
  final adDetailCont = Get.put(MyAddsController());
  final friCont = Get.put(FriendsController());
  GetStorage box = GetStorage();
  var id,
      adId,
      notificationID,
      aboutadID,
      lang,
      reviewPagePrice,
      price,
      htmldata = '';
  String? comment, myName;
  var user_image;

  @override
  void initState() {
    id = box.read('user_id');
    lang = box.read('lang_code');
    myName = box.read('name');
    user_image = box.read('user_image');
    adId = Get.arguments;
    aboutadID = Get.arguments;
    notificationID = Get.arguments;
    adDetailCont.adsDetail(adId);
    super.initState();
  }

  List<String> ImagesAdds = [
    "https://images.unsplash.com/photo-1643672206356-917a174844b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1491183846256-33aec7637311?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  ];

  postComment() {
    var json = {'listing_id': adId, 'comment': comment, 'user_name_id': id};
    adpostingController.commentPost(json);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      key: _scaffoldKey,
      bottomNavigationBar: GetBuilder<MyAddsController>(
          init: MyAddsController(),
          builder: (val) {
            return val.adsD != null && val.adsD['data'] != null
                ? SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  previousButton2(AppImages.callerImage, "call".tr,
                      Color(0xFF2F4199), val.adsD['data']),
                  previousButton(AppImages.whatsapp, "whatsapp".tr,
                      Color(0xFF2F4199), ''),
                  previousButton(AppImages.chating, "Massages".tr,
                      Color(0xFF2F4199), ''),
                  previousButton2(AppImages.heart, ''.tr,
                      Color(0xFF2F4199), val.adsD['data'])
                ],
              ),
            )
                : Container();
          }),
      // appBar: AppBar(
      //     leading: GestureDetector(
      //         child: Row(
      //       children: [
      //         GestureDetector(
      //           onTap: () => Get.back(),
      //           child: Container(
      //             margin: lang == 'en'
      //                 ? EdgeInsets.only(left: 10, top: 5)
      //                 : EdgeInsets.only(right: 10, top: 5),
      //             child: Icon(Icons.arrow_back, color: Colors.white, size: 25),
      //           ),
      //         ),
      //       ],
      //     )),
      //     centerTitle: true,
      //     backgroundColor: AppColors.whitedColor),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: GetBuilder<MyAddsController>(
                  init: MyAddsController(),
                  builder: (val) {
                    return val.isLoading == true || val.adsD == null
                        ? shimmer()
                        : val.adsD == null
                        ? Container(
                      child: Center(
                        child: Text("no_detail_here!".tr),
                      ),
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleStep(val.adsD['data']),
                        SizedBox(height: Get.height * 0.01),
                        listTileRow2(
                            val.adsD['data']['listing_comments']),
                        commentInput(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: commentButton(),
                        ),
                      ],
                    );
                  })),
          Container(
            height: Get.height * 0.08,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        AppImages.imagearrow1,
                        height: 20,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleStep(data) {
    price = data['price'].toString();
    reviewPagePrice = price.split('.');
    if (data != null) {
      htmldata =
      """ <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        ${data['description'][lang] != null ? data['description'][lang] : data['description'][lang] == null ? data['description']['en'] : ''}
      """;
    }
    return data == null
        ? Container(
      child: Text("no_detail_here".tr),
    )
        : Column(
      children: [
        data['image'].length != 0
            ? Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: Get.width / 1.0,
                height: Get.height * 0.45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.outline)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 8.0),
                  child: Image.network(data['image'][0]['url'],
                      width: Get.width / 1.0,
                      height: Get.height * 0.40,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              left: 5,
              child: Center(
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.10,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      color: Colors.black.withOpacity(0.3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 3),
                    child: Row(
                      children: [
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[0],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[1],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill)),
                        SizedBox(width: Get.width * 0.01),
                        Container(
                            height: Get.height * 0.90,
                            width: Get.width * 0.20,
                            child: Image.network(ImagesAdds[2],
                                height: Get.height * 0.20,
                                fit: BoxFit.fill))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
            : Container(
          height: Get.height / 4,
          child: Center(
            child: Icon(
              Icons.image,
              size: 50,
            ),
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Title :",
                          style: TextStyle(
                            color: AppColors.whitedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        data['title'][lang] != null
                            ? data['title'][lang].toString()
                            : data['title'][lang] == null
                            ? data['title']['en']
                            : '',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.grey)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8),
                        child: Text(
                          "Description : ",
                          style: TextStyle(
                            color: AppColors.whitedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Text(
                            """There are many variations of passages of LoremIpsum available, but the majority have suffered alteration in some form, by injected humour,randomised words which don't look eve……..
                """),
                      )
                    ]),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Category :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            "Books & Reference",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Type :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            "Digital marketing",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Location :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            data['country']['name'][lang] != null
                                ? data['country']['name'][lang]
                                : data['country']['name'][lang] == null
                                ? data['country']['name']['en']
                                : '',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Phone :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            data['phone'] != null
                                ? data['phone'].toString()
                                : '',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Price :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          data['price'] != null
                              ? Text(
                            ' ${reviewPagePrice[0]} SAR',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.46,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Status :",
                            style: TextStyle(
                              color: AppColors.whitedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            "New",
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "By",
                        style: TextStyle(
                          color: AppColors.whitedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.white54,
                          radius: 30.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: data['created_by'] != null &&
                                  data['created_by']['image'] != null
                                  ? CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: NetworkImage(
                                      data['created_by']['image']
                                      ['url']))
                                  : Icon(Icons.image))),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      data['created_by'] != null
                          ? Container(
                        child: Text(
                          data['created_by']['name'],
                          style: TextStyle(
                            color: Colors.grey,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),

              // Container(
              //     child: data['price'] != null
              //         ? Text(
              //             'SAR ${reviewPagePrice[0]}',
              //             style: TextStyle(
              //                 fontSize: 15,
              //                 color: AppColors.whitedColor),
              //           )
              //         : Container()),
              // Container(
              //   margin: lang == 'en'
              //       ? EdgeInsets.only(left: 30, bottom: 10)
              //       : EdgeInsets.only(left: 30, right: 30),
              //   child: Row(
              //     children: [
              //       Container(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(height: 20),
              //             Text('country'.tr,
              //                 style: TextStyle(
              //                     fontSize: 15,
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.grey)),
              //             SizedBox(height: 8.h),
              //             Text(
              //                 data['country']['name'][lang] != null
              //                     ? data['country']['name'][lang]
              //                     : data['country']['name'][lang] == null
              //                         ? data['country']['name']['en']
              //                         : '',
              //                 style: TextStyle(
              //                     fontSize: 15,
              //                     fontWeight: FontWeight.bold)),
              //             SizedBox(
              //               height: 11.h,
              //             ),
              //             Text(
              //               'city0'.tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.grey),
              //             ),
              //             SizedBox(height: 8.h),
              //             data['city'] != null
              //                 ? Text(
              //                     data['city']['city'][lang] != null
              //                         ? data['city']['city'][lang]
              //                         : data['city']['city'][lang] == null
              //                             ? data['city']['city']['en']
              //                             : '',
              //                     style: TextStyle(
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.bold),
              //                   )
              //                 : Container(),
              //             SizedBox(
              //               height: 11.h,
              //             ),
              //             Text(
              //               "city2".tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.grey),
              //             ),
              //             SizedBox(height: 7.h),
              //             Text(
              //               data['phone'] != null
              //                   ? data['phone'].toString()
              //                   : '',
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 15.h,
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.only(left: 60, right: 60),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(height: 20),
              //             Text(
              //               "region".tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.grey),
              //             ),
              //             SizedBox(height: 8.h),
              //             data['region'] != null
              //                 ? Text(
              //                     data['region']['region'][lang] != null
              //                         ? data['region']['region'][lang]
              //                         : data['region']['region'][lang] ==
              //                                 null
              //                             ? data['region']['region']['en']
              //                             : '',
              //                     style: TextStyle(
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.bold))
              //                 : Container(),
              //             SizedBox(height: 11.h),
              //             Text(
              //               "city1".tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.grey),
              //             ),
              //             SizedBox(height: 7.h),
              //             data['type'] != null
              //                 ? Text(
              //                     data['type']['type'][lang] != null
              //                         ? data['type']['type'][lang]
              //                             .toString()
              //                         : data['type']['type'][lang] == null
              //                             ? data['type']['type']['en']
              //                             : '',
              //                     style: TextStyle(
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.bold),
              //                   )
              //                 : Container(),
              //             SizedBox(
              //               height: 10.h,
              //             ),
              //             Text(
              //               'city3'.tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.grey),
              //             ),
              //             SizedBox(height: 7.h),
              //             Text(
              //               data['status'] == 0 ? 'old'.tr : 'new'.tr,
              //               style: TextStyle(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(height: 23.h),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        // Container(
        //   margin: lang == 'en'
        //       ? EdgeInsets.only(left: 30)
        //       : EdgeInsets.only(left: 30, right: 30),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: lang == 'en'
        //               ? EdgeInsets.only(left: 10)
        //               : EdgeInsets.only(left: 10),
        //           child: Text(
        //             "city4".tr,
        //             style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.grey),
        //           )),
        //       Html(data: htmldata)
        //     ],
        //   ),
        // ),
        // ListTile(
        //   title: Row(
        //     children: [
        //
        //       Padding(
        //         padding: lang == 'en'
        //             ? EdgeInsets.only(left: 4.0)
        //             : EdgeInsets.only(right: 8.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //
        //             Container(
        //               alignment: Alignment.topLeft,
        //               child: Text(
        //                 "owner".tr,
        //                 style: AppTextStyles.appTextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.normal,
        //                   color: Colors.grey,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        //   trailing: GestureDetector(
        //     onTap: () {
        //       Get.to(FriendProfile(),
        //           arguments: ["ads", data['created_by']['id']]);
        //     },
        //     child: Container(
        //       margin: EdgeInsets.only(bottom: 15),
        //       child: Text(
        //         "${"see_profile".tr}",
        //         style: AppTextStyles.appTextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.normal,
        //             color: AppColors.whitedColor),
        //       ),
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 20, right: 20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Text("adpostedat".tr,
        //           style: TextStyle(color: Colors.grey[700])),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget listTileRow2(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("There are 2 comments",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
        Container(
          height: Get.height * 0.32,
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        height: Get.height * 0.15,
                        width: Get.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Colors.white54,
                                            radius: 20.0,
                                            child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(50.0),
                                                child: data[index]
                                                ['user_name'] !=
                                                    null &&
                                                    data[index]['user_name']
                                                    ['image'] !=
                                                        null
                                                    ? CircleAvatar(
                                                    backgroundColor:
                                                    Colors.grey[200],
                                                    backgroundImage:
                                                    NetworkImage(data[index]
                                                    ['user_name']
                                                    ['image']['url']))
                                                    : Image.asset(AppImages.person))),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: Get.width / 3,
                                                  child: data[index][
                                                  'user_name'] !=
                                                      null &&
                                                      data[index]['user_name']
                                                      ['name'] !=
                                                          null
                                                      ? Text(
                                                    data[index]
                                                    ['user_name']
                                                    ['name'],
                                                    style: AppTextStyles
                                                        .appTextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                      : Container()),
                                              Text(data[index]['created_at'],
                                                  style: AppTextStyles
                                                      .appTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        var json = {
                                          'user_reported': data[index]
                                          ['user_name']['id']
                                        };
                                        friCont.userReport(json, null);
                                      },
                                      child: Image.asset(
                                        AppImages.flag,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                  // mytraling(data[index])
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Container(
                                width: Get.width / 2.5,
                                child: Text(
                                  data[index]['comment']['en'],
                                  style: AppTextStyles.appTextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  // Widget mytraling(idU) {
  //   return
  // }

  Widget commentButton() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      height: Get.height * 0.04,
      width: Get.width,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0xFF2F4199)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: Color(0xFF2F4199))))),
        onPressed: () {
          postComment();
          adDetailCont.adsDetail(adId);
          comment = '';
        },
        child: Container(
            child: Text('add_a_comment'.tr, style: TextStyle(fontSize: 18))),
      ),
    );
  }

  Widget previousButton(image, text, Color color, data)  {
    return InkWell(

      onTap: () async {
        if (text == AppString.fav) {
          Get.toNamed('/favourities');
        } else if (text == "whatsapp") {
          const url = "https://wa.me/?text=Your Message here";
          var encoded = Uri.encodeFull(url);
          launch(encoded);
        } else {
          const uri = 'sms:+39 348 060 888?body=hello%20there';
          await launch(uri);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whitedColor),
          color: Colors.white,
        ),
        height: Get.height * 0.047,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(image, width: Get.width * 0.08),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previousButton2(image, text, Color color, data) {
    return InkWell(
      onTap: () {
        if (image == AppImages.heart) {
          Get.toNamed('/favourities');
        } else {
          launch("tel:${data['phone']}");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whitedColor),
          color: Colors.white,
        ),
        height: Get.height * 0.045,
        // width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(image, width: Get.width * 0.08),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget previousButton2(image, text, Color color, data) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
  //     // onPressed: () {
  //     //   if (text == AppString.fav) {
  //     //     Get.toNamed('/favourities');
  //     //   } else {
  //     //     launch("tel:${data['phone']}");
  //     //   }
  //     // },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: AppColors.whitedColor),
  //         color: Colors.white,
  //       ),
  //       height: 40.h,
  //       width: 80.w,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Image.asset(image, width: Get.width * 0.08),
  //           Text(
  //             text,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget commentInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 10),
      child: TextFormField(
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            comment = val;
          });
        },
        style: TextStyle(
          color: AppColors.black,
          fontSize: 15,
        ),
        // fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          fillColor: AppColors.whitedColor.withOpacity(0.1),
          filled: true,
          contentPadding: lang == 'en'
              ? EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 80.0)
              : EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 80.0),
          hintText: "write_comment_here".tr,
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputTextColor),
            borderRadius: BorderRadius.circular(0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputTextColor),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
