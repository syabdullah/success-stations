import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/location_controller.dart';
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
      appBar:
      AppBar(
        // leadingWidth: 76,
        backgroundColor:Colors.white,
        title: Container(
          // margin: EdgeInsets.only(top: 12),
            child: Text(
              "Our Location",
              style: TextStyle(

                  fontSize: 18,color: Colors.black,fontFamily: "Source_Sans_Pro",fontWeight: FontWeight.w400),
            )),
        centerTitle: true,
        leading: Container(
            margin: EdgeInsets.only( left: 7),
            child: GestureDetector(
                onTap: (){
                  _scaffoldKey.currentState!.openDrawer();
                },
                child:  Padding(
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
                      color: Colors.black, height: 30)),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Get.to(AddLocations());
            },
            child: Center(
              child: Container(
                  margin: EdgeInsets.only( right:10),
                  child: Image.asset(AppImages.setting,
                      color: Colors.black, height: 35)),
            ),
          ),
        ],),


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
                            ? Expanded(child: myAddsList(val.locData['data']))
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
      itemCount: 3,
      // data != null ? data.length : 0,
      itemBuilder: (BuildContext context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Center(
                    //       child: Container(
                    //           child: GestureDetector(
                    //               child: data[index]['image'] != null &&
                    //                       data[index]['image']['url'] != null
                    //                   ? ClipRRect(
                    //                       borderRadius:
                    //                           BorderRadius.all(Radius.circular(0)),
                    //                       child: Image.network(
                    //                         data[index]['image']['url'],
                    //                         height: 100,
                    //                         width: Get.width / 5.5,
                    //                         fit: BoxFit.fill,
                    //                       ),
                    //                     )
                    //                   : Container(
                    //                       child: Image.asset(AppImages.locationimg),
                    //                       width: Get.width / 6))),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           data[index]['location'] != null
                    //               ? Container(
                    //                   width: Get.width / 3.0,
                    //                   child: Text(
                    //                     data[index]['location'],
                    //                     style: TextStyle(
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                 )
                    //               : Container(),
                    //           SizedBox(height: 7),
                    //           Container(
                    //             width: Get.width / 3.0,
                    //             child: ReadMoreText(
                    //               data[index]['formated_address'] != null
                    //                   ? data[index]['formated_address']
                    //                   : '',
                    //               trimLines: 2,
                    //               trimMode: TrimMode.Line,
                    //               trimCollapsedText: 'Show more',
                    //               trimExpandedText: 'Show less',
                    //               textAlign: TextAlign.left,
                    //               colorClickableText:
                    //                   AppColors.whitedColor,
                    //               style: TextStyle(
                    //                 fontSize: 13,
                    //                 color: Colors.grey[400],
                    //               ),
                    //             ),
                    //           ),
                    //           data[index]['services'] != null
                    //               ? Row(
                    //                   children: [
                    //                     Container(
                    //                       child: Text(
                    //                         "Service:   ",
                    //                         style: TextStyle(
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       width: Get.width / 3.6,
                    //                       child: Text(
                    //                         data[index]['services']
                    //                                 ['servics_name'] ??
                    //                             '',
                    //                         style: TextStyle(
                    //                           color: Colors.grey,
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 )
                    //               : Container(),
                    //           data[index]['country_name'] != null
                    //               ? Row(
                    //                   children: [
                    //                     Container(
                    //                       child: Text(
                    //                         "Country: ",
                    //                         style: TextStyle(
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       width: Get.width / 3.6,
                    //                       child: Text(
                    //                         " ${data[index]['country_name']}",
                    //                         style: TextStyle(
                    //                           color: Colors.grey,
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 )
                    //               : Container()
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20),
                    // Container(
                    //   padding: lang == 'en'
                    //       ? EdgeInsets.only(right: 20)
                    //       : EdgeInsets.only(left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           locationCon.deleteLocationToDB(data[index]['id'], id);
                    //         },
                    //         child: Container(
                    //             // padding: EdgeInsets.only(right: 5),
                    //             child: Image.asset(AppImages.delete_offer, height: 30)),
                    //       ),
                    //       SizedBox(width: 5),
                    //       GestureDetector(
                    //           onTap: () {
                    //             Get.to(AddLocations(), arguments: data[index]);
                    //           },
                    //           child: Container(
                    //               child: Image.asset(AppImages.edit_Offer, height: 30))),
                    //     ],
                    //   ),
                    // ),
                    // Image.asset("AppImages.edit_Offer"),

                    Container(
                      height: Get.height / 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 2, bottom: 2, left: 3, right: 0),
                        child: Container(
                            child: GestureDetector(
                                child: data[index]['image'] != null &&
                                        data[index]['image']['url'] !=
                                            null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(0)),
                                        child: Image.network(
                                          data[index]['image']['url'],
                                          height: 80,
                                          width: Get.width / 5.2,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(
                                        child: Image.asset(
                                            AppImages.locationimg),
                                        width: Get.width / 6))),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "jarir book,",
                          style: TextStyle(
                              fontFamily: "Source_Sans_Pro",
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )),
                        Container(
                            child: Text(
                              "Saudi Arabia-Jeddah-Tahliya st",
                              style: TextStyle(
                                  fontFamily: "Source_Sans_Pro",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              locationCon
                                  .deleteLocationToDB(
                                      data[index]
                                          ['id'],
                                      id);
                            },
                            child: Container(
                                child: Image.asset(
                                    AppImages
                                        .delete_offer,
                                    height: 20)),
                          ),
                          SizedBox(width: 5,),
                          GestureDetector(
                              onTap: () {
                                Get.to(AddLocations(),
                                    arguments:
                                    data[index]);
                              },
                              child: Image.asset(
                                  AppImages
                                      .edit_Offer,
                                  height: 20)),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),

                  ],
                )));
      },
    );
  }
}
