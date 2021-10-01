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
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/add_posting_screen.dart';
import 'package:success_stations/view/auth/my_adds/filtering_adds.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: data != null?
       AppBar(
        leading:GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Image.asset(AppImages.arrowBack)
        ),
        elevation: 0,
        backgroundColor: AppColors.appBarBackGroundColor,
        centerTitle: true,
        title:Text('allAds'.tr,
          style: AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
        )
      )
      : null,
      body:  ListView(
        children: [
          SizedBox(height: 10),
          topWidget(),
          SizedBox(height: 10),
          GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (data) {
              return data.havingAddsList!=null && data.havingAddsList['data']  !=null ? addsCategoryWidget(data.havingAddsList['data']):
              Container();
            },
          ),
          SizedBox(height:20),
          havingCategorybool == false ? 
          // Expanded(
          //   child: 
            GetBuilder<AddBasedController>(
              init: AddBasedController(),
              builder: (val) {
                return val.isLoading == true || val.allAdsData == null? Container()
                : val.allAdsData['data'] == null ? Container(): listtype != 'grid' ? myAddsList(val.allAdsData['data']): myAddGridView(val.allAdsData['data']
                );
              },
            )
          // )
          : 
          // Expanded(
          //   child: 
            GetBuilder<AddBasedController>(
              init: AddBasedController(),
              builder: (val) {
                return val.isLoading == true || val.cData == null? Container()
                : val.cData['data'] == null ? Container()
                  : listtype != 'grid' ? myAddsList(val.cData['data']) : myAddGridView(  val.cData['data']
                  );
              },
            )
          // )
        ],
      ),
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
               Get.to(AddPostingScreen());
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
                                : data.havingAddsList != null && data.havingAddsList['data'] != null
                                  ? Container(
                                    height: Get.height * 0.035,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.havingAddsList['data'].length,
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
                                                    catFilteredID = data.havingAddsList['data'][index]['id'];
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
                                                  child:
                                                   Text(data.havingAddsList['data'][index]['category'][lang] !=null ? data.havingAddsList['data'][index]['category'][lang].toString():
                                                    data.havingAddsList['data'][index]['category'][lang] == null ? data.havingAddsList['data'][index]['category']['en'].toString():'',
                                                    style: TextStyle(
                                                      color: filteredIndex == index
                                                      ? AppColors.appBarBackGroundColor
                                                      : AppColors.appBarBackGroundColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                  )
                                                  
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
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
                              child: Icon(Icons.person, color: AppColors.appBarBackGroundColor,)
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5,left: 5),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var json = {
                                      'ads_id': allDataAdds[index]['id']
                                    };
                                    allDataAdds[index]['is_favorite'] ==false
                                    ? friCont.profileAdsToFav(json, userId)
                                    : friCont.profileAdsRemove(json, userId);
                                    controller.addedAllAds();
                                    controller.addedByIdAddes(allDataAdds[index]['category_id'], null);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5,left: 5),
                                    child: allDataAdds[index]['is_favorite'] ==false
                                    ? Image.asset(AppImages.blueHeart,height: 25)
                                    : Image.asset(AppImages.redHeart,height: 25)
                                  ),
                                ),
                              Container(
                              // padding: EdgeInsets.only(right:15),
                              child: 
                              allDataAdds[index]['phone'] !=null ? GestureDetector(
                                onTap: (){
                                   launch("tel:${allDataAdds[index]['phone']}");
                                },
                                child: Image.asset(AppImages.call, height: 25)): Container()
                              )
                                
                                // Image.asset(AppImages.call, height: 25),
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
  var splitedPrice;
  myAddGridView(dataListValue) {
    return Container(
      padding: EdgeInsets.only(left:10,right:10),
      width: Get.width / 1.10,
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: (
           lang == 'en' ?Get.width / 1.10 / Get.height / 0.47:Get.width / 1.10 / Get.height / 0.49),
        children: List.generate(
          dataListValue.length, (index) {
            var price = dataListValue[index]['price'].toString();
            splitedPrice = price.split('.');
            return  GestureDetector(
              onTap: (){
                Get.to(AdViewScreen(), arguments: dataListValue[index]['id']);
              },
              child: Container(
                height: Get.height,
                decoration: BoxDecoration(
                  // borderRadius:BorderRadius.circular(3),
                  border: Border.all(color: Colors.black)
                ),
                child: Column(
                  children: [
                     Container(
                          width: Get.width < 420
                          ? Get.width / 1.4
                          : Get.width / 2.3,
                           height: Get.height /8.0,
                          child: dataListValue[index]['image'].length != 0
                          ? Stack(
                           alignment:AlignmentDirectional.topStart,
                            children: [
                              Image.network(
                                dataListValue[index]['image'][0]['url'],
                                width: Get.width,
                                height: 100,
                                fit: BoxFit.fill
                              ),
                              Container(
                                 padding: EdgeInsets.only(right: 5,left: 5,top: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    var json = {
                                      'ads_id': dataListValue[index]['id']
                                    };
                                   dataListValue[index]['is_favorite'] ==false ? 
                                   friCont.profileAdsToFav(json, userId): friCont.profileAdsRemove(json, userId);
                                   controller.addedAllAds();
                                   controller.addedByIdAddes(dataListValue[index]['category_id'], null);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 2,left: 5),
                                    child: dataListValue[index]['is_favorite'] ==false
                                    ? Image.asset(AppImages.blueHeart,height: 30)
                                    : Image.asset(AppImages.redHeart,height: 30)
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Stack(
                           alignment:AlignmentDirectional.topStart,
                            children: [
                             
                              Container(
                                padding: EdgeInsets.only(right: 6,bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    var json = {
                                      'ads_id': dataListValue[index]['id']
                                    };
                                    // liked = !liked;
                                    dataListValue[index]['is_favorite'] ==false ? friCont.profileAdsToFav(json, userId) : friCont.profileAdsRemove(json, userId);
                                    controller.addedAllAds(); 
                                    controller.addedByIdAddes(dataListValue[index]['category_id'], null);
                                                       
                                   },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5,left: 5),
                                    child: dataListValue[index]['is_favorite'] ==false
                                    ? Image.asset(AppImages.blueHeart,height: 30)
                                    : Image.asset(AppImages.redHeart,height: 30)
                                  ),
                                ),
                              ),
                               Positioned(
                                //  right: 20,
                                //  left: 15,
                                child: Container(),
                               ),
                            ],
                          )
                        ),
                       Container(
                         margin: EdgeInsets.only(left:10,right: 10),
                         child: Container(
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
                       ),
                        Container(
                        alignment: lang == 'en'
                        ? Alignment.center
                        : Alignment.center,
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
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             dataListValue[index]['price'] !=null
                             ? "${splitedPrice[0]}"
                             : '',
                             style: TextStyle(color: AppColors.appBarBackGroundColor),
                      ),
                       Text(
                         ' SAR',
                         style: TextStyle(color: AppColors.appBarBackGroundColor,fontSize: 7),
                      ),
                         ],
                       ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment:AlignmentDirectional.topStart,
                           children: [
                              Positioned(
                                left: 10,
                                top:2.5,
                                child: Image.asset(AppImages.newuser,height: 20,),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:28,right: 5),
                                width:50,
                                // height: 25,
                                decoration: BoxDecoration(
                                  // border: Border.all(),
                                  // borderRadius: BorderRadius.circular(4),
                                border: Border(
                                    top:BorderSide(color: Colors.black,width:1.5, ) ,
                                    right: BorderSide(color: Colors.black,style:BorderStyle.solid,width:1.5,) ,
                                    left: BorderSide(color: Colors.grey,width: 0.3),
                                    bottom: BorderSide(color: Colors.black,width:1.5,)
                                  ),
                               
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left:5,right: 5),
                                child: Text(
                                  dataListValue[index]['contact_name'],
                                  overflow: TextOverflow.ellipsis,
                                  )),
                              )
                           ],
                         ),
                           GestureDetector(
                             onTap: (){
                               launch("tel:${dataListValue[index]['phone']}");
                             },
                             child: Container(
                               margin: EdgeInsets.only(left:5,right: 5),
                               child: Row(
                                 children: [
                                   Container(
                                    margin: EdgeInsets.only(),
                                    width: 63,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: AppColors.newphoneColor,
                                       borderRadius: lang == "ar" ?
                                       BorderRadius.only(
                                         topRight: Radius.circular(15),
                                         bottomRight: Radius.circular(15)
                                         )
                                         :BorderRadius.only(
                                         topLeft: Radius.circular(15),
                                         bottomLeft: Radius.circular(15)
                                         )
                                    ),
                                    child: Center(child: Text("callme".tr,style: TextStyle(color: Colors.white,fontSize:8,))),
                                   ),
                                   Container(
                                    margin: EdgeInsets.only(),
                                    width: 20,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: lang == "ar" ?
                                       BorderRadius.only(
                                         topLeft: Radius.circular(15),
                                         bottomLeft: Radius.circular(15)
                                         )
                                         :
                                         BorderRadius.only(
                                         topRight: Radius.circular(15),
                                         bottomRight: Radius.circular(15)
                                         )
                                    ),
                                    child: Center(child: Image.asset(AppImages.newcall,height: 10,)),
                                   ),
                                 ],
                               ),
                             ),
                           )
                       
                        ],
                      )
                    ]  
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
  var allCheck = false;
 Color allColor = AppColors.appBarBackGroundColor;
 bool textAllcheck = false;
  Widget addsCategoryWidget(havingAdds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: havingAdds.length,
            itemBuilder: (context, index) {
              if(index != 0 ) {
                allCheck = true;
              }else {
                allCheck = false;
              }
              return 
              Row(
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
                          havingCategorybool = false;
                          textAllcheck = false;
                          selectedIndex = index;
                          allColor = AppColors.appBarBackGroundColor;
                          addsGet.myAddsCategory();                      
                        });
                      },
                      child: Container(
                        margin:EdgeInsets.only(left:10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: AppColors.appBarBackGroundColor),
                          color: allColor,
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
                  ):Container(),
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
                          allColor = Colors.white;
                          textAllcheck = true;
                          id = havingAdds[index]['id'];
                          controller.addedByIdAddes(havingAdds[index]['id'], null);
                          // addsGet.myAddsCategory();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: AppColors.appBarBackGroundColor),
                          color: selectedIndex == index &&id == havingAdds[index]['id'] && textAllcheck == true
                          ? AppColors.appBarBackGroundColor
                          : Colors.white,
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: 
                         Text( havingAdds[index]['category'][lang] !=null ? havingAdds[index]['category'][lang]: havingAdds[index]['category'][lang] == null ?havingAdds[index]['category']['en']:'' ,
                          style: TextStyle(
                            color: selectedIndex == index && id == havingAdds[index]['id'] && textAllcheck == true
                            ? Colors.white
                            : AppColors.appBarBackGroundColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            ),
                          )
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
