import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/my_adds/listing_types_controller.dart';
import 'package:success_stations/controller/rating_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/auth/my_adds/filtering_adds.dart';

bool check = true;

class AllAdds extends StatefulWidget {
  _AllAddsState createState() => _AllAddsState();
}

class _AllAddsState extends State<AllAdds> {
  final ratingcont = Get.put(RatingController());
  RangeValues _currentRangeValues = const RangeValues(1, 1000);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(AddBasedController());
  final catCont = Get.put(CategoryController());
  final friCont = Get.put(FriendsController());
  final catCobtroller = Get.put(MyListingFilterController());
  final filterControlller = Get.put(AddBasedController());
  var listtype = 'grid';
  var userId;
  var myrate;
  late double valueData;
  bool _value = false;
  var selectedIndex = 0;
  var filteredIndex = 0;
  var selectedIndexListing = 0;
  bool lisselect = false;

  var bClicked = false;
  var grid = AppImages.gridOf;
  var listImg = AppImages.listing;
  Color selectedColor = Colors.blue;
  Color listIconColor = AppColors.appBarBackGroundColor;
  bool liked = false;
  Color filterSelecredColor = Colors.blue;
  var conditionSelected;
  GetStorage box = GetStorage();
  var lang;
  final banner = Get.put(BannerController());
  var v;
  var status;
  var category;
  var start;
  var end;
  var filterID;
  var data;
  var id;
  bool isButtonPressed = false;
  List<String> litems = [
    "old".tr,
    "New".tr,
  ];

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    if (data != null) {
      controller.addedByIdAddes(data[1], null);
      id = data[1];
    }
    check = true;
    banner.bannerController();
    controller.addedAllAds();
    catCont.getCategoryTypes();
    catCobtroller.listingTypes();
    lang = box.read('lang_code');
    print("<><><><><.....<><><><>.....$lang");
    userId = box.read('user_id');
    v = '';
  }

  int _selectedIndex = 1;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: data != null
      ? PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: stringAppbar(
          '', Icons.arrow_back_ios_new_sharp,
          'All ads', AppImages.appBarSearch
        )
      )
      : null,
      body: Column(
        children: [
          SizedBox(height: 6),
          topWidget(),
          SizedBox(height: 6),
          GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (data) {
              return data.isLoading == true
              ? CircularProgressIndicator()
              : data.subCatt != null
                ? addsCategoryWidget(data.subCatt['data'])
                : Container();
            },
          ),
          Expanded(
            child: GetBuilder<AddBasedController>(
              init: AddBasedController(),
              builder: (val) {
                return val.isLoading == true || val.cData == null
                ? Container()
                : val.cData['data'] == null
                  ? Container()
                  : listtype != 'grid'
                  ? myAddsList(val.cData['data'])
                  : myAddGridView(
                    val.cData['data']
                  );
              },
            )
          )
        ],
      ),
    );
  }

  Widget topWidget() {
    var list;
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
                margin: lang == 'en'
                ? const EdgeInsets.only(left: 15, top: 8)
                : const EdgeInsets.only(right: 15, top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                Get.toNamed('/adPostingScreen');
              },
              child: Container(
                margin: lang == 'en'
                ? EdgeInsets.only(left: 10, top: 10)
                : EdgeInsets.only(right: 10, top: 10),
                child: Image.asset(AppImages.plusImage,height: 24)
              ),
            )
          ],
        ),
        Container(
          margin: lang == 'en'
          ? EdgeInsets.only(left: 10)
          : EdgeInsets.only(right: 20),
          child: Row(
            children: [
               Container(
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      listtype = 'grid';
                      print(".....<><><><><><>///<><><....$listtype");
                      lisselect = !lisselect;
                      isButtonPressed = !isButtonPressed;
                      //listIconColor = Colors.grey;
                      listImg = AppImages.listing;
                    });
                  },
                  child: Image.asset(AppImages.gridOf,height: 25,width:30,color:  listtype=='list' ? Colors.grey:listtype=='grid'?AppColors.appBarBackGroundColor :AppColors.appBarBackGroundColor),
                ),
              ),
              
              // CupertinoButton(
              //   minSize: double.minPositive,
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     setState(() {
              //       listtype = 'grid';
              //       box.write("type", listtype);
              //       print(".....<><><><><><>///<><><....$listtype");
              //       isButtonPressed = !isButtonPressed;
              //       //listIconColor = AppColors.appBarBackGroundColor;
              //       grid = AppImages.grid;
              //     });
              //   },
              //   child: Image.asset(grid,height: 35,width:30,color:  listtype=='list' ? Colors.grey:listtype=='grid'?AppColors.appBarBackGroundColor :AppColors.appBarBackGroundColor)
              // ),
            
              SizedBox(width: 5,),
              Container(
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
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

  var catFilteredID;
  _adsfiltringheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: StatefulBuilder(
            builder: (
              BuildContext context,void Function(void Function()) setState) {
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
                          // crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontSize: 20, color: Colors.black
                                      )
                                    ),
                                  ),
                                  Container(
                                    margin: lang == 'en'
                                    ? EdgeInsets.only(top: 8, left: 8)
                                    : EdgeInsets.only(top: 8, right: 8),
                                    child: InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(Icons.close,
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
                              ? EdgeInsets.only(top: 8, left: 8)
                              : EdgeInsets.only(top: 8, right: 8),
                              child: Text("category".tr,
                                style: TextStyle(
                                  fontSize: 15, color: Colors.grey
                                )
                              )
                            ),
                            GetBuilder<CategoryController>(
                              init: CategoryController(),
                              builder: (data) {
                                return data.isLoading == true
                                ? Container(
                                  height: Get.height / 10,
                                )
                                : data.subCatt != null && data.subCatt['data'] != null
                                  ? Container(
                                    height: Get.height * 0.035,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.subCatt['data'].length,
                                      itemBuilder: (
                                        BuildContext ctxt,int index) {
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
                                                    filteredIndex = index;
                                                    catFilteredID = data.subCatt['data'][index]['id'];
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: AppColors.appBarBackGroundColor),
                                                    color: filteredIndex == index
                                                    ? AppColors.appCategSeleGroundColor
                                                    : Colors.white,
                                                  ),
                                                  padding: EdgeInsets.only(left:6.0,right: 6),
                                                  child: data.subCatt['data'] !=null
                                                  ? Text(data.subCatt['data'][index]['category']['en'],
                                                    style: TextStyle(
                                                      color: filteredIndex == index
                                                      ? AppColors.appBarBackGroundColor
                                                      : AppColors.appBarBackGroundColor,
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
                                      }
                                    ),
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
                                  fontSize: 15, color: Colors.grey
                                )
                              )
                            ),
                            //SizedBox(height: 10),
                            Container(
                              height: Get.height * 0.035,
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
                                      });
                                    },
                                    child: Container(
                                      margin: lang == 'en'
                                      ? EdgeInsets.only(left: 8)
                                      : EdgeInsets.only(right: 8),
                                      width: Get.width / 5,
                                      height: Get.height / 3,
                                      decoration: BoxDecoration(
                                        // ignore: unnecessary_null_comparison
                                        color: _selectedIndex != null &&
                                        _selectedIndex == index
                                        ? AppColors.appCategSeleGroundColor
                                        : Colors.white, border: Border.all(
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
                                          child: Text(litems[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: _selectedIndex == index
                                              ? AppColors.appBarBackGroundColor
                                              : AppColors.appBarBackGroundColor
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //height: Get.height * 0.05,
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 2, left: 8)
                                  : EdgeInsets.only(top: 2, right: 8),
                                  child: Text("price".tr,
                                    style: TextStyle(
                                      fontSize: 18, color: Colors.grey // fontWeight: FontWeight.bold,
                                    )
                                  ),
                                ),
                                Container(
                            //height: Get.height * 0.05,
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 2, left: 8)
                                  : EdgeInsets.only(top: 2, right: 8),
                                  child: Text("SAR 0 - SAR 10000 ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal
                                    )
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: lang == 'en'
                              ? EdgeInsets.only(top: 4, left: 8)
                              : EdgeInsets.only(top: 4, right: 8),
                              child: RangeSlider(
                                values: _currentRangeValues,
                                min: 1.00,
                                max: 10000.00,
                                // divisions: 5,
                                labels: RangeLabels(
                                  
                                  _currentRangeValues.start.round().toString(),
                                  _currentRangeValues.end.round().toString(),
                                ),
                                onChanged: (values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                    start = _currentRangeValues.start
                                        .round()
                                        .toString();
                                    end = _currentRangeValues.end
                                        .round()
                                        .toString();
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: Get.height * 0.05,
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
                                  : EdgeInsets.only(top: 8, bottom: 6, right: 8),
                                  width: Get.width / 3,
                                  //height: Get.height / 18,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text("reset".tr,
                                        style: TextStyle(
                                          color:AppColors.inputTextColor
                                        )
                                      )
                                    ),
                                    onTap: () {
                                      Get.back();
                                    }
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: Get.height * 0.05,
                                  margin: lang == 'en'
                                  ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
                                  : EdgeInsets.only(top: 8, bottom: 6, right: 8),
                                  width: Get.width / 3,
                                  //height: Get.height / 18,
                                  decoration: BoxDecoration(
                                    color: AppColors.appBarBackGroundColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text("apply".tr,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ),
                                    onTap: catFilteredID == null && status == null
                                    ? null
                                    : () {
                                      applyFiltering();
                                      Get.off(FilteredAdds(),
                                      arguments: listtype);
                                      // Get.off(FilteredAdds());
                                    }
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        // ),
                    )
                  ),
                );
          }),
        );
      });
}

  applyFiltering() {
    var json = {
      'type': catFilteredID,
      'condition': status == 'New' ? 1 : 0,
      'start': start,
      'end': end,
    };
    print(".....output>..$json");
    filterControlller.createFilterAds(json);
  }

  var catID;
  Widget myAddsList(allDataAdds) {
    print("........hellooooo...here I am......$allDataAdds");
    return ListView.builder(
      itemCount: allDataAdds.length,
      itemBuilder: (BuildContext context, index) {
        print("....hellloooooo.....${allDataAdds[index]['city_id']}");
        return GestureDetector(
          onTap: () {
            Get.to(AdViewScreen(), arguments: allDataAdds[index]['id']);
          },
          child: allDataAdds[index]['is_active'] == 0
        ? Container()
        : Container(
            decoration: BoxDecoration(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Container(
                              height: Get.height / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  child: allDataAdds[index]['image'].length !=0
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.network(
                                      allDataAdds[index]['image'][0]['url'],
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
                                  )
                                    //  Image.asset(
                                    //   AppImages.profileBg,
                                    //   width: Get.width/4
                                    // ),
                                ),
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    allDataAdds[index]['title']['en'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: allDataAdds[index]['is_rated'] ==false
                                      ? RatingBar.builder(
                                        initialRating: allDataAdds[index]['rating'].toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22.5,
                                        itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                                        onRatingUpdate: (rating) {
                                          print('rating on tap ........$rating');
                                          var ratingjson = {
                                            'ads_id': allDataAdds[index]['id'],
                                            'rate': rating
                                          };
                                          print('.....................Rating data on Tap .........$ratingjson');
                                          ratingcont.ratings(ratingjson);
                                          // ratingcont.getratings(allDataAdds[index]['id']);
                                        },
                                      )
                                      : RatingBar.builder(
                                        initialRating: allDataAdds[index]['rating'].toDouble(),
                                        ignoreGestures: true,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22.5,
                                        itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                        onRatingUpdate: (rating) {
                                          // ratingcont.getratings(allDataAdds[index]['id']);
                                        },
                                      )
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   flex: 2,
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.person,color: Colors.grey),
                                //       Container(
                                //         // margin:EdgeInsets.only(left:29),
                                //         child: Text(
                                //           allDataAdds[index]['country_id'] != null
                                //           ? allDataAdds[index]['country_id']
                                //           : '',
                                //           style: TextStyle(
                                //             color: Colors.grey[300]
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                
                              ],
                            ),
                          ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(Icons.person)
                            )
                          ),
                          Container(
                              // width: Get.width/4,
                              // height: Get.height/5.5,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var json = {
                                      'ads_id': allDataAdds[index]['id']
                                    };
                                    liked = !liked;
                                    allDataAdds[index]['is_favorite'] ==false
                                    ? friCont.profileAdsToFav(json, userId)
                                    : friCont.profileAdsRemove(json, userId);
                                    controller.addedByIdAddes(catID, null);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: allDataAdds[index]['is_favorite'] ==false
                                    ? Image.asset(AppImages.blueHeart,height: 25)
                                    : Image.asset(AppImages.redHeart,height: 25)
                                  ),
                                ),
                                Image.asset(AppImages.call, height: 25),
                              ],
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  var ind = 0;
  myAddGridView(dataListValue) {
    return Container(
      margin: EdgeInsets.only(bottom:20),
      width: Get.width / 1.12,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: List.generate(
          dataListValue.length, (index) {
            return GestureDetector(
              onTap: () {
                Get.to(AdViewScreen(), arguments: dataListValue[index]['id']);
              },
              child: Container(
                decoration: new BoxDecoration(),
                width: Get.width < 420 ? Get.width / 7.0 : Get.width / 7,
                //margin: EdgeInsets.only(left: 10),
                height:Get.height < 420 ? Get.height / 3.6 : Get.height / 8.0,
                child: Container(
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
                            topRight: Radius.circular(10)
                          ),
                          child: Container(
                            width: Get.width < 420
                            ? Get.width / 1.4
                            : Get.width / 2.3,
                            //height: Get.height / 6.0,
                             height: Get.height / 8.0,
                            child: dataListValue[index]['image'].length != 0
                            ? Image.network(
                              dataListValue[index]['image'][0]['url'],
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
                        Container(
                          alignment: lang == 'en'
                          ? Alignment.center
                          : Alignment.center,
                          //margin: lang=='en'?EdgeInsets.only(left: 50):EdgeInsets.only(right: 50),
                          child: Text(
                            dataListValue[index]['title'] != null
                            ? dataListValue[index]['title']['en'].toString()
                            : '',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: dataListValue[index]['is_rated'] ==false
                          ? RatingBar.builder(
                            initialRating: dataListValue[index]['rating'].toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 22.5,
                            itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                            onRatingUpdate: (rating) {
                              print('rating on tap ........$rating');
                              var ratingjson = {
                                'ads_id': dataListValue[index]['id'],
                                'rate': rating
                              };
                              print('.....................Rating data on Tap .........$ratingjson');
                              ratingcont.ratings(ratingjson);
                              // ratingcont.getratings(allDataAdds[index]['id']);
                            },
                          )
                          : RatingBar.builder(
                            initialRating: dataListValue[index]['rating'].toDouble(),
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 22.5,
                            itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                            onRatingUpdate: (rating) {
                              // ratingcont.getratings(allDataAdds[index]['id']);
                            },
                          )
                        ),
                        // Expanded(
                        //           flex: 2,
                        //           child: Row(
                        //             children: [
                        //               Icon(Icons.person,color: Colors.grey),
                        //               Container(
                        //                 // margin:EdgeInsets.only(left:29),
                        //                 child: Text(
                        //                   allDataAdds[index]['contact_name'] != null
                        //                   ? allDataAdds[index]['contact_name']
                        //                   : '',
                        //                   style: TextStyle(
                        //                     color: Colors.grey[300]
                        //                   ),
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: lang == 'en'
                            ? EdgeInsets.only(left: 5)
                            : EdgeInsets.only(right: 5),
                            child: Row(
                              children: [
                                Icon(Icons.person,color: Colors.grey[400]),
                                Container(
                                  child: Text(
                                    dataListValue[index]['contact_name'] !=null
                                    ? dataListValue[index]['contact_name']
                                    : '',
                                    style: TextStyle(color: Colors.grey[300]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            );
          }
        )
      ),
    );
  }

  Widget submitButton(
      {buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      fontWeight,
      height,
      width,
      borderColor}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      borderColor: borderColor,
      height: height,
      width: width,
    );
  }

  void navigateToGoogleLogin() {}

  Widget addsCategoryWidget(listingCategoriesData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: lang=='en'?EdgeInsets.only(left: 10):EdgeInsets.only(right: 10),
          height: MediaQuery.of(context).size.height / 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listingCategoriesData.length,
            itemBuilder: (context, index) {
              print(
                  "........------------=============-----------------${data != null && id == listingCategoriesData[index]['id']}");
              if (data != null && id == listingCategoriesData[index]['id']) {
                print("........");
                catID = listingCategoriesData[index]['id'];
                selectedIndex = index;
                // ind = 0;
              } else if (data == null && ind == 0) {
                id = listingCategoriesData[index]['id'];
                catID = listingCategoriesData[index]['id'];
                controller.addedByIdAddes(listingCategoriesData[0]['id'], null);
                selectedIndex = index;
                ++ind;
              }
              // if (ind == 0) {
              //   catID = listingCategoriesData[index]['id'];
              //   controller.addedByIdAddes(listingCategoriesData[0]['id'], null);
              // }
              // ++ind;
              return Row(
                children: [
                  Container(
                    margin: lang == 'en'
                    ? EdgeInsets.only(left: 12.0)
                    : EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          ind = ++ind;
                          selectedIndex = index;
                          id = listingCategoriesData[index]['id'];
                          controller.addedByIdAddes(
                              listingCategoriesData[index]['id'], null);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index &&id == listingCategoriesData[index]['id']
                          ? AppColors.appBarBackGroundColor
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
                        child: listingCategoriesData != null
                        ? Text(
                            listingCategoriesData[index]['category']['en'],
                            style: TextStyle(
                              color: selectedIndex == index && id == listingCategoriesData[index]['id']
                              ? Colors.white
                              : AppColors.appBarBackGroundColor,
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
              print("context Api......... .>$val");
              if (ind1 == 0) {
                // controller.addedByIdAddes(listingCategoriesData[0]['id']);
              }
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // ind1 = ++ind1;
                          selectedIndexListing = val;
                          category = dataListedCateOffer[val]['type']['en'];
                          //controller.addedByIdAddes(listingCategoriesData[index]['id']);
                          // filterControlller
                          //     .createFilterAds(dataListedCateOffer[val]['id']);
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
                            dataListedCateOffer[val]['type']['en'],
                            style: TextStyle(
                              color: selectedIndexListing == val
                              ? Colors.white
                              : Colors.blue,
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
}
