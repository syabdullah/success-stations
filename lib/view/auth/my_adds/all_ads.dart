import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/all_add_controller.dart';
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
  final addsGet = Get.put(MyAddsController());
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
   bool havingCategorybool = false;

  var bClicked = false;
  var grid = AppImages.gridOf;
  var listImg = AppImages.listing;
  Color selectedColor = Color(0xFF2F4199);
  Color listIconColor = AppColors.appBarBackGroundColor;
  bool liked = false;
  Color filterSelecredColor =Color(0xFF2F4199);
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
    catCont.havingCategoryByAdds();
    banner.bannerController();
    controller.addedAllAds();
    catCont.getCategoryTypes();
    addsGet.myAddsCategory();
    havingCategorybool = false;
    catCobtroller.listingTypes();
    lang = box.read('lang_code');
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
          SizedBox(height: 10),
          topWidget(),
          SizedBox(height: 10),
          GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (data) {
              return data.isLoading == true
              ? CircularProgressIndicator()
              : data.havingAddsList != null
                ? addsCategoryWidget(data.havingAddsList['data'])
                : Container();
            },
          ),
          SizedBox(height:20),
          havingCategorybool == false ? 
          Expanded(
            child: GetBuilder<AddBasedController>(
              init: AddBasedController(),
              builder: (val) {
                return val.isLoading == true || val.allAdsData == null? Container()
                : val.allAdsData['data'] == null ? Container(): listtype != 'grid' ? myAddsList(val.allAdsData['data']): myAddGridView(val.allAdsData['data']
                );
              },
            )
          ): 
          Expanded(
            child: GetBuilder<AddBasedController>(
              init: AddBasedController(),
              builder: (val) {
                return val.isLoading == true || val.cData == null? Container()
                : val.cData['data'] == null ? Container()
                  : listtype != 'grid' ? myAddsList(val.cData['data']) : myAddGridView(  val.cData['data']
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
          heightFactor: 0.8,
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
                                      color: Color(0xFF2F4199),
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
                                activeColor: Color(0xFF2F4199),
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
    filterControlller.createFilterAds(json);
  }

  var catID;
  Widget myAddsList(allDataAdds) {
    return ListView.builder(
      itemCount: allDataAdds.length,
      itemBuilder: (BuildContext context, index) {
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
                                          var ratingjson = {
                                            'ads_id': allDataAdds[index]['id'],
                                            'rate': rating
                                          };
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
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.person,color: Colors.grey),
                                      Container(
                                        // margin:EdgeInsets.only(left:29),
                                        child: Text(
                                          allDataAdds[index]['contact_name'] != null
                                          ? allDataAdds[index]['contact_name']
                                          : '',
                                          style: TextStyle(
                                            color: Colors.grey[300]
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
      width: Get.width / 1.10,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
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
                             height: Get.height / 10.5,
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
                           margin: EdgeInsets.only(left:10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: dataListValue[index]['is_rated'] ==false
                                        ? RatingBar.builder(
                                          initialRating: dataListValue[index]['rating'].toDouble(), 
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 14.5,
                                          itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            var ratingjson = {
                                              'ads_id': dataListValue[index]['id'],
                                              'rate': rating
                                            };
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
                                          itemSize: 14.5,
                                          itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            // ratingcont.getratings(allDataAdds[index]['id']);
                                          },
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
                                      'ads_id': dataListValue[index]['id']
                                    };
                                    liked = !liked;
                                   dataListValue[index]['is_favorite'] ==false
                                    ? friCont.profileAdsToFav(json, userId)
                                    : friCont.profileAdsRemove(json, userId);
                                    controller.addedByIdAddes(catID, null);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: dataListValue[index]['is_favorite'] ==false
                                    ? Image.asset(AppImages.blueHeart,height: 20)
                                    : Image.asset(AppImages.redHeart,height: 20)
                                  ),
                                ),
                                Image.asset(AppImages.call, height: 20),
                              ],
                            )
                          )
                                    ],
                                  ),
                         ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: lang == 'en'
                            ? EdgeInsets.only(left: 9,right: 10)
                            : EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    dataListValue[index]['price'] !=null
                                    ? " SAR ${dataListValue[index]['price']}"
                                    : '',
                                    style: TextStyle(color: AppColors.appBarBackGroundColor),
                                  ),
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

  Widget addsCategoryWidget(havingAdds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: havingAdds.length,
            itemBuilder: (context, index) {
              
              // if (data != null && id == havingAdds[index]['id']) {
              //   print("........");
              //   catID = havingAdds[index]['id'];
              //   selectedIndex = index;
              //   // ind = 0;
              // } else if (data == null && ind == 0) {
              //   id = havingAdds[index]['id'];
              //   catID = havingAdds[index]['id'];
              //   controller.addedByIdAddes(havingAdds[0]['id'], null);
              //   selectedIndex = index;
              //   ++ind;
              // }

              return index == 0 ? Container(
                width: 70,
                    margin: lang == 'en'
                    ? EdgeInsets.only(left: 12.0)
                    : EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                        selectedIndex = index;
                        addsGet.myAddsCategory();
                        havingCategorybool = false;
                        });
                      },
                      child: Container(
                        margin:EdgeInsets.only(left:10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index
                          ? selectedColor
                          : Colors.white,
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "All",
                            style: TextStyle(
                              color: selectedIndex == index ? Colors.white  : AppColors.appBarBackGroundColor,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
              ):
              Row(
                children: [
                  Container(
                    margin: lang == 'en'
                    ? EdgeInsets.only(left: 12.0)
                    : EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                         havingCategorybool =true;
                          ind = ++ind;
                          selectedIndex = index;
                          id = havingAdds[index]['id'];
                          controller.addedByIdAddes(havingAdds[index]['id'], null);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index &&id == havingAdds[index]['id']
                          ? AppColors.appBarBackGroundColor
                          : Colors.white,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey,
                          //     offset: Offset(0.0, 1.0),
                          //     blurRadius: 6.0,
                          //   ),
                          // ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: havingAdds != null
                        ? Text(
                            havingAdds[index]['category']['en'],
                            style: TextStyle(
                              color: selectedIndex == index && id == havingAdds[index]['id']
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
                          border: Border.all(color: Color(0xFF2F4199)),
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
                              : Color(0xFF2F4199),
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
