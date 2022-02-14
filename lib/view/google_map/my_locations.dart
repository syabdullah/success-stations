import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/google_map/add_locations.dart';

class MyLocations extends StatefulWidget {
  const MyLocations({Key? key}) : super(key: key);

  @override
  _MyLocationsState createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final locationCon = Get.put(LocationController());
  GetStorage box = GetStorage();
  var id;
  var lang;

  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
    id = box.read('user_id');
    locationCon.getMyLocationToDB(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 1.0,
        // leadingWidth: 76,
        backgroundColor: Colors.white,
        title: Container(
            // margin: EdgeInsets.only(top: 12),
            child: Text(
          "location".tr,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "Source_Sans_Pro",
              fontWeight: FontWeight.w400),
        )),
        centerTitle: true,
        leading: Container(
            margin: lang == 'ar' ?EdgeInsets.only(right: 7):EdgeInsets.only(left: 7),
            child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(AppImages.imagearrow1,
                      color: Colors.black, height: 22),
                ))),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AddLocations());
            },
            child: Center(
              child: Container(
                  // margin: EdgeInsets.only( left: 15,),
                  child: Image.asset(AppImages.plusImage,
                      color: Colors.black, height: 18)),
            ),
          ),
          SizedBox(width: Get.width * 0.04),
          GestureDetector(
            onTap: () {
              // Get.to(AddLocations());
            },
            child: Center(
              child: Container(
                  margin: lang == 'ar'
                      ? EdgeInsets.only(left: 10)
                      : EdgeInsets.only(right: 10),
                  child: Image.asset(AppImages.setting,
                      color: Colors.black, height: 18)),
            ),
          ),
          SizedBox(width: Get.width * 0.02),
        ],
      ),

      // leading: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.only(top:12, left:7),
      //       child: GestureDetector(
      //         onTap: (){
      //           _scaffoldKey.currentState!.openDrawer();
      //         },
      //         child: Icon(
      //           Icons.arrow_back, size: 22,
      //         )
      //       )
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         Get.to(AddLocations());
      //       },
      //       child: Container(
      //         margin: EdgeInsets.only(top:12, left:7),
      //         child:Image.asset(AppImages.plusImage,color:Colors.white, height:22)
      //       ),
      //     ),
      //   ]
      // ),
      // ),
      drawer: Theme(
        data: Theme.of(context).copyWith(),
        child: AppDrawer(),
      ),
      body: Stack(
        children: [
          Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  GetBuilder<LocationController>(
                      init: LocationController(),
                      builder: (val) {
                        return val.locData != null &&
                                val.locData['data'].length != 0
                            ? Expanded(child: Padding(
                              padding:  EdgeInsets.only(top:Get.height*0.01),
                              child: myAddsList(val.locData['data']),
                            ))
                            : Container(
                                child: Center(
                                    heightFactor: 8 * 4,
                                    child: Text(
                                      "No Location added yet!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              );
                      })
                ],
              )),
        ],
      ),
    );
  }

  Widget myAddsList(data) {
    return ListView.builder(
      // padding: EdgeInsets.only(left:10),
      itemCount: data.length,
      // data != null ? data.length : 0,
      itemBuilder: (BuildContext context, index) {
        print("sanket" + data[index]['formated_address']);
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26)),
                child: Row(
crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: lang == "ar"
                                ? EdgeInsets.only(top: 3, bottom: 3, right: 3)
                                : EdgeInsets.only(
                                top: 3, bottom: 3, left: 3, right: 0),
                            child: Center(
                              child: Container(
                                child: GestureDetector(
                                    child: data[index]['image'] != null &&
                                        data[index]['image']['url'] != null
                                        ? Image.network(
                                      data[index]['image']['url'],
                                      width: Get.width / 4.4,
                                      height: Get.height * 0.08,
                                      fit: BoxFit.cover,
                                    )
                                        : Container(
                                        child: Image.asset(AppImages.locationimg),
                                        width: Get.width / 6)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: lang == "ar"
                                ? EdgeInsets.only(right: Get.width * 0.04)
                                : EdgeInsets.only(left: Get.width * 0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: lang == "ar"
                                      ? EdgeInsets.only(
                                          right: Get.width * 0.01,
                                          top: Get.width * 0.01)
                                      : EdgeInsets.only(
                                          left: Get.width * 0.01,
                                          top: Get.width * 0.01),
                                  child: Container(
                                      child: Text(
                                    data[index]['location'],
                                    style: TextStyle(
                                        fontFamily: "Source_Sans_Pro",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )),
                                ),
                                SizedBox(height: Get.height * 0.005),
         Container(
        width: lang == "ar"?Get.width/1.92:Get.width/2,
        child: Padding(
        padding:lang == "ar"?EdgeInsets.only(left: Get.width*0.1):EdgeInsets.only(),
                                    child: ReadMoreText(
                                      data[index]['formated_address'] != null
                                          ? data[index]['formated_address']
                                          : '',
                                      trimLines: 2,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show More',

                                      trimExpandedText: 'Show less',
                                      textAlign: TextAlign.left,
                                      colorClickableText:
                                          AppColors.whitedColor,
                                      style: TextStyle(
                                          fontFamily: "Source_Sans_Pro",
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: lang == 'ar'
                          ? EdgeInsets.only(
                          bottom: Get.width * 0.02,
                          left: Get.width * 0.02,
                          top: Get.width * 0.02)
                          : EdgeInsets.only(
                          bottom: Get.width * 0.02,
                          right: Get.width * 0.02),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              GestureDetector(
                                onTap: () {
                                  locationCon.deleteLocationToDB(
                                      data[index]['id'], id);
                                },
                                child: Container(
                                    child: Image.asset(
                                        AppImages.delete_offer,
                                        height: 21)),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(AddLocations(),
                                        arguments: data[index]);
                                  },
                                  child: Image.asset(AppImages.edit_Offer,
                                      height: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}
