// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:math' as math; // import this
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/styling/app_bar.dart';

import 'package:success_stations/styling/colors.dart';

class FriendsFilter extends StatefulWidget {
  const FriendsFilter({Key? key}) : super(key: key);

  @override
  _FriendsFilterState createState() => _FriendsFilterState();
}

class _FriendsFilterState extends State<FriendsFilter> {
  late List<bool> _isChecked;
  RangeValues _currentRangeValues = const RangeValues(1, 10000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> itemsList = [
    "New".tr,
    "used".tr,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: Get.height * 0.04),
                  height: Get.height * 0.06,
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border, width: 2)),
                  child: Center(
                    child: Text("filter".tr,
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.height * 0.01, vertical: Get.height * 0.02),
                child: Center(
                  child: TextField(
                      decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.04,
                        vertical: Get.height * 0.015),
                    isCollapsed: true,
                    hintText: "Search...",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.border, width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.border, width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                  )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: Get.height * 0.02,
                      left: Get.height * 0.02,
                      right: Get.height * 0.02),
                  child: Text("category".tr,
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
              GetBuilder<CategoryController>(
                init: CategoryController(),
                builder: (data) {
                  return data.isLoading == true
                      ? Container(
                          height: Get.height / 10,
                        )
                      : data.havingAddsList != null &&
                              data.havingAddsList['data'] != null
                          ? Container(
                              height: Get.height / 3,
                              width: Get.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.havingAddsList['data'].length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    _isChecked = List<bool>.filled(
                                        data.havingAddsList['data'].length,
                                        false);
                                    if (filteredIndex == index) {
                                      _isChecked[index] = true;
                                    }

                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColors.border),
                                            value: _isChecked[index],
                                            onChanged: (val) {
                                              setState(() {
                                                _isChecked[index] = val!;

                                                filteredIndex = index;
                                                catFilteredID =
                                                    data.havingAddsList['data']
                                                        [index]['id'];
                                              });
                                            }),
                                        Text(
                                          data.havingAddsList['data'][index]
                                                      ['category'][lang] !=
                                                  null
                                              ? data.havingAddsList['data']
                                                      [index]['category'][lang]
                                                  .toString()
                                              : data.havingAddsList['data']
                                                              [index]
                                                          ['category'][lang] ==
                                                      null
                                                  ? data.havingAddsList['data']
                                                          [index]['category']
                                                          ['en']
                                                      .toString()
                                                  : '',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: bottomSheetCategory == index
                                                ? AppColors.border
                                                : AppColors.border,
                                            fontSize: Get.height < 700
                                                ? Get.height * 0.018
                                                : Get.height * 0.015,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
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
                  margin: EdgeInsets.only(
                      top: Get.height * 0.02,
                      left: Get.height * 0.02,
                      right: Get.height * 0.02),
                  child: Text("condition".tr,
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Get.height * 0.02, right: Get.height * 0.02),
                height: Get.height * 0.045,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            onSelected(index);
                            statusFiltered = itemsList[index];
                          });
                        },
                        child: Container(
                          margin: lang == 'en'
                              ? EdgeInsets.only(left: 4)
                              : EdgeInsets.only(right: 4),
                          width: Get.width / 5,
                          height: Get.height / 3,
                          decoration: BoxDecoration(
                            // ignore: unnecessary_null_comparison
                            color: slctedInd != null && slctedInd == index
                                ? AppColors.border
                                : Colors.white,
                            //Colors.blue[100],
                            border: Border.all(
                              color: AppColors.border,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(itemsList[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: slctedInd == index
                                        ? AppColors.white
                                        : AppColors.black,
                                  )),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: Get.height * 0.03,
                      left: Get.height * 0.02,
                      right: Get.height * 0.02),
                  child: Text('price'.tr,
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
              Container(
                margin: EdgeInsets.only(
                    top: Get.height * 0.01,
                    left: Get.height * 0.03,
                    right: Get.height * 0.04),
                child: Text("SAR0 - SAR 10000 ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2F4199),
                        fontWeight: FontWeight.normal)),
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
                      start = _currentRangeValues.start.round().toString();
                      end = _currentRangeValues.end.round().toString();
                    });
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // ignore: deprecated_member_use
                    child: GestureDetector(
                      onTap: () {
                        array.clear();
                        cityArray.clear();
                        locationName = null;
                        selectedService = null;
                        Get.back();
                        Get.find<LocationController>().getAllLocationToDB();
                        // Get.to(SignIn());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.border),
                          height: Get.height * 0.045,
                          width: Get.width * 0.25,
                          child: Center(
                              child: Text("reset".tr,
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.02),
                  Container(
                      // ignore: deprecated_member_use
                      child: GestureDetector(
                    onTap: () {
                      var cityFinalData;
                      if (decideRouter == 'city' || decideRouter == 'name') {
                        if (cityArray.length != 0) {
                          var cityFinal = cityArray.toString();
                          cityFinalData =
                              cityFinal.substring(1, cityFinal.length - 1);
                        } else {
                          cityFinalData = null;
                        }
                        Get.find<LocationController>()
                            .getAllLocationByCity(cityFinalData, locationName);
                      } else if (decideRouter == 'near') {
                        Get.find<LocationController>().getAllLocationNearBy(
                            end, position.latitude, position.longitude);
                      }
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF2F4199)),
                        height: Get.height * 0.045,
                        width: Get.width * 0.25,
                        child: Center(
                            child: Text("apply".tr,
                                style: TextStyle(color: Colors.white)))),
                  )),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
