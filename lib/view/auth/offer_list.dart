import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';

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
  var selectedIndexListing = 0;
  var status;
  var category;
  var start;
  var end;
  var filterID;
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
        body: Column(children: [
      topWidget(),

      GetBuilder<OfferCategoryController>(
        init: OfferCategoryController(),
        builder: (val) {
          return headingUpsell(val.offeredList);
        },
      ),
      //headingUpsell(),
      GetBuilder<OffersFilteringController>(
          init: OffersFilteringController(),
          builder: (val) {
            print("....fff....${val.offerFilterCreate['data']}......");
            return Expanded(
              child: val.offerFilterCreate['data'] != null
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      children: myAddGridView(val.offerFilterCreate['data']),
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          "No Offers Yet",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            );
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
                _adsfiltringheet();
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
              child: Container(
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
    print(".....output of offer id ...$json");
    offerFilterCont.offerFilter(json);

    //offerFilterControlller.offerFilter(json);
  }

  void _adsfiltringheet() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
        ),
        builder: (context) {
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.75,
          // )
          return Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: StatefulBuilder(builder:
                (BuildContext context, void Function(void Function()) setState) {
              return SafeArea(
                child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: Container(
                      //  height:Get.height/1,
                      child: Container(
                        margin: EdgeInsets.only(top: 0, left: 40, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppString.filters,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                Container(
                                    // margin:EdgeInsets.only(right:30),
                                    child: InkWell(
                                        onTap: () => Get.back(),
                                        child: Icon(Icons.close)))
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("Type", style: TextStyle(fontSize: 15)),
                            SizedBox(height: 10),
                            GetBuilder<OfferCategoryController>(
                              init: OfferCategoryController(),
                              builder: (val) {
                                return headingofTypes(val.offeredList);
                                //dataListedCateOffer[val]['type']['en'],
                              },
                            ),
                            //                  GetBuilder<CategoryController>(
                            //   init: CategoryController(),
                            //   builder: (data) {
                            //     return data.isLoading == true
                            //         ? CircularProgressIndicator()
                            //         : data.subCatt != null
                            //             ? addsCategoryWidget2(data.subCatt['data'])
                            //             : Container();
                            //   },
                            // ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Condition", style: TextStyle(fontSize: 15)),
                            // SizedBox(height: 10),
                            Container(
                              height: Get.height/6,
                              child: new ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: litems.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _onSelected(index);
                                          status = litems[index];
                                          print(
                                              "....!!!!>...!!!!!...????///////.......$status");
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        //color: Colors.red,
                                         height: Get.height/4,
                                        // width: Get.width / 2,
                                        decoration: BoxDecoration(
                                            color: _selectedIndex != null &&
                                                    _selectedIndex == index
                                                ? Colors.blue
                                                : Colors
                                                    .white, //Colors.blue[100],
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(litems[index],
                                                //softWrap: true,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: _selectedIndex == index
                                                        ? Colors.white
                                                        : Colors.blue)),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Text("Price ",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("SAR 0 - SAR 1000 ",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                            RangeSlider(
                              values: _currentRangeValues,
                              min: 1,
                              max: 1000,
                              // divisions: 5,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (values) {
                                setState(() {
                                  // print(
                                  //     "start : ${values.start}, end: ${values.end}");
                                  _currentRangeValues = values;
                                  start = _currentRangeValues.start
                                      .round()
                                      .toString();
                                  end = _currentRangeValues.end.round().toString();
                                  print(".....!!!!!!!...!!!!!....$start");
                                  print(".....!!!!!!!...!!!!!....$end");
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 20),
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                      color: Colors.grey[100],
                                      child: Container(
                                          width: Get.width / 4,
                                          child: Center(
                                              child: Text(AppString.resetButton,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .inputTextColor)))),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                        // Get.to(SignIn());
                                      }),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(top: 20),
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                      color: Colors.blue,
                                      child: Container(
                                          width: Get.width / 4,
                                          child: Center(
                                              child: Text("Apply",
                                                  style: TextStyle(
                                                      color: Colors.white)))),
                                      onPressed:
                                          filterID == null && status == null
                                              ? null
                                              : () {
                                                  applyFiltering();
                                                  print(
                                                      ".....category.......!!!!...!!!>....!!!>..$category");
                                                  print(
                                                      ".....status.......!!!!...!!!>....!!!>..$status");
                                                  print(
                                                      ".....start.......!!!!...!!!>....!!!>..$start");
                                                  print(
                                                      ".....end.......!!!!...!!!>....!!!>..$end");
                                                  // Navigator.pushNamed(context, '/login');
                                                  // Get.to(SignIn());
                                                }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
          );
        });
  }

  applyFiltering() {
    var json = {
      //'rangeValue': _currentRangeValues,
      'type': filterID,
      'condition': status,
      'start': start,
      'end': end,
    };
    print(".....output>..$json");
    // filterControlller.createFilterAds(json);
  }

  var ind1 = 0;
  Widget headingofTypes(dataListedCateOffer) {
    // print(
    //     "my adds Page.......................,,,,,,,...-------------------$dataListedCateOffer");
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
                          category =
                              dataListedCateOffer[val]['category_name']['en'];
                          print(
                              "....!!!1!!!!.category.!!!!!......!!!!1.....!!!!!...$category");
                          //controller.addedByIdAddes(listingCategoriesData[index]['id']);
                          // filterControlller
                          //     .createFilterAds(dataListedCateOffer[val]['id']);
                          print(
                              "....!!!...!!!!....!!!!!...111.....${dataListedCateOffer[val]['id']}");
                          filterID = dataListedCateOffer[val]['id'];
                          //createFilterAds
                          //AdsFilteringController
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.blue),
                            color: selectedIndexListing == val
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
                          child: dataListedCateOffer != null
                              ? Text(
                                  dataListedCateOffer[val]['category_name']
                                      ['en'],
                                  style: TextStyle(
                                    color: selectedIndexListing == val
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )
                              : Container()),
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
    // print(".........listFavou.......!!!!!......!!!!.......${listFavou['data']['en']}");
    List<Widget> favrties = [];
    if (listFavou != null || listFavou.length != null) {
      for (int c = 0; c < listFavou.length; c++) {
        // print("!!!!1...helllloo.!!!!>.....!!!>.......${listFavou['data']['text_ads']['en']}");
        favrties.add(Container(
          width: Get.width / 1.10,
          height: Get.height / 0.3,
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(listFavou.length, (c) {
                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(15),
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
                                  height: Get.height * 0.18,
                                  width: Get.height * 0.18,
                                  child: listFavou[c]['image_ads'] != null &&
                                          listFavou[c]['image_ads']['url'] !=
                                              null
                                      ? FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.network(
                                            listFavou[c]['image_ads']['url'],
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
                                TextStyle(fontSize: 13, color: Colors.black)))
                  ],
                );
              })),
        ));
      }
    }
    return favrties;
  }

  Widget headingUpsell(List dataListedCateOffer) {
    print("....!!!!...qqq..qqq...qqq.....$dataListedCateOffer");
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
                          print(selectedIndex);
                          id = dataListedCateOffer[index]['id'];
                          print("....<><><><><>.......$id");
                          print("the category hited...");
                        });
                        applyofferFiltering();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue),
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
                                : Colors.blue,
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
