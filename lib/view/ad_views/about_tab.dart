import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:success_stations/view/auth/my_adds/all_ads.dart';
import 'package:success_stations/view/auth/offer_list.dart';
import '../../main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/last_ads_controller.dart';
import 'package:success_stations/controller/last_location_controller.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/offers/all_offer_detail.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key}) : super(key: key);
  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  GetStorage box = GetStorage();
  final userProfile = Get.put(UserProfileController());
  final lastads = Get.put(LastAdsController());
  final userOffers = Get.put(UserOfferController());
  final lastLoc = Get.put(LastLocationController());
  var id, lang;
  int offer = 0;

  @override
  void initState() {
    id = Get.arguments;
    userProfile.getUseradProfile(id);
    lastads.userOfferList(id);
    userOffers.userOfferList(id);
    lastLoc.userlocationList(id);
    lang = box.read('lang_code');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf2f2f2),
      body: Container(
        // height: Get.height,
        // padding: EdgeInsets.symmetric(horizontal:10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<UserProfileController>(
                  init: UserProfileController(),
                  builder: (value) {
                    return value.userData2 != null
                        ? detail(value.userData2['data'], context)
                        : ProfilePageShimmer();
                  }),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("lastads".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0XFF2f44a0))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(AllAdds());
                        },
                        child: Text("Viewall".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0XFF888888))),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<LastAdsController>(
                  init: LastAdsController(),
                  builder: (value) {
                    return value.isLoading == true
                        ? PlayStoreShimmer()
                        : value.lastuserads != null &&
                                value.lastuserads['data'].length != 0
                            ? featuredAdsList(value.lastuserads['data'])
                            : Center(
                                heightFactor: 4,
                                child: Text("noAdds".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.black)));
                  }),
              // SizedBox(height:30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("${'lastoffers'.tr}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0XFF2f44a0))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(OfferList());
                      },
                      child: Text("Viewall".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0XFF888888))),
                    ),
                  ),
                ],
              ),
              GetBuilder<UserOfferController>(
                  init: UserOfferController(),
                  builder: (value) {
                    return value.isLoading == true
                        ? PlayStoreShimmer()
                        : value.offerDattaTypeCategory != null &&
                                value.offerDattaTypeCategory['data'].length != 0
                            ? offerList(value.offerDattaTypeCategory['data'])
                            : Center(
                                heightFactor: 4,
                                child: Text("noOffer".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.black)));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget detail(userData2, context) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Color(0XFFcccccc))),
    padding:lang == 'ar' ? EdgeInsets.only(right: 8):EdgeInsets.only(left: 8),
    margin: EdgeInsets.symmetric(horizontal: 6),
    width: Get.width,
    child: Container(
      margin: EdgeInsets.only(top: 7, bottom: 7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${'details'.tr}:",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0XFF2f44a0)),
          ),
          // SizedBox(height:5),
          userData2 != null && userData2['about'] != null
              ? Text(
                  userData2['about'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )
              : Container()
        ],
      ),
    ),
  );
}
//
// Widget lastOffer(offerDattaTypeCategory){
//   return Container(
//     height: Get.height/4,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: offerDattaTypeCategory.length,
//       itemBuilder: (BuildContext context,index) {
//         return Column(
//           children: [
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: offerDattaTypeCategory[index]['image'] != null && offerDattaTypeCategory[index]['image']['url'] !=null ?
//               GestureDetector(
//                 onTap: (){
//                   Get.to(MyOfferDetailMain() , arguments: offerDattaTypeCategory[index]);
//                 },
//                 child: Container(
//                   width: Get.width/2.4,
//                   height: Get.height/5.0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//
//                       offerDattaTypeCategory[index]['image']['url'],fit: BoxFit.cover
//                     ),
//                   ),
//                 ),
//               )
//               :Container(
//                 width: Get.width/2.3,
//                 height: Get.height/5.0,
//                 child: Icon(Icons.image)
//               )
//             ),
//             Container(
//               child: Text(
//                 offerDattaTypeCategory[index]['text_ads'][lang]!= null ? offerDattaTypeCategory[index]['text_ads'][lang] :
//                 offerDattaTypeCategory[index]['text_ads'][lang] == null ? offerDattaTypeCategory[index]['text_ads']['en'] :'',
//                 style: TextStyle(color: Colors.grey),
//               )
//             )
//           ],
//         );
//       }
//     ),
//   );
// }

var catID;

Widget featuredAdsList(lastuserad) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    height: lang == 'en'
        ? Get.height < 700
            ? Get.height / 2.2
            : Get.width < 420
                ? Get.height / 2.8
                : Get.height / 4.35
        : Get.height < 700
            ? Get.height / 3.2
            : Get.width < 420
                ? Get.height / 2.8
                : Get.height / 4.35,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: lastuserad.length,
        itemBuilder: (BuildContext context, index) {
          var doubleval = double.parse(lastuserad[index]['price']);
          var price = doubleval.toInt();
          return GestureDetector(
            onTap: () {
              // Get.to(AdViewScreen());
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height:
                        Get.height < 700 ? Get.width * 0.29 : Get.width * 0.48,
                    child: lastuserad[index].length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(lastuserad[index],
                                width: Get.width < 420
                                    ? Get.width / 3.1
                                    : Get.width / 3.3,
                                height: Get.width < 420
                                    ? Get.height / 4.8
                                    : Get.height / 9.5,
                                fit: BoxFit.fill),
                          )
                        : Container(
                            child: Icon(Icons.image, size: 50),
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                            child: Text("name of author",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Source_Sans_Pro",
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(children: [
                          Container(
                              child: lastuserad[index]['price'] != null
                                  ? Text(
                                      ' SAR' + "{$price}",
                                      style: TextStyle(
                                          fontFamily: "Source_Sans_Pro",
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Container()),
                          Container(
                              child: lastuserad[index]['price'] != null
                                  ? Text(
                                      '$price' + ".00",
                                      style: TextStyle(
                                          fontFamily: "Source_Sans_Pro",
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Container()),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(lastuserad[index]['name'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "Source_Sans_Pro",
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
  );
}

Widget offerList(offerDattaTypeCategory) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    height: 150,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offerDattaTypeCategory.length,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: GestureDetector(
                  onTap: () {
                    // Get.to(MyOfferDetailMain());
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white)),
                        width: 120,
                        height: 120,
                        child: offerDattaTypeCategory[index]['media'].length !=
                                    0 &&
                                offerDattaTypeCategory[index]['media'][0]
                                        ['url'] !=
                                    null
                            ? Image.network(
                                offerDattaTypeCategory[index]['media'][0]
                                    ['url'],
                                fit: BoxFit.cover,
                              )
                            : Container(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                              )),
                  ),
                ),
              ),
            ],
          );
        }),
  );
}

void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}
