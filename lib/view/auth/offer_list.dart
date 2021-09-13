import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
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
  final banner = Get.put(BannerController());
  var json;
  int slctedInd = 0;
  onSelected(int index) {
    setState(() => slctedInd = index);
  }

  var lang;
  var listtype = 'grid';
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
    offerid = Get.arguments;
    lang = box.read('lang_code');
    print("///////here /a//// $lang");
    usertype = box.read('user_type');
  }
  // void dispose() {
  //   offerFilterCont.offerFilter(json);
  //   //banner.bannerController();
  //   super.dispose();

  // }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    cardwidth = MediaQuery.of(context).size.width / 3.3;
    cardHeight = MediaQuery.of(context).size.height / 3.6;
    return Scaffold(
        key: _scaffoldKey,
        appBar: offerid != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: appbar(
                    _scaffoldKey, context, AppImages.appBarLogo, " ", ''))
            : null,
        // drawer: AppDrawer(),
        drawer: Theme(
          data: Theme.of(context).copyWith(
              // canvasColor: AppColors.botomTiles
              ),
          child: AppDrawer(),
        ),
        body: ListView(children: [
          SizedBox(
            height: 10,
          ),
          topWidget(),
          SizedBox(
            height: 10,
          ),
          GetBuilder<OfferCategoryController>(
            init: OfferCategoryController(),
            builder: (val) {
              return val.offerDattaTypeCategory != null &&
                      val.offerDattaTypeCategory['data'] != null
                  ? subOffers(val.offerDattaTypeCategory['data'])
                  : Container();
            },
          ),
          GetBuilder<OfferCategoryController>(
              init: OfferCategoryController(),
              builder: (val) {
                return val.iDBasedOffers != null &&
                        val.iDBasedOffers['data'] != null &&
                        val.iDBasedOffers['success'] == true
                    ? listtype == 'grid'
                        ? allUsers(val.iDBasedOffers['data'])
                        : listUsers(val.iDBasedOffers['data'])
                    : contByCatOffer.resultInvalid.isTrue &&
                            val.iDBasedOffers['success'] == false
                        ? Container(
                            margin: EdgeInsets.only(top: Get.height / 3),
                            child: Center(
                              child: Text(
                                contByCatOffer.iDBasedOffers['errors'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container();
                // );
              }),
        ]));
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

                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                      child: Image.asset(AppImages.plusImage, height: 24)),
            )
          ],
        ),
        Container(
          margin: lang == 'en'
              ? EdgeInsets.only(
                  left: 10,
                )
              : EdgeInsets.only(
                  right: 20,
                ),
                child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    listtype = 'grid';
                    box.write("type", listtype);
                    print(".....<><><><><><>///<><><....$listtype");
                    isButtonPressed = !isButtonPressed;
                    //listIconColor = AppColors.appBarBackGroundColor;
                    grid = AppImages.grid;
                  });
                },
                icon: Image.asset(grid,height: 50,color:  listtype=='list' ? Colors.grey:listtype=='grid'?AppColors.appBarBackGroundColor :AppColors.appBarBackGroundColor)
              ),
              Container(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      listtype = 'list';
                      print(".....<><><><><><>///<><><....$listtype");
                      lisselect = !lisselect;
                      isButtonPressed = !isButtonPressed;
                      //listIconColor = Colors.grey;
                      listImg = AppImages.listing;
                    });
                  },
                  icon: Image.asset(listImg,height: 50,color: listtype=='grid' ?Colors.grey: listtype=='list' ?AppColors.appBarBackGroundColor :Colors.grey,),
                ),
              ),
              SizedBox(height: 30,width: 15)
            ],
          ),
        
          // child: Row(
          //   children: [
          //     IconButton(
          //         //color: isButtonPressed ? Colors.grey : Colors.blue,
          //         onPressed: () {
          //           setState(() {
          //             listtype = 'grid';
          //             box.write("type", listtype);
          //             print(".....<><><><><><>///<><><....$listtype");
          //             isButtonPressed = !isButtonPressed;
          //             listIconColor = AppColors.appBarBackGroundColor;
          //             grid = AppImages.grid;
          //           });
          //         },
          //         icon: Image.asset(
          //           grid,
          //           height: 40,
          //           color: listIconColor,
          //         )),
          //     //SizedBox(width: 8,),
          //     Container(
          //       //margin: EdgeInsets.only(bottom: 20),
          //       child: IconButton(
          //           onPressed: () {
          //             setState(() {
          //               listtype = 'list';
          //               print(".....<><><><><><>///<><><....$listtype");
          //               lisselect = !lisselect;
          //               isButtonPressed = !isButtonPressed;
          //               listIconColor = Colors.grey;
          //               listImg = AppImages.listing;
          //             });
          //           },
          //           icon: Image.asset(listImg,height: 50,
          //           color: isButtonPressed?AppColors.appBarBackGroundColor:Colors.grey,),
          //           ),
          //     ),
          //     SizedBox(
          //       height: 30,
          //       width: 15,
          //     )
          //   ],
          // ),
        
        )
      ],
    );
  }

  idSended() {
    var createFilterjson = {
      'type': filteredIDCate,
      'status': statusFiltered == 'New' ? 1 : 0,
    };
    print(
        "Sended Data.......!!!!!!!!!CREATEDFILTEREDJSON................$createFilterjson");
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
            heightFactor: 1.0,
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
                        //crossAxisAlignment: CrossAxisAlignment.start,
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
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.04),
                          Container(
                              margin: lang == 'en'
                                  ? EdgeInsets.only(top: 8, left: 8)
                                  : EdgeInsets.only(top: 8, right: 8),
                              child: Text("category".tr,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey))),
                          GetBuilder<OfferCategoryController>(
                            init: OfferCategoryController(),
                            builder: (data) {
                              return data.offerDattaTypeCategory != null &&
                                      data.offerDattaTypeCategory['data'] !=
                                          null
                                  ? Container(
                                      height: Get.height / 10,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data
                                              .offerDattaTypeCategory['data']
                                              .length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return Row(
                                              children: [
                                                Container(
                                                  margin: lang == 'en'
                                                      ? EdgeInsets.only(
                                                          left: 8.0)
                                                      : EdgeInsets.only(
                                                          right: 8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        bottomSheetCategory =
                                                            index;
                                                        filteredIDCate =
                                                            data.offerDattaTypeCategory[
                                                                    'data']
                                                                [index]['id'];
                                                      });
                                                    },
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .appBarBackGroundColor,
                                                          ),
                                                          color: bottomSheetCategory ==
                                                                  index
                                                              ? AppColors
                                                                  .appBarBackGroundColor
                                                              : Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.0, 1.0),
                                                              blurRadius: 6.0,
                                                            ),
                                                          ],
                                                        ),
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            data.offerDattaTypeCategory[
                                                                        'data'] !=
                                                                    null
                                                                ? Text(
                                                                    data.offerDattaTypeCategory['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'category_name']['en'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: bottomSheetCategory ==
                                                                              index
                                                                          ? Colors
                                                                              .white
                                                                          : AppColors
                                                                              .appBarBackGroundColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                    ),
                                                                  )
                                                                : Container()),
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
                                      fontSize: 15, color: Colors.grey))),
                          SizedBox(height: 10),
                          Container(
                            height: Get.height * 0.05,
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
                                      height: Get.height / 2,
                                      decoration: BoxDecoration(
                                          // ignore: unnecessary_null_comparison
                                          color: slctedInd != null &&
                                                  slctedInd == index
                                              ? AppColors.appBarBackGroundColor
                                              : Colors
                                                  .white, //Colors.blue[100],
                                          border: Border.all(
                                            color:
                                                AppColors.appBarBackGroundColor,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(itemsList[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: slctedInd == index
                                                    ? Colors.white
                                                    : AppColors
                                                        .appBarBackGroundColor,
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 20),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: lang == 'en'
                                    ? EdgeInsets.only(top: 8, left: 8)
                                    : EdgeInsets.only(top: 8, right: 8),
                                width: Get.width / 3,
                                height: Get.height / 18,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                // ignore: deprecated_member_use
                                child: GestureDetector(
                                    child: Center(
                                        child: Text('reset'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.inputTextColor))),
                                    onTap: () {
                                      Get.back();
                                    }),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                margin: lang == 'en'
                                    ? EdgeInsets.only(top: 8, left: 8)
                                    : EdgeInsets.only(top: 8, right: 8),
                                width: Get.width / 3,
                                height: Get.height / 18,
                                decoration: BoxDecoration(
                                    color: AppColors.appBarBackGroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                // ignore: deprecated_member_use
                                child: GestureDetector(
                                    // color: Colors.transparent,
                                    // elevation: 0,
                                    child: Center(
                                        child: Text("apply".tr,
                                            style: TextStyle(
                                                color: Colors.white))),
                                    onTap: filteredIDCate == null &&
                                            statusFiltered == null
                                        ? null
                                        : () {
                                            idSended();
                                            listtype != 'grid'
                                            // print(
                                            //     "hellll....helllll.....helll.....$listtype");
                                            // Get.to(FilteredCategory(),
                                            //     arguments: listtype);
                                            ? Get.off(
                                                FilteredCategoryResult())
                                            : Get.off(FilteredCategory());
                                          }),
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
        height: Get.height,
        child: ListView.builder(
            // padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
            primary: false,
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   childAspectRatio:Get.width /
            //   (Get.height >= 800
            //       ? Get.height / 1.65
            //       : Get.height <= 800
            //           ? Get.height / 1.60
            //           : 0),
            // ),
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
                          // crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: listFavou[c]['image'] != null &&
                                              listFavou[c]['image']['url'] !=
                                                  null
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
                                            )),
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
                                          child: listFavou[c]['text_ads']
                                                      ['en'] !=
                                                  null
                                              ? Text(
                                                  listFavou[c]['text_ads']['en']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                            fontSize: 13),
                                        trimLines: 2,
                                        colorClickableText:
                                            AppColors.appBarBackGroundColor,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: 'Show less',
                                      ),
                                    ),
                                    // Center(
                                    //   child: Container(
                                    //    width: Get.width/3,
                                    //     margin: EdgeInsets.only(top:5),
                                    //     child: listFavou[c]['description']!=null  ?
                                    //     Text(
                                    //       listFavou[c]['description']['en'], style:TextStyle(color:Colors.black)
                                    //     ):Container()
                                    //   ),
                                    // ),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: listFavou[c]['url'] != null
                                            ? Text(listFavou[c]['url'],
                                                style: TextStyle(
                                                    color: Colors.blue))
                                            : Container())
                                  ]),
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
                                    ))),
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       GestureDetector(
                            //         onTap: (){
                            //           Get.to(AddOffersPage(), arguments: listFavou[c]);

                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.only(right: 10),
                            //           child:  Image.asset(AppImages.edit, height: 30)
                            //         ),
                            //       ),
                            //       Container(
                            //         margin: EdgeInsets.only(right: 10),
                            //         child: GestureDetector(
                            //           onTap: (){
                            //             print(listFavou[c]['id']);
                            //             //delete.deleteOfferController( listFavou[c]['id']);
                            //           },
                            //           child: Image.asset(AppImages.delete, height: 30))
                            //       ),
                            //     ],
                            //   )
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
                // Container(
                //   child: Text(
                //     listFavou[c]['text_ads']['en'] != null? listFavou[c]['text_ads']['en'].toString(): '',
                //     style:TextStyle(fontSize: 16, color: Colors.black)
                //   )
                // )
                //   ],
                // ),
              );
            }),
      ),
    );
  }

  Widget allUsers(listFavou) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: Get.height,
        child: GridView.builder(
            // padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: Get.width /
                  (Get.height >= 800
                      ? Get.height / 1.65
                      : Get.height <= 800
                          ? Get.height / 1.60
                          : 0),
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
                        // margin: EdgeInsets.all(10),
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
                                bottomRight: Radius.circular(10)),
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
                    )),
                    Container(
                        child: Text(
                            listFavou[c]['text_ads']['en'] != null
                                ? listFavou[c]['text_ads']['en'].toString()
                                : '',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)))
                  ],
                ),
              );
            }),
      ),
    );
  }

  //  myAddGridView(listFavou) {
  //   // List<Widget> favrties = [];
  //   // if (listFavou != null || listFavou.length != null) {
  //   //   for (int c = 0; c < listFavou.length; c++) {
  //       // favrties.add(
  //         // SingleChildScrollView(
  //           Container(
  //             // width: Get.width / 1.10,
  //             height: Get.height / 3.3,
  //             child: GridView.builder(
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisSpacing: 10,
  //                 mainAxisSpacing: 20,
  //                 crossAxisCount: 2,
  //                 childAspectRatio: 1.0
  //                 ),
  //               // crossAxisCount: 2,
  //                itemCount: listFavou.length,
  //               itemBuilder: (BuildContext context, int c) {
  //                 return Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.all(10),
  //                       child: Card(
  //                         elevation: 1,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(15.0),
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.only(
  //                                 topLeft: Radius.circular(10),
  //                                 topRight: Radius.circular(10),
  //                                 bottomLeft: Radius.circular(10),
  //                                 bottomRight: Radius.circular(10)
  //                               ),
  //                               child: Container(
  //                                 height: Get.height * 0.18,
  //                                 width: Get.height * 0.18,
  //                                 child: listFavou[c]['image_ads'] != null &&listFavou[c]['image_ads']['url'] != null
  //                                 ? FittedBox(
  //                                   fit: BoxFit.cover,
  //                                   child: Image.network(
  //                                     listFavou[c]['image_ads']['url'],
  //                                   ),
  //                                 ): FittedBox(
  //                                   fit: BoxFit.cover,
  //                                   child: Icon(
  //                                     Icons.image,
  //                                     color: Colors.grey[400],
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         listFavou[c]['text_ads']['en'] != null? listFavou[c]['text_ads']['en'].toString(): '',
  //                         style:TextStyle(fontSize: 13, color: Colors.black)
  //                       )
  //                     )
  //                   ],
  //                 );
  //               })
  //             );
  //           // ),
  //         // )
  //       // );
  //   //   }
  //   // }
  //   // return favrties;
  // }
  var offerBYID;
  var ind1 = 0;
  Widget subOffers(dataListedCateOffer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 9.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, index) {
              if (ind1 == 0) {
                offerBYID = dataListedCateOffer[index]['id'];
                print(
                    ".........!!!!!!!!!..............offer BY ID.........$offerBYID");
                contByCatOffer
                    .categorrOfferByID(dataListedCateOffer[index]['id']);
              }
              ++ind1;
              return Row(
                children: [
                  Container(
                    margin: lang == 'en'
                        ? EdgeInsets.only(left: 12.0)
                        : EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          offerBYID = dataListedCateOffer[index]['id'];
                          print(
                              ".......!!!!!!!!!!!! stState by tapping..........$offerBYID");
                          contByCatOffer.categorrOfferByID(
                              dataListedCateOffer[index]['id']);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index
                              ? selectedColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          dataListedCateOffer[index]['category_name']['en'],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : AppColors.appBarBackGroundColor,
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
