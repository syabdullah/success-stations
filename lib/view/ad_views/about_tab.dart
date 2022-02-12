import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
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
  const AboutTab({ Key? key }) : super(key: key);
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
        height: Get.height,
        // padding: EdgeInsets.symmetric(horizontal:10),
        child: ListView(

          children: [
            GetBuilder<UserProfileController> (
              init: UserProfileController(),
              builder: (value) {
                return  value.userData2 != null ?
                detail( value.userData2['data'], context):ProfilePageShimmer();
              }
            ), Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "lastads".tr,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:AppColors.black)
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Viewall".tr,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14, color:Color(0XFF888888))
                  ),
                ),
              ],
            ),
            GetBuilder<LastAdsController>(
              init: LastAdsController(),
              builder: (value){
                return  value.isLoading == true ? PlayStoreShimmer(): value.lastuserads != null && value.lastuserads['data'].length  !=0?
                lastAds(value.lastuserads['data']):
                Center(
                  heightFactor: 4,
                  child: Text(
                    "noAdds".tr,
                   style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color:AppColors.black)
                  )
                );
              }
            ),
            // SizedBox(height:30),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${'lastoffers'.tr}",
                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:AppColors.black)
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Viewall".tr,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14, color:Color(0XFF888888))
                  ),
                ),
              ],
            ),
            GetBuilder<UserOfferController>(
              init: UserOfferController(),
              builder: (value){
                return  value.isLoading == true ? PlayStoreShimmer():
                value.offerDattaTypeCategory != null && value.offerDattaTypeCategory['data'].length  !=0  ?
                lastOffer(value.offerDattaTypeCategory['data']):
                 Center(
                   heightFactor: 4,
                    child: Text("noOffer".tr,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color:AppColors.black)

                  )
                );
              }
            ),
            // SizedBox(height:30),
            // Container(
            //   margin: lang=='en'? EdgeInsets.only(left:08):EdgeInsets.only(right:08),
            //   child: Text("${'lastlocation'.tr}",
            //     style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color:AppColors.black),
            //   ),
            // ),
            // GetBuilder<LastLocationController>(
            //   init: LastLocationController(),
            //   builder: (value){
            //     return
            //     value.lastLocation !=null &&value.lastLocation['data']!=null ?
            //     // lastLocation( value.lastLocation['data']) :
            //     Center(
            //       heightFactor: 4,
            //       child: Text(
            //         "noLoaction".tr,
            //          style: TextStyle(fontSize: 15,fontWeight:FontWeight.normal,color:AppColors.black),
            //       ),
            //     );
            //   }
            // ),
          ],
        ),
      ),
    );
  }
}

Widget detail(userData2, context){
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(border: Border.all(color: Color(0XFFcccccc))),
        padding: EdgeInsets.only(left:20),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: Get.width,
        child: Container(
          margin: EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'details'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
              ),
              // SizedBox(height:5),
              userData2 !=null && userData2['about'] != null ?
                Text(
                  userData2['about'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),
                )
              : Container()
            ],
          ),
        ),
      ),
      // Column(
      //   children: [
      //     Container(
      //       margin: lang == 'ar'? EdgeInsets.only(right:30, left:20,top:5) :EdgeInsets.only(left:10,right:Get.height/7, top:5),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(  "${'nameph'.tr} :",
      //             style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
      //           ),
      //           Text(
      //             "${'email'.tr} :",
      //             style: TextStyle(
      //               fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     Container(
      //       margin: lang == 'ar'? EdgeInsets.only(right:20,left:12,top:5) :EdgeInsets.only(left:10,right: 40,top:5),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children:[
      //           userData2!=null &&  userData2['name'] !=null ?
      //             Text(
      //               userData2['name'],style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),
      //             )
      //           :Container(),
      //           Column(
      //             children: [
      //               userData2 !=null &&  userData2['email'] != null ?
      //               Container(
      //                 child: GestureDetector(
      //                   onTap: (){
      //                     showDialog(
      //                       context: context,
      //                       builder: (context) {
      //                         return Dialog(
      //                           child: Container(
      //                             height: Get.height/7,
      //                             child: Column(
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 Container(
      //                                   margin: lang == 'en'? EdgeInsets.only(left:20,top:10): EdgeInsets.only(right:20,top:10),
      //                                   child:Text("${'email'.tr}:",)
      //                                 ),
      //                                 Container(
      //                                   margin: lang == 'en'? EdgeInsets.only(left:20,top:10): EdgeInsets.only(right:20,top:10),
      //                                   child: Text( userData2['email'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),)
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         );
      //                       }
      //                     );
      //                   },
      //                   child: Text(
      //                     userData2['email'].length > 15 ? userData2['email'].substring(0, 15)+'...' : userData2['email'],
      //                     style: TextStyle(fontWeight: FontWeight.w600)
      //                   ),
      //                 ),
      //               ):Container(),
      //             ],
      //           )
      //         ]
      //       ),
      //     ),
      //     Container(
      //       margin: lang == 'ar'? EdgeInsets.only(right:20,left:40,top:5) :EdgeInsets.only(left:10,right: Get.height/8,top:5),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             "${'mobile'.tr} :",
      //             style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
      //           ),
      //           Text(
      //             "${'address'.tr} :",
      //             style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       margin: lang == 'ar'? EdgeInsets.only(right:20,left:10,top:5) :EdgeInsets.only(left:10,right:9,top:5),
      //        child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           userData2 !=null &&  userData2['mobile'] != null ?
      //           Text(
      //             userData2['mobile'],
      //             style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),
      //           )
      //           :Container(),
      //           Column(
      //             children: [
      //               userData2 !=null && userData2['address'] != null ?
      //               Container(
      //                 child: GestureDetector(
      //                   onTap: (){
      //                     showDialog(
      //                       context: context,
      //                       builder: (context) {
      //                         return Dialog(
      //                           child: Container(
      //                             height: Get.height/7,
      //                             child: Column(
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 Container(
      //                                   margin: lang =='en'? EdgeInsets.only(left:20,top:10):EdgeInsets.only(right:20,top:10) ,
      //                                   child:Text("${'address'.tr}:",)
      //                                 ),
      //                                 Container(
      //                                    margin: lang == 'en'? EdgeInsets.only(left:20,top:10): EdgeInsets.only(right:20,top:10),
      //                                   child: Text(userData2['address'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),)
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         );
      //                       }
      //                     );
      //                   },
      //                   child: Center(
      //                     child: Container(
      //                       margin: lang == 'en'? EdgeInsets.only(right:60): EdgeInsets.only( left:26),
      //                       child: Text(
      //                         userData2['address'].length > 17 ? userData2['address'].substring(0, 17)+'...' : userData2['address'],
      //                         style: TextStyle(fontWeight: FontWeight.w600)
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ):Container(),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     SizedBox(height:10)
      //   ],
      // ),
    ],
  );
}

Widget lastOffer(offerDattaTypeCategory){
  return Container(
    height: Get.height/4,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: offerDattaTypeCategory.length,
      itemBuilder: (BuildContext context,index) {
        return Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: offerDattaTypeCategory[index]['image'] != null && offerDattaTypeCategory[index]['image']['url'] !=null ?
              GestureDetector(
                onTap: (){
                  Get.to(MyOfferDetailMain() , arguments: offerDattaTypeCategory[index]);
                },
                child: Container(
                  width: Get.width/2.4,
                  height: Get.height/5.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(

                      offerDattaTypeCategory[index]['image']['url'],fit: BoxFit.cover
                    ),
                  ),
                ),
              )
              :Container(
                width: Get.width/2.3,
                height: Get.height/5.0,
                child: Icon(Icons.image)
              )
            ),
            Container(
              child: Text(
                offerDattaTypeCategory[index]['text_ads'][lang]!= null ? offerDattaTypeCategory[index]['text_ads'][lang] :
                offerDattaTypeCategory[index]['text_ads'][lang] == null ? offerDattaTypeCategory[index]['text_ads']['en'] :'',
                style: TextStyle(color: Colors.grey),
              )
            )
          ],
        );
      }
    ),
  );
}

var imageGived;
Widget lastAds(lastuserad){
  return Container(
    margin: EdgeInsets.symmetric(vertical:10),
    height: Get.height > 800 ? Get.height/4.50:Get.height/3.5,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lastuserad.length,
      itemBuilder: (BuildContext context,index) {
        if(lastuserad !=null && lastuserad[index]['image'] !=null){
          for(int c = 0; c<lastuserad[index]['image'].length;  c++){
            imageGived = lastuserad[index]['image'][c]['url'];
          }
        }
        return GestureDetector(
          onTap: (){
            Get.to(AdViewScreen(),arguments:lastuserad[index]["id"]);
          },
                child: lastuserad[index]['is_active'] == 0
                    ? Container()
                    : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Container(
                      color: Colors.white,
                      margin:
                      EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        height: 125,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Center(
                                    child: Container(
                                        width: Get.width / 4,
                                        height: Get.height / 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GestureDetector(
                                              child: lastuserad[index]
                                              ['image']
                                                  .length !=
                                                  0
                                                  ? ClipRRect(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        0)),
                                                child: Image.network(
                                                  lastuserad[index]
                                                  ['image'][0]
                                                  ['url'],
                                                  width: Get.width / 4,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : Container(
                                                width: Get.width / 4,
                                                child: Icon(
                                                  Icons.image,
                                                  size: 50,
                                                ),
                                              )),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.height * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            lastuserad[index]['title']['en']
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    lastuserad[index]
                                                    ['price'] !=
                                                        null
                                                        ? "${100}"
                                                        : '',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    )),
                                                Text(
                                                  " " + "sar".tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  ' Store name',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.height *0.2,
                                                ),
                                                Text(
                                                  ' New',
                                                  style: TextStyle(
                                                      color:
                                                      AppColors.new_color,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // SizedBox(height: 20),
                                    // Column(
                                    //   children: [
                                    //     Padding(
                                    //         padding: EdgeInsets.all(10.0),
                                    //         child: CircleAvatar(
                                    //             backgroundColor: Colors.grey[200],
                                    //             child: Icon(
                                    //               Icons.person,
                                    //               color:
                                    //                   AppColors.whitedColor,
                                    //             ))),
                                    //     Container(
                                    //         margin: EdgeInsets.only(right: 5, left: 5),
                                    //         child: Row(
                                    //           children: [
                                    //             GestureDetector(
                                    //               onTap: () {
                                    //                 var json = {
                                    //                   'ads_id': allDataAdds[index]['id']
                                    //                 };
                                    //                 allDataAdds[index]['is_favorite'] ==
                                    //                         false
                                    //                     ? friCont.profileAdsToFav(
                                    //                         json, userId)
                                    //                     : friCont.profileAdsRemove(
                                    //                         json, userId);
                                    //                 controller.addedAllAds();
                                    //                 controller.addedByIdAddes(
                                    //                     allDataAdds[index]
                                    //                         ['category_id'],
                                    //                     null);
                                    //               },
                                    //               child: Container(
                                    //                   padding: EdgeInsets.only(
                                    //                       right: 5, left: 5),
                                    //                   child: allDataAdds[index]
                                    //                               ['is_favorite'] ==
                                    //                           false
                                    //                       ? Image.asset(
                                    //                           AppImages.blueHeart,
                                    //                           height: 25)
                                    //                       : Image.asset(
                                    //                           AppImages.redHeart,
                                    //                           height: 25)),
                                    //             ),
                                    //             Container(
                                    //                 child: allDataAdds[index]
                                    //                             ['phone'] !=
                                    //                         null
                                    //                     ? GestureDetector(
                                    //                         onTap: () {
                                    //                           launch(
                                    //                               "tel:${allDataAdds[index]['phone']}");
                                    //                         },
                                    //                         child: Image.asset(
                                    //                             AppImages.call,
                                    //                             height: 25))
                                    //                     : Container())
                                    //           ],
                                    //         ))
                                    //   ],
                                    // ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ));
      }
    ),
  );
}

// Widget lastLocation(locLast){
//   return Container(
//     margin: EdgeInsets.symmetric(vertical:10),
//     height: Get.height > 400 ? Get.height/4.6:Get.height/4,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: locLast.length,
//       itemBuilder: (BuildContext context,index) {
//         return GestureDetector(
//           onTap: (){},
//           child: Container(
//             width: Get.width/2,
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child:  Column(
//                 children: [
//                    locLast[index]['image'] !=null&&  locLast[index]['image']['url']!= null ?
//                     ClipRRect(
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
//                       child: Container(
//                         width: Get.width/2.0,
//                         height: Get.height/7.5,
//                         child: locLast[index]['image']['url'] !=null  ?Image.network(locLast[index]['image']['url'],fit: BoxFit.cover,) : Container()
//                       ),
//                     )
//                   :Container(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
//                       child: Image.asset(AppImages.junaid,
//                         height: 117,fit: BoxFit.cover,width: Get.width
//                       )
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left:10,right: 10),
//                     child: locLast[index]['location'] != null ?
//                       Text(
//                         locLast[index]['location'],
//                         style: TextStyle(color: Colors.grey)
//                       )
//                     :Container()
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     ),
//   );
// }

// Widget lastLocations(lastLocation){
//   return Container(
//     margin: EdgeInsets.symmetric(vertical:10),
//     //  height: Get.height/5.5,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 4,
//       itemBuilder: (BuildContext context,index) {
//         return Container(
//           width: 250,
//           height: 100,
//           child: Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left:15),
//                       child: Image.asset(AppImages.location,color: Colors.blue)
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top:10.0,left: 15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               lastLocation['data'][index]['location'] != null ?
//                               Container(
//                                 width: Get.width/3,
//                                 child: Text(
//                                   lastLocation['data'][index]['location'],textAlign: TextAlign.left,
//                                   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
//                                 ),
//                               ): Container(),
//                             ],
//                           ),
//                           SizedBox(height: 3,),
//                           Row(
//                             children: [
//                               Text("city: ",  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10)),
//                               lastLocation['data'][index] != null && lastLocation['data'][index]['locality'] !=null?
//                               Text(lastLocation['data'][index]['locality'],
//                               style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
//                               ): Container(),
//                               SizedBox(width: 5,),
//                             ],
//                           ),
//                           SizedBox(height: 3,),
//                           Row(
//                             children: [
//                               Text("Country: " ,  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10)),
//                               lastLocation['data'][index]["country_name"] != null ?
//                               Text(
//                                 lastLocation['data'][index]["country_name"],
//                                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
//                               ): Container(),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       }
//     ),
//   );
// }

void handleClick(int item) {
  switch (item) {
    case 0:
    break;
    case 1:
    break;
  }
}