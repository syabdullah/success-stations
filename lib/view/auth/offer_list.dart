import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/view/offer_filtered.dart';

class OfferList extends StatefulWidget {
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  final banner = Get.put(BannerController());
  
 

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RangeValues _currentRangeValues = const RangeValues(1, 1000);
  var json;

  var listtype = 'list';
  final offerFilterCont = Get.put(OffersFilteringController());
  var selectedIndex = 0;
  var id;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  var bottomSheetCategory =0;
  Color  filterCategoryColor = Colors.blue;
  var selectedIndexListing = 0;
  var status;
  var category;
  var start;
  var end;
  var filterID;
  var usertype;
  GetStorage box = GetStorage ();
  List<String> litems = [
    "Reset",
    "Save",
  ];
  var cardHeight;
  var cardwidth;
  @override
   void initState() {
    // TODO: implement initState
    offerFilterCont.offerFilter(json);
    banner.bannerController();
    super.initState();
    usertype = box.read('user_type');
  }
  void dispose() {
    // TODO: implement dispose
    offerFilterCont.offerFilter(json);
    //banner.bannerController();
    super.dispose();

  }
  
  Widget build(BuildContext context) {
    cardwidth = MediaQuery.of(context).size.width / 3.3;
    cardHeight = MediaQuery.of(context).size.height / 3.6;
    return Scaffold(
      body: Column(
        children: [
        topWidget(),
        GetBuilder<OfferCategoryController>(
          init: OfferCategoryController(),
          builder: (val) {
            return val.offerDattaTypeCategory !=null && val.offerDattaTypeCategory['data'] !=null ? headingUpsell(val.offerDattaTypeCategory['data']):
            Container();
          },
        ),
        GetBuilder<OffersFilteringController>(
        init: OffersFilteringController(),
          builder: (val) {
            return Expanded(
              child: val.offerFilterCreate !=null && val.offerFilterCreate['data'] != null && val.offerFilterCreate['success'] == true 
                ? ListView(
                  scrollDirection: Axis.vertical,
                  children: myAddGridView(val.offerFilterCreate['data']),
                ): 
                offerFilterCont.resultInvalid.isTrue && val.offerFilterCreate['success'] == false ?  
                Container(
                  child: Center(
                    child: Text(
                     offerFilterCont.offerFilterCreate['errors'],
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ):Container()
              );
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
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Image.asset(AppImages.filter, height: 15),
                    SizedBox(width: 5),
                    Text(
                      "Filter",
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //Get.toNamed('/adPostingScreen');
              },
              child:  usertype == 2 ? Container() :
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset(AppImages.plusImage, height: 24)),
            )
          ],
        ),
        // Row(
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           listtype = 'grid';
        //           listIconColor = Colors.grey;
        //           grid = AppImages.grid;
        //         });
        //       },
        //       icon:
        //           // Container(
        //           // height: 100,
        //           Image.asset(grid),
        //     ),
        //     Container(
        //       margin: EdgeInsets.only(bottom: 15),
        //       child: IconButton(
        //           onPressed: () {
        //             setState(() {
        //               listtype = 'list';
        //               listIconColor = AppColors.appBarBackGroundColor;
        //               grid = AppImages.gridOf;
        //             });
        //           },
        //           icon: Container(
        //               padding: EdgeInsets.only(top: 10),
        //               child: Image.asset(AppImages.listing,
        //                   color: listIconColor, height: 20))),
        //     ),
        //     SizedBox(
        //       height: 30,
        //       width: 15,
        //     )
        //   ],
        // )
      ],
    );
  }

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  applyofferFiltering() {
    json = {
      'type': id,
    };
    offerFilterCont.offerFilter(json);
  }

  idSended() {
    var createFilterjson = {
      'type': filteredIDCate,
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
          topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: StatefulBuilder(
            builder:(
              BuildContext context, void Function(void Function()) setState) {
                return SafeArea(
                  child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: Container(
                      margin: EdgeInsets.only(top: 10,left:20, right:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left:10),
                                  child: Text(AppString.filters,
                                    style: TextStyle(
                                      fontSize: 20, color: Colors.black
                                    )
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(right:20),
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close)
                                  )
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height*0.04),
                          Text("Category", style: TextStyle(fontSize: 15)),
                          GetBuilder<OfferCategoryController>(
                            init: OfferCategoryController(),
                            builder: (data) {
                              return  data.offerDattaTypeCategory != null  && data.offerDattaTypeCategory['data'] !=null?  
                              Container(
                                height: Get.height/10,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.offerDattaTypeCategory['data'].length,
                                  itemBuilder:(BuildContext ctxt, int index){
                                    return Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                bottomSheetCategory = index;
                                                filteredIDCate =  data.offerDattaTypeCategory['data'][index]['id'];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                border: Border.all(color: Colors.blue),
                                                color: bottomSheetCategory == index ? filterCategoryColor  : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0.0, 1.0),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                              padding: EdgeInsets.all(10.0),
                                              child: data.offerDattaTypeCategory['data'] != null
                                              ? Text( data.offerDattaTypeCategory['data'][index]['category_name']['en'],
                                                style: TextStyle(
                                                  color: bottomSheetCategory == index ? Colors.white  : Colors.blue,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ): Container()
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ): Container();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.grey[100],
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(
                                      child: Text(AppString.resetButton,
                                        style: TextStyle(
                                          color: AppColors.inputTextColor
                                        )
                                      )
                                    )
                                  ),
                                  onPressed: () {}
                                ),
                              ),
                              Container(
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(
                                      child: Text("Apply",
                                        style: TextStyle( color: Colors.white)
                                      )
                                    )
                                  ),
                                  onPressed: filteredIDCate  == null ? null  :() {
                                    idSended();
                                    Get.off(FilteredCategoryResult());
                                  }
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                );
              }
            ),
          );
        }
      );
    }
 
  applyFiltering() {
    var json = {
      //'rangeValue': _currentRangeValues,
      'type': filterID,
      'condition': status,
      'start': start,
      'end': end,
    };
    // filterControlller.createFilterAds(json);
  }

  var ind1 = 0;
  Widget headingofTypes(dataListedCateOffer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, val) {
              if (ind1 == 0) {
                // controller.addedByIdAddes(listingCategoriesData[0]['id']);
              }
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        // print(
                        //     "rrrrrrrrrrrr redixxx${dataListedCateOffer[val]['id']}");
                        setState(() {
                          // ind1 = ++ind1;
                          selectedIndexListing = val;
                          category =dataListedCateOffer[val]['category_name']['en'];
                          filterID = dataListedCateOffer[val]['id'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue),
                          color: selectedIndexListing == val ? selectedColor  : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: dataListedCateOffer != null
                        ? Text(
                          dataListedCateOffer[val]['category_name']['en'],
                          style: TextStyle(
                            color: selectedIndexListing == val? Colors.white: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        )
                        : Container()
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

  List<Widget> myAddGridView(listFavou) {
    List<Widget> favrties = [];
    if (listFavou != null || listFavou.length != null) {
      for (int c = 0; c < listFavou.length; c++) {
        favrties.add(
          Container(
            width: Get.width / 1.10,
            height: Get.height / 0.3,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(listFavou.length, (c) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
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
                                height: Get.height * 0.18,
                                width: Get.height * 0.18,
                                child: listFavou[c]['image_ads'] != null &&listFavou[c]['image_ads']['url'] != null
                                ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(
                                    listFavou[c]['image_ads']['url'],
                                  ),
                                ): FittedBox(
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
                        listFavou[c]['text_ads']['en'] != null? listFavou[c]['text_ads']['en'].toString(): '',
                        style:TextStyle(fontSize: 13, color: Colors.black)
                      )
                    )
                  ],
                );
              })
            ),
          )
        );
      }
    }
    return favrties;
  }

  Widget headingUpsell(dataListedCateOffer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          id = dataListedCateOffer[index]['id'];
                        });
                        applyofferFiltering();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue),
                          color: selectedIndex == index ? selectedColor: Colors.white,
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
                            color: selectedIndex == index? Colors.white : Colors.blue,
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

