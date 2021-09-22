// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/offer_filtered.dart';
import 'package:success_stations/view/offer_grid_filtered.dart';
import 'package:success_stations/view/offers/add_offers.dart';
import 'package:success_stations/view/offers/home_all_offer_detail.dart';

class OfferList extends StatefulWidget {
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  var offerid;
  final contByCatOffer = Get.put(OfferCategoryController());
  final coCatOffer = Get.put(OfferController());
  final banner = Get.put(BannerController());
  var json;
  int slctedInd = 0;
  onSelected(int index) {
    setState(() => slctedInd = index);
  }

  var lang;
  var listtype = 'grid';
  bool allOffer = false;
  bool allTextOpr = false;
  bool isButtonPressed = false;
  final offerFilterCont = Get.put(OffersFilteringController());
  final offeCont = Get.put(MyOffersDrawerController());
  var selectedIndex = 0;
  bool lisselect = false;
  var id;
  var grid = AppImages.gridOf;
  Color selectedColor = AppColors.appBarBackGroundColor;
  Color listIconColor = AppColors.appBarBackGroundColor;
  var bottomSheetCategory = 0;
  Color filterCategoryColor = AppColors.appBarBackGroundColor;
  var selectedIndexListing = 0;
  var listImg = AppImages.listing;
  var status;
  var category;
  var statusFiltered;
  var start;
  var end;
  var filterID;
  var usertype;
  List<String> itemsList = [
    "old".tr,
    "New".tr,
  ];
  GetStorage box = GetStorage();

  var cardHeight;
  var cardwidth;
  @override
  void initState() {
    // offerFilterCont.offerFilter(json);
    banner.bannerController();
    super.initState();
    coCatOffer.offerList();
    contByCatOffer.myAllOffers();
    allOffer = false;
    offerid = Get.arguments;
    lang = box.read('lang_code');
    usertype = box.read('user_type');
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    cardwidth = MediaQuery.of(context).size.width / 3.3;
    cardHeight = MediaQuery.of(context).size.height / 3.6;
    return Scaffold(
      key: _scaffoldKey,
      appBar: offerid != null
      ? PreferredSize(preferredSize: Size.fromHeight(70.0),
        child: appbar(  _scaffoldKey, '', AppImages.appBarLogo, " ", '')
      )
      : null,
      drawer: Theme(
        data: Theme.of(context).copyWith( ),
        child: AppDrawer(),
      ),
      body: ListView(
        children: [
        SizedBox(height: 10),
        topWidget(),
        SizedBox(height: 20),
        GetBuilder<OfferCategoryController>(
          init: OfferCategoryController(),
          builder: (val) {
            return val.allOffersResp != null &&
            val.allOffersResp['data'] != null
            ? subOffers(val.allOffersResp['data'])
            : Container();
          },
        ),
          SizedBox(height:20),
          allOffer == false ? 
          GetBuilder<OfferController>(
            init: OfferController(),
              builder: (val) {
                return val.offerDataList != null && val.offerDataList['data'] != null && val.offerDataList['success'] == true
                ? listtype == 'grid' ? allUsers(val.offerDataList['data']) : listUsers(val.offerDataList['data'])
                : contByCatOffer.resultInvalid.isTrue && val.offerDataList['success'] == false
                ? Container(
                  margin: EdgeInsets.only(top: Get.height / 3),
                  child: Center(
                    child: Text(
                      coCatOffer.offerDataList['errors'],
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ) : Container();
              }
            ):
            GetBuilder<OfferCategoryController>(
            init: OfferCategoryController(),
              builder: (val) {
                return val.iDBasedOffers != null && val.iDBasedOffers['data'] != null && val.iDBasedOffers['success'] == true
                ? listtype == 'grid' ? allUsers(val.iDBasedOffers['data']): listUsers(val.iDBasedOffers['data'])
                : contByCatOffer.resultInvalid.isTrue && val.iDBasedOffers['success'] == false
                ? Container(
                  margin: EdgeInsets.only(top: Get.height / 3),
                  child: Center(
                    child: Text(
                      contByCatOffer.iDBasedOffers['errors'],
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ): Container();
              }
            ),
          ]
        )
      );
    }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                filteringCategory();
              },
              child: Container(
                margin: lang == 'en'
                    ? EdgeInsets.only(left: 15, top: 8)
                    : EdgeInsets.only(right: 15, top: 8),
                //width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),

                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: [
                    Image.asset(AppImages.filter, height: 15),
                    SizedBox(width: 5),
                    Text(
                      "filter".tr,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AddOffersPage());
              },
              child: usertype == 2 || usertype == 3
                  ? Container()
                  : Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset(AppImages.plusImage, height: 24,)),
            )
          ],
        ),
        Container(
          margin: lang == 'en'
          ? EdgeInsets.only(left: 10,)
          : EdgeInsets.only(right: 20,),
          child: Row(
            children: [
               Container(
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      listtype = 'grid';
                      lisselect = !lisselect;
                      isButtonPressed = !isButtonPressed;
                      //listIconColor = Colors.grey;
                      listImg = AppImages.listing;
                    });
                  },
                  child: Image.asset(AppImages.gridOf,height: 25,width:30,color:  listtype=='list' ? Colors.grey:listtype=='grid'?AppColors.appBarBackGroundColor :AppColors.appBarBackGroundColor),
                ),
              ),
            
              SizedBox(width: 5,),
              Container(
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      listtype = 'list';
                      lisselect = !lisselect;
                      isButtonPressed = !isButtonPressed;
                      //listIconColor = Colors.grey;
                      listImg = AppImages.listing;
                    });
                  },
                  child: Image.asset(listImg,height: 25,width:30,color: listtype=='grid' ?Colors.grey: listtype=='list' ?AppColors.appBarBackGroundColor :Colors.grey,),
                ),
              ),
              SizedBox(height: 10,width: 15)
            ],
          ),
        
        )
      ],
    );
  }

  idSended() {
    var createFilterjson = {
      'type': filteredIDCate,
      'status': statusFiltered == 'New' ? 1 : 0,
    };
    offerFilterCont.offerFilter(createFilterjson);
  }

  var filteredIDCate;
  filteringCategory() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return SafeArea(
                child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: Container(
                      margin: lang == 'en'
                      ? EdgeInsets.only(top: 10, left: 20, right: 20)
                      : EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 8, left: 8)
                                  : EdgeInsets.only(top: 8, right: 8),
                                  child: Text("filter".tr,
                                    style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                                ),
                                Container(
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 8, left: 8)
                                  : EdgeInsets.only(top: 8, right: 8),
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    )
                                  )
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Container(
                            margin: lang == 'en'
                            ? EdgeInsets.only(top: 6, left: 8)
                            : EdgeInsets.only(top: 6, right: 8),
                            child: Text("category".tr,
                              style: TextStyle(fontSize: 15, color: Colors.grey)
                            )
                          ),
                          GetBuilder<OfferCategoryController>(
                            init: OfferCategoryController(),
                            builder: (data) {
                              return data.allOffersResp != null && data.allOffersResp['data'] !=null
                              ? Container(
                                height: Get.height * 0.035,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.allOffersResp['data'].length,
                                  itemBuilder:(BuildContext ctxt, int index) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: Get.height * 0.035,
                                          margin: lang == 'en'
                                          ? EdgeInsets.only(left: 8.0)
                                          : EdgeInsets.only(right: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                bottomSheetCategory = index;
                                                filteredIDCate = data.allOffersResp['data'][index]['id'];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                  BorderRadius.all(
                                                    Radius.circular(5)
                                                  ),
                                                  border: Border.all(
                                                    color: AppColors.appBarBackGroundColor,
                                                  ),
                                                  color: bottomSheetCategory == index
                                                  ? AppColors
                                                      .appCategSeleGroundColor
                                                  : Colors.white,
                                                ),
                                                padding: EdgeInsets.only(left:6.0,right: 6),
                                                child: data.allOffersResp['data'] !=null
                                                ? Text( data.allOffersResp['data'][index]['category_name']['en'],
                                                  style: TextStyle(
                                                    color: bottomSheetCategory == index
                                                    ? AppColors
                                                        .appBarBackGroundColor
                                                    : AppColors.appBarBackGroundColor,
                                                    fontSize:12,
                                                    fontWeight:FontWeight.w400,
                                                    fontStyle:FontStyle.normal,
                                                  ),
                                                )
                                                : Container()
                                              ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                )
                              : Container();
                            },
                          ),
                          Container(
                            margin: lang == 'en'
                            ? EdgeInsets.only(top: 8, left: 8)
                            : EdgeInsets.only(top: 8, right: 8),
                            child: Text("condition".tr,
                            style: TextStyle(
                              fontSize: 15, color: Colors.grey)
                            )
                          ),
                         // SizedBox(height: 10),
                          Container(
                            height: Get.height * 0.035,
                            child: new ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: itemsList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      onSelected(index);
                                      statusFiltered = itemsList[index];
                                      // ignore: unnecessary_statements
                                    });
                                  },
                                  child: Container(
                                    //height: Get.height / 10,
                                    margin: lang == 'en'
                                    ? EdgeInsets.only(left: 8)
                                    : EdgeInsets.only(right: 8),
                                    width: Get.width / 5,
                                    height: Get.height / 3,
                                    decoration: BoxDecoration(
                                      // ignore: unnecessary_null_comparison
                                      color: slctedInd != null &&
                                      slctedInd == index
                                      ? AppColors.appCategSeleGroundColor
                                      : Colors .white, //Colors.blue[100],
                                      border: Border.all(
                                        color: AppColors.appBarBackGroundColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                      )
                                    ),
                                    child: Center(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(itemsList[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: slctedInd == index
                                            ? AppColors.appBarBackGroundColor
                                            : AppColors.appBarBackGroundColor,
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: Get.height * 0.05,
                                margin: lang == 'en'
                                ? EdgeInsets.only(top: 8, left: 8)
                                : EdgeInsets.only(top: 8, right: 8),
                                width: Get.width / 3,
                                //height: Get.height / 18,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:BorderRadius.all(
                                    Radius.circular(5)
                                  )
                                ),
                                // ignore: deprecated_member_use
                                child: GestureDetector(
                                  child: Center(
                                    child: Text('reset'.tr,
                                      style: TextStyle(
                                        color: AppColors.inputTextColor
                                      )
                                    )
                                  ),
                                  onTap: () {
                                    Get.back();
                                  }
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: Get.height * 0.05,
                                margin: lang == 'en'
                                ? EdgeInsets.only(top: 8, left: 8)
                                : EdgeInsets.only(top: 8, right: 8),
                                width: Get.width / 3,
                                //height: Get.height / 18,
                                decoration: BoxDecoration(
                                  color: AppColors.appBarBackGroundColor,
                                  borderRadius:BorderRadius.all(Radius.circular(5))),
                                child: GestureDetector(
                                  child: Center(
                                    child: Text("apply".tr,
                                      style: TextStyle(
                                        color: Colors.white
                                      )
                                    )
                                  ),
                                  onTap: filteredIDCate == null &&statusFiltered == null
                                  ? null
                                  : () {
                                     idSended();
                                    listtype != 'grid'
                                    ? Get.off(
                                        FilteredCategoryResult())
                                    : Get.off(FilteredCategory());
                                  }
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              );
            }),
          );
        });
  }

  Widget listUsers(listFavou) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 15),
      child: Container(
        height: Get.height/1.68,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
            itemCount: listFavou.length,
            itemBuilder: (BuildContext context, int c) {
              return GestureDetector(
                onTap: () {
                  Get.to(HomeAllOfferDEtailPage(), arguments: listFavou[c]);
                },
                child: Container(
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Center(
                              child: Container(
                                height: Get.height / 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  //padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      //Get.to(MyOfferDetailMain(), arguments:listFavou[c]);
                                    },
                                    child: listFavou[c]['image'] != null && listFavou[c]['image']['url'] != null
                                    ? Image.network(
                                      listFavou[c]['image']['url'],
                                      width: Get.width / 4,
                                      fit: BoxFit.fill,
                                    )
                                    : Container(
                                      width: Get.width / 4,
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: listFavou[c]['text_ads']['en'] !=null
                                        ? Text(
                                          listFavou[c]['text_ads']['en'].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        : Container(),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width / 2.5,
                                    child: ReadMoreText(
                                      listFavou[c]['description'] != null
                                      ? listFavou[c]['description']['en']
                                      : "",
                                      style: TextStyle(
                                        color: AppColors.inputTextColor,
                                        fontSize: 13
                                      ),
                                      trimLines: 2,
                                      colorClickableText: AppColors.appBarBackGroundColor,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                     width: Get.width/3,
                                      margin: EdgeInsets.only(top:5),
                                      child: listFavou[c]['description']!=null  ?
                                      Text(
                                        listFavou[c]['description']['en'], style:TextStyle(color:Colors.black)
                                      ):Container()
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: listFavou[c]['url'] != null
                                    ? Text(listFavou[c]['url'],
                                      style: TextStyle(
                                        color: Colors.blue
                                      )
                                    )
                                    : Container()
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                listFavou[c]['status'] == 1
                                  ? "NEW"
                                  : listFavou[c]['status'] == 0
                                    ? "OLD"
                                    : listFavou[c]['status'] == null
                                    ? ''
                                    : '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: listFavou[c]['status'] == 1
                                  ? AppColors.snackBarColor
                                  : AppColors.appBarBackGroundColor,
                                )
                              )
                            ),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
                
              );
            }),
      ),
    );
  }

  Widget allUsers(listFavou) {   
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20,bottom: 20),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: Get.height/1.67,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: Get.width /(Get.height >= 800
            ? Get.height / 1.60
            : Get.height <= 800
            ? Get.height / 1.60: 0)
          ),
          itemCount: listFavou.length,
          itemBuilder: (BuildContext context, int c) {
            return GestureDetector(
              onTap: () {
                Get.to(HomeAllOfferDEtailPage(), arguments: listFavou[c]);
              },
                child: Column(
                  children: [
                    Container(
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                              ),
                              child: Container(
                                height: Get.height * 0.23,
                                width: Get.height * 0.23,
                                child: listFavou[c]['image'] != null &&
                                    listFavou[c]['image']['url'] != null
                                ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(
                                    listFavou[c]['image']['url'],
                                  ),
                                )
                                : FittedBox(
                                  fit: BoxFit.cover,
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                    Container(
                      child: Text(
                        listFavou[c]['text_ads']['en'] != null
                        ? listFavou[c]['text_ads']['en'].toString()
                        : '',
                        style:TextStyle(
                          fontSize: 16, color: Colors.black
                        )
                      )
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
 
  bool selectAllOffer = false;
  var offerBYID;
  var ind1 = 0;
  var allCheck = false;
 Color allColor = AppColors.appBarBackGroundColor;
 bool textAllcheck = false;

  Widget subOffers(dataListedCateOffer) {
    print("..xsa.xsax.sa.s.s.a..${dataListedCateOffer.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:  45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, index) {
              ++ind1;
              if(index != 0 ) {
                allCheck = true;
              }else {
                allCheck = false;
              }
              return Row(
                children: [
                  allCheck == false ? 
                  Container(
                    width: 70,
                    margin: lang == 'en'
                    ? EdgeInsets.only(left: 12.0)
                    : EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // selectAllOffer = true;
                          textAllcheck = false;
                          allOffer = false;
                          selectedIndex = index;
                          allColor = AppColors.appBarBackGroundColor;
                          coCatOffer.offerList();
                          
                        });
                      },
                      child: Container(
                        margin:EdgeInsets.only(left:12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: AppColors.appBarBackGroundColor),
                          color: allColor
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "all".tr,
                            style: TextStyle(
                              color: textAllcheck == false ?  Colors.white  : AppColors.appBarBackGroundColor,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ): Container(),
                  Container(
                    margin: lang == 'en'
                    ? EdgeInsets.only(left: 12.0)
                    : EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          allOffer = true;
                          selectedIndex = index;
                          allColor = Colors.white;
                          textAllcheck = true;
                          offerBYID = dataListedCateOffer[index]['id'];
                          contByCatOffer.categorrOfferByID(dataListedCateOffer[index]['id']);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index&& textAllcheck == true 
                          ? AppColors.appBarBackGroundColor
                          : Colors.white,
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          dataListedCateOffer[index]['category_name'][lang] !=null ? 
                             dataListedCateOffer[index]['category_name'][lang]:
                             dataListedCateOffer[index]['category_name'][lang] ==null ? 
                              dataListedCateOffer[index]['category_name']['en']:''
                             ,
                          style: TextStyle(
                            color: selectedIndex == index && textAllcheck == true ? Colors.white  : AppColors.appBarBackGroundColor,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ); 
            },
          ),
        )
      ],
    );
  }
}
