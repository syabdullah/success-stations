import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/offers/add_offers.dart';
import 'package:success_stations/view/offers/all_offer_detail.dart';
import 'package:success_stations/view/shimmer.dart';

class OffersDetail extends StatefulWidget {
  _MyOffersDetailState createState() => _MyOffersDetailState();
}

class _MyOffersDetailState extends State<OffersDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final putData = Get.put(OfferCategoryController());
  bool errorCheck = true;
  final delete = Get.put(UserOfferController());
  GetStorage box =GetStorage();
  var lang;
  @override
  void initState() {
    putData.drawerMyOffer();
    lang = box.read('lang_code');
    super.initState();
  }

  var listtype = 'list';
  var mediaList ,selectedIndex = 0, favourImage,  imageUploaded;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xfff2f2f2),
      key: _scaffoldKey,
      appBar: AppBar(
        // leadingWidth: 76,
        backgroundColor:Colors.white,
        title: Container(
            // margin: EdgeInsets.only(top: 12),
            child: Text(
                "my_offer".tr,
              style: TextStyle(

                  fontSize: 18,color: Colors.black,fontFamily: "Source_Sans_Pro",fontWeight: FontWeight.w400),
            )),
        centerTitle: true,
        leading: Container(
            margin: EdgeInsets.only( left: Get.width*0.008),
            child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child:  Padding(
                  padding:  EdgeInsets.all(Get.height*0.01),
                  child: Image.asset(AppImages.imagearrow1,
                      color: Colors.black, height: Get.height*0.022),
                ))),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AddOffersPage());
            },
            child: Center(
              child: Container(
                  // margin: EdgeInsets.only( left: 15,),
                  child: Image.asset(AppImages.plusImage,
                      color: Colors.black, height:Get.height*0.04)),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Get.to(AddLocations());
            },
            child: Center(
              child: Container(
                  margin: EdgeInsets.only( right:Get.width*0.001),
                  child: Image.asset(AppImages.setting,
                      color: Colors.black, height: Get.height*0.04)),
            ),
          ),
        ],),

      drawer: Theme(
        data: Theme.of(context).copyWith(),
        child: AppDrawer(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<OfferCategoryController>(
              init: OfferCategoryController(),
              builder: (val) {
                return val.isLoading == true  ? Center(
                  child: shimmer()
                )
                  : val.myofferListDrawer != null && val.myofferListDrawer['data'] != null
                ? Padding(
                  padding:  EdgeInsets.only(top: Get.height*0.0012),
                  child: Column(
                    children: allOffersWidget(val.myofferListDrawer['data'])
                  ),
                )
                : putData.resultInvalid.isTrue &&  val.myofferListDrawer['success'] == false
                ? Container(
                  margin: EdgeInsets.only(top: Get.height / 4),
                  child: Center(
                    child: Text(
                      putData.myofferListDrawer['errors'],
                      style: TextStyle(fontSize: 25)
                    ),
                  )
                ) : Container();
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> allOffersWidget(listFavou) {
    List<Widget> favrties = [];
    if (listFavou != null || listFavou.length != null) {
      for (int c = 0; c < listFavou.length; c++) {
        favrties.add(
          Padding(
            padding:  EdgeInsets.fromLTRB(Get.width*0.008,Get.height*0.013,Get.width*0.008, 0),
            child: Container(
              height: Get.height*0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black26
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Get.height / 4,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height*0.002,bottom:Get.height*0.002,left: Get.width*0.008,right:Get.width*0.008),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(MyOfferDetailMain(),
                              arguments: listFavou[c]);
                            },
                            child: listFavou[c]['image'] != null &&
                            listFavou[c]['image']['url'] != null?
                            ClipRRect(

                              child: Image.network(
                                listFavou[c]['image']['url'],
                                width: Get.width / 5.5,
                                height: Get.height/5.5,
                                fit: BoxFit.fill,
                              ),
                            ):Container(
                              width: Get.width / 4,
                              child: Icon(
                                Icons.image,size:Get.height*0.05,
                              ),
                            )
                          ),
                        )
                      ),
                      SizedBox(width:Get.width*0.005,),
                      Padding(
                        padding:  EdgeInsets.only(top:Get.height*0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child:
                              Padding(
                                padding: lang == 'ar' ?EdgeInsets.only(right : Get.width * 0.06):EdgeInsets.only(left : Get.width * 0.06),
                                child: Text(
                                  listFavou[c]['text_ads'][lang]!=null ?
                                  listFavou[c]['text_ads'][lang].toString():
                                  listFavou[c]['text_ads'][lang]==null?
                                  listFavou[c]['text_ads']['en'].toString():'',
                                   style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ),
                            // Container(
                            //     child:
                            //     Text(
                            //     "Catagory:Book,clothes",
                            //       style: TextStyle(
                            //         fontFamily: "Source_Sans_Pro",
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400
                            //       ),
                            //     )
                            // ),
                            // Container(
                            //     child:
                            //     Text(
                            //       "End date: 30 - fab - 2022",
                            //       style: TextStyle(
                            //           fontFamily: "Source_Sans_Pro",
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400
                            //       ),
                            //     )
                            // ),

                            // Container(
                            //   width: Get.width / 2.5,
                            //   child: ReadMoreText(
                            //    "End date: 30 - fab - 2022",
                            //     style: TextStyle(
                            //         fontFamily: "Source_Sans_Pro",
                            //         color: Colors.black,
                            //         fontSize:10
                            //     ),
                            //     trimLines: 2,
                            //     colorClickableText:AppColors.whitedColor,
                            //     trimMode: TrimMode.Line,
                            //     trimCollapsedText: 'Show more',
                            //     trimExpandedText: 'Show less',
                            //   ),
                            // ),
                            Container(
                              width: Get.width / 2.5,
                              child: Column(
                                children: [
                                  ReadMoreText(
                                     listFavou[c]['description'] != null ? listFavou[c]['description']['en']  : "",
                                    style: TextStyle(
                                      color: AppColors.inputTextColor,
                                      fontSize:2
                                    ),
                                    trimLines: 1,
                                    colorClickableText:AppColors.whitedColor,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                  ),
                                  listFavou[c]['url'] != null
                                      ? Text(listFavou[c]['url'],
                                      style: TextStyle(color: Color(0xFF2F4199))
                                  ) : Container()
                                ],
                              ),
                            ),

                          ]
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height*0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     listFavou[c]['status'] == 1 ? "NEW"
                      //     : listFavou[c]['status'] == 0 ? "OLD"
                      //     : listFavou[c]['status'] == null ? ''  : '',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //       fontStyle: FontStyle.normal,
                      //       color: listFavou[c]['status'] == 1
                      //       ? AppColors.snackBarColor
                      //       : AppColors.whitedColor,
                      //     )
                      //   )
                      // ),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal:Get.width*0.01,vertical:Get.height*0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                               // margin: EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {
                                  delete.deleteOfferController(listFavou[c]['id']);
                                },
                                child: Image.asset(AppImages.delete_offer,height: Get.height*0.035)
                              )
                            ),
                            SizedBox(width: Get.width*0.01,),
                            GestureDetector(
                              onTap: () {
                                Get.to(AddOffersPage(), arguments: listFavou[c]);
                              },
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: 10),
                                // padding: lang=='en'?EdgeInsets.only(right: 15):EdgeInsets.only(left: 10),
                                child: Image.asset(AppImages.edit_Offer, height:  Get.height*0.028)
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        );
      }
    }
    return favrties;
  }
}

List<Widget> dataempty(listFavou) {
  List<Widget> favrties = [];
  if (listFavou == null || listFavou.length == null) {
    for (int c = 0; c < listFavou.length; c++) {
      favrties.add(Card(child: Container(child: Text("noOfferyet".tr))));
    }
  }
  return favrties;
}
