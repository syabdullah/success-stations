import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:success_stations/controller/app_bar_filtered_controller.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/controller/services_controller.dart';
import 'package:success_stations/controller/user_fav_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_views/ad_viewmain.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:clippy_flutter/triangle.dart';

import '../shimmer.dart';

class CustomInfoWindowExample extends StatefulWidget {
  @override
  _CustomInfoWindowExampleState createState() =>
      _CustomInfoWindowExampleState();
}

class _CustomInfoWindowExampleState extends State<CustomInfoWindowExample> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  RangeValues _currentRangeValues = const RangeValues(1, 10000);
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  final mapCon = Get.put(LocationController());
  final adfavUser = Get.put(UserFavController());
  // ignore: unused_field
  late LatLng _latLng = LatLng(51.5160322, 51.516032199999984);
  final double _zoom = 5.0;
  // ignore: non_constant_identifier_names
  int _makrr_id_counter = 1;
  var listtype = 'map';
  //  Marker _markers = [];
  List<Marker> _markers = [];
  var adtofavJson, remtofavJson;
  var route;
  var lang;
  var grid = AppImages.gridOf;
  Color listIconColor = Colors.blue;
  bool isButtonPressed = false;
  GetStorage box = GetStorage();
  bool visible = false;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
    gridingData.listingGrid('grid');
    var id = box.read('user_id');
    route = Get.arguments;
    lang = box.read('lang_code');
    mapCon.getAllLocationToDB();
  }

  _getUserLocation() async {
    position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latLng = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  void setMarkers(LatLng point, data) {
    final String markersId = 'marker_id_$_makrr_id_counter';
    _makrr_id_counter++;
    _markers.add(Marker(
        markerId: MarkerId(markersId),
        position: point,
        onTap: () {
          setState(() {
            visible = !visible;
          });
          double rat = double.parse(data['user_name']['rating'].toString());
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(AdViewTab(), arguments: data['user_name']['id']);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            data['image'] != null
                                ? Container(
                                    width: Get.width / 3.5,
                                    height: Get.height / 3,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15),
                                            bottom: Radius.circular(15)),
                                        child: Image.network(
                                          data['image']['url'],
                                          fit: BoxFit.fitHeight,
                                        )),
                                  )
                                : Container(
                                    height: Get.height / 3,
                                    width: Get.width / 5.5,
                                    color: Colors.grey[100],
                                    margin: EdgeInsets.all(20),
                                    child: Icon(Icons.image, size: 60)),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15),
                                      child: RatingBar.builder(
                                        initialRating: rat,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        allowHalfRating: true,
                                        // tapOnlyMode: false,
                                        itemCount: 5,
                                        itemSize: 19.5,
                                        // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      child: Text(
                                        "(${data['user_name']['rating_count'].toString()})",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: Get.width / 4,
                                  margin: EdgeInsets.only(top: 10, left: 15),
                                  child: Text(data['location'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)
                                      // Theme.of(context).textTheme.headline6!.copyWith(
                                      //       color: Colors.black,
                                      //     ),
                                      ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                child: data['user_name']
                                            ['is_location_favourite'] ==
                                        true
                                    ? Image.asset(
                                        AppImages.redHeart,
                                        height: 30,
                                      )
                                    : Image.asset(
                                        AppImages.blueHeart,
                                        height: 30,
                                      ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.blue,
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            point,
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey1,
      drawer: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(children: [
              Container(
                color: Colors.white,
                height: Get.height,
                width: Get.width /1.5,
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30, right: 30),
                                  child: Text('filter'.tr,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 20),
                                    child: InkWell(
                                        onTap: () => Get.back(),
                                        child: Icon(Icons.close)))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: Get.width / 4,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(Icons.location_on,
                                      color: AppColors.whitedColor),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      color = Colors.blue[100];
                                      textfeild = !textfeild;
                                    });
                                    _getUserLocation();
                                  },
                                  child: Container(
                                    child: Text("Nearby".tr,
                                        style: TextStyle(
                                            color: AppColors.whitedColor)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            enabled: textfeild,
                                            hintStyle: TextStyle(
                                                color: AppColors.inputTextColor,
                                                fontSize: 13),
                                            labelStyle: TextStyle(
                                                color: AppColors.inputTextColor,
                                                fontSize: 13),
                                            labelText: ('city'.tr),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                        onTap: () {},
                                        onSubmitted: (val) {
                                          formKey.currentState!.save();
                                          setState(() {
                                            decideRouter = 'city';
                                            array.add(val);
                                            cityArray.add('city[]=$val');
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            enabled: textfeild,
                                            hintStyle: TextStyle(
                                                color: AppColors.inputTextColor,
                                                fontSize: 13),
                                            labelText: ('locationName'.tr),
                                            labelStyle: TextStyle(
                                                color: AppColors.inputTextColor,
                                                fontSize: 13),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              const BorderRadius.all(
                                                const Radius.circular(5.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                        onTap: () {},
                                        onSubmitted: (val) {
                                          formKey.currentState!.save();
                                          setState(() {
                                            decideRouter = 'name';
                                            namearray.add(val);
                                            cityArray.length == 0
                                                ? locationName = 'location=$val'
                                                : locationName = '&location=$val';
                                          });
                                        },
                                      ),
                                    ),
                                    GetBuilder<ServicesController>(
                                        init: ServicesController(),
                                        builder: (value) {
                                          return Container(
                                              margin: EdgeInsets.only(top: 10),
                                              padding:
                                              const EdgeInsets.only(top: 2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey, width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: Container(
                                                    width: Get.width,
                                                    child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          hint: Text(
                                                              selectedService != null
                                                                  ? selectedService
                                                                  : 'selectService'
                                                                  .tr,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: AppColors
                                                                      .inputTextColor)),
                                                          dropdownColor: AppColors
                                                              .inPutFieldColor,
                                                          icon: Icon(
                                                              Icons.arrow_drop_down),
                                                          items: value
                                                              .servicesListdata
                                                              .map((coun) {
                                                            return DropdownMenuItem(
                                                                value: coun,
                                                                child: Text(coun[
                                                                'servics_name']));
                                                          }).toList(),
                                                          onChanged: (val) {
                                                            var adsubCategory;
                                                            setState(() {
                                                              decideRouter = 'name';
                                                              adsubCategory =
                                                              val as Map;
                                                              selectedService =
                                                              adsubCategory[
                                                              'servics_name'];
                                                              service_id =
                                                              adsubCategory['id'];
                                                              locationName != null
                                                                  ? locationName =
                                                              '$locationName&service_id=$service_id'
                                                                  : locationName =
                                                              'service_id=$service_id';
                                                            });
                                                          },
                                                        )),
                                                  )));
                                        }),
                                  ],
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Text('distance'.tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                                "${_currentRangeValues.start.round().toString()} miles",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                          Container(
                            child: RangeSlider(
                              activeColor: AppColors.whitedColor,
                              values: _currentRangeValues,
                              min: 1.00,
                              max: 10000.00,
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
                                  end =
                                      _currentRangeValues.end.round().toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                    color: Colors.grey[100],
                                    child: Container(
                                        width: Get.width / 7,
                                        child: Center(
                                            child: Text('reset'.tr,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .inputTextColor)))),
                                    onPressed: () {
                                      array.clear();
                                      cityArray.clear();
                                      locationName = null;
                                      selectedService = null;
                                      Get.back();
                                      Get.find<LocationController>()
                                          .getAllLocationToDB();
                                      // Get.to(SignIn());
                                    }),
                              ),
                              Container(
                                // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    color: AppColors.whitedColor,
                                    child: Container(
                                        width: Get.width / 7,
                                        child: Center(
                                            child: Text("apply".tr,
                                                style:
                                                TextStyle(color: Colors.grey)))),
                                    onPressed: () {
                                      var cityFinalData;
                                      if (decideRouter == 'city' ||
                                          decideRouter == 'name') {
                                        if (cityArray.length != 0) {
                                          var cityFinal = cityArray.toString();
                                          cityFinalData = cityFinal.substring(
                                              1, cityFinal.length - 1);
                                        } else {
                                          cityFinalData = null;
                                        }
                                        Get.find<LocationController>()
                                            .getAllLocationByCity(
                                            cityFinalData, locationName);
                                      } else if (decideRouter == 'near') {
                                        Get.find<LocationController>()
                                            .getAllLocationNearBy(
                                            end,
                                            position.latitude,
                                            position.longitude);
                                      }
                                      Get.back();
                                    },
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]);
          }),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: appbar(scaffoldKey1, context, AppImages.appBarLogo,
              AppImages.appBarSearch, 3)),
      body: GetBuilder<LocationController>(
          init: LocationController(),
          builder: (val) {
            _markers.clear();
            if (val.allLoc != null && val.allLoc['success'] == true)
              for (int i = 0; i < val.allLoc['data'].length; i++) {
                if (val.allLoc['data'] != null) {
                  setMarkers(
                      LatLng(val.allLoc['data'][i]['long'],
                          val.allLoc['data'][i]['long']),
                      val.allLoc['data'][i]);
                  _latLng = LatLng(val.allLoc['data'][i]['long'],
                      val.allLoc['data'][i]['long']);
                }
              }
            return GetBuilder<GridListCategory>(
                init: GridListCategory(),
                builder: (valuee) {
                  return Stack(
                    children: [
                      valuee.dataType == 'map'
                          ? Stack(
                              children: <Widget>[
                                val.allLoc != null
                                    ? googleMap(val.latLng)
                                    : Container(),
                                CustomInfoWindow(
                                  controller: _customInfoWindowController,
                                  height: Get.height / 6,
                                  width: Get.width / 1.2,
                                  offset: 50,
                                ),
                              ],
                            )
                          : GetBuilder<LocationController>(
                              init: LocationController(),
                              builder: (value) {
                                return value.allLoc != null
                                    ? allUsers(value.allLoc['data'])
                                    : gridShimmer();
                              }),
                    ],
                  );
                });
          }),
    );
  }

  Widget topWidget() {
    return Container(
      margin: lang == 'en'
          ? EdgeInsets.only(
              left: 10,
            )
          : EdgeInsets.only(
              right: 10,
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: lang == 'en'
                ? EdgeInsets.only(left: 10, top: 20)
                : EdgeInsets.only(right: 10, top: 20),
            decoration: BoxDecoration(
              borderRadius: lang=='en'
              ?BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.zero,
              )
              :BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(10.0),
              ),
              color: listtype == 'map'
              ? Colors.white
              : listtype == 'grid'
              ? AppColors.whitedColor
              : Colors.white
            ),
            height: 60,
            width: 60,
            child: CupertinoButton(
                minSize: double.minPositive,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    listtype = 'grid';
                    box.write("type", listtype);
                    isButtonPressed = !isButtonPressed;
                    grid = AppImages.grid;
                  });
                },
                child: Image.asset(
                  AppImages.gridOf,
                  height: 45,
                  width: 30,
                  color: listtype == 'grid' ? Colors.white : Colors.grey,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                borderRadius: lang == 'en'
                    ? BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(10.0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.zero,
                      ),
                color: listtype == 'grid'
                    ? Colors.white
                    : listtype == 'map'
                        ? AppColors.appBarBackGroundColor
                        : AppColors.appBarBackGroundColor),
            //color: Colors.black,
            height: 60,
            width: 60,
            child: CupertinoButton(
              minSize: double.minPositive,
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  listtype = 'map';
                  isButtonPressed = !isButtonPressed;
                });
              },
              child: Image.asset(
                AppImages.map,
                color: listtype == 'map' ? Colors.white : Colors.grey,
                height: 50,
              ),
            ),
          ),
          SizedBox(height: 10, width: 15)
        ],
      ),
    );
  }

  Widget allUsers(userData) {
    return userData == null
        ? Container(
            child: Center(
            child: Text("locationFound".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ))
        : GridView.builder(
            padding:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 12, bottom: 10),
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              crossAxisCount: 2,
              childAspectRatio: Get.width /
                  (Get.height >= 800
                      ? Get.height / 1.65
                      : Get.height <= 800
                          ? Get.height / 1.60
                          : 0),
            ),
            itemCount: userData.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(AdViewTab(), arguments: userData[index]['id']);
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          child: Container(
                              width: Get.width / 2.2,
                              height: Get.height / 5.2,
                              child: userData[index]['image'] != null &&
                                      userData[index]['image']['url'] != null
                                  ? Image.network(
                                      userData[index]['image']['url'],
                                      fit: BoxFit.fill,
                                    )
                                  : FittedBox(
                                      fit: BoxFit.contain,
                                      child: Icon(Icons.person,
                                          color: Colors.grey[400]))),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 15, right: 15),
                            child: userData[index]['location'] != null &&
                                    userData[index]['location'] != null
                                ? Text(
                                    userData[index]['location'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                : Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                userData[index]['user_name'] != null
                                    ? Container(
                                        child: RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: userData[index]
                                                  ['user_name']['rating']
                                              .toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 13.5,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      )
                                    : Container(),
                                userData[index]['user_name'] != null
                                    ? Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "(${userData[index]['user_name']['rating_count'].toString()})",
                                          style: TextStyle(fontSize: 13),
                                        ))
                                    : Container()
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     adtofavJson = {
                            //       'location_id': userData['data'][index]['id']
                            //     };
                            //     remtofavJson = {
                            //       'location_id': userData['data'][index]['id']
                            //     };
                            //     userData['data'][index]['is_location_favourite'] == false
                            //     ? adfavUser.locationToFav(adtofavJson)
                            //     : adfavUser.locationUnToFav(remtofavJson);
                            //   },
                            //   child:userData['data'][index]['is_location_favourite'] == false
                            //   ? Image.asset(
                            //     AppImages.blueHeart, height: 20,
                            //   )
                            //   : Image.asset(AppImages.heart)
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  Widget googleMap(kInitialPosition) {
    return StatefulBuilder(builder: (context, newSetState) {
      return kInitialPosition != null
          ? Container(
              height: Get.height,
              child: GoogleMap(
                mapType: MapType.normal,
                onTap: (position) {},
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
                onMapCreated: (GoogleMapController controller) async {
                  _customInfoWindowController.googleMapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: kInitialPosition,
                  zoom: _zoom,
                ),
                markers: _markers.toSet(),
              ),
            )
          : Center(
              child: Text("noLoc".tr),
            );
    });
  }
}
