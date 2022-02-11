import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_field.dart';

class FriendsDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  FriendsDrawer({Key? key, required this.globalKey}) : super(key: key);
  @override
  _FriendsDrawerState createState() => _FriendsDrawerState();
}

class _FriendsDrawerState extends State<FriendsDrawer> {
  var lang,
      countryHint,
      regionHint,
      countryID,
      hinText,
      mapuni,
      universitySelected,
      hinCity,
      cityMapping,
      citySelected,
      collegeID,
      mapClg,
      hintClg;
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  final callingFreindController = Get.put(FriendsController());
  GetStorage box = GetStorage();
  var searchText;
  TextEditingController txtSearchField = TextEditingController();

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
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      controller: txtSearchField,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.015),
                        isCollapsed: true,
                        hintText: "search".tr,
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
                      top: Get.height * 0.01,
                      left: Get.height * 0.01,
                      right: Get.height * 0.01),
                  child: Text("locationTab".tr,
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return country(val.countryListdata);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return region(val.regionListdata);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return city(val.cityAll);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                  margin: EdgeInsets.only(
                      top: Get.height * 0.01,
                      left: Get.height * 0.01,
                      right: Get.height * 0.01),
                  child: Text("education".tr,
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return college(val.listCollegeData);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<UniversityController>(
                init: UniversityController(),
                builder: (val) {
                  return university(val.dataUni);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              GetBuilder<UniversityController>(
                init: UniversityController(),
                builder: (val) {
                  return university(val.dataUni);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Align(
                heightFactor: 2.0,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // ignore: deprecated_member_use
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.border),
                            height: Get.height * 0.045,
                            width: Get.width * 0.25,
                            child: Center(
                                child: Text("cancel".tr,
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Container(
                        // ignore: deprecated_member_use
                        child: GestureDetector(
                      onTap: () {
                        result();
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  result() {
    var json = {
      'name': nameController.text,
      'city': citySelected,
      // 'degree': degreeController.text,
      'country': countryID,
      'university': universitySelected,
      'college': collegeID,
    };
    print(" friends suggestion .....$json");
    callingFreindController.searchFriendControl(json);
  }

  Widget name() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 20),
        isObscure: false,
        hintText: "nameph".tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor:
            lang == 'ar' ? AppColors.inputTextColor : AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
        onSaved: (newValue) {},
        validator: (value) {},
        errorText: '',
      ),
    );
  }

  Widget country(List data) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                color: AppColors.inputColor,
                border: Border.all(color: AppColors.darkgrey),
                borderRadius: BorderRadius.circular(5.0)),
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  hint: Text(countryHint != null ? countryHint : 'country'.tr,
                      style: TextStyle(
                          fontSize: 18, color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: data.map((coun) {
                    print("printed country code...±${coun['name']['en']}");
                    return DropdownMenuItem(
                        value: coun,
                        child: Text(coun['name'][lang] != null
                            ? coun['name'][lang]
                            : coun['name'][lang] == null
                                ? coun['name']['en']
                                : coun['name']['en'] == "  "
                                    ? coun['name']['ar']
                                    : coun['name']['ar'] == "  "
                                        ? coun['name']['en']
                                        : ''));
                  }).toList(),
                  onChanged: (val) {
                    var mapCountry;
                    setState(() {
                      mapCountry = val as Map;
                      countryHint = mapCountry['name'][lang] != null
                          ? mapCountry['name'][lang]
                          : mapCountry['name'][lang] == null
                              ? mapCountry['name']['en']
                              : '';
                      countryID = mapCountry['id'];
                    });
                  },
                )))),
      ],
    );
  }

  Widget region(List data) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                color: AppColors.inputColor,
                border: Border.all(color: AppColors.darkgrey),
                borderRadius: BorderRadius.circular(5.0)),
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  hint: Text(regionHint != null ? regionHint : 'region'.tr,
                      style: TextStyle(
                          fontSize: 18, color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: data.map((coun) {
                    print("printed country code...±${coun['name']['en']}");
                    return DropdownMenuItem(
                        value: coun,
                        child: Text(coun['name'][lang] != null
                            ? coun['name'][lang]
                            : coun['name'][lang] == null
                                ? coun['name']['en']
                                : coun['name']['en'] == "  "
                                    ? coun['name']['ar']
                                    : coun['name']['ar'] == "  "
                                        ? coun['name']['en']
                                        : ''));
                  }).toList(),
                  onChanged: (val) {
                    var mapCountry;
                    setState(() {
                      mapCountry = val as Map;
                      regionHint = mapCountry['name'][lang] != null
                          ? mapCountry['name'][lang]
                          : mapCountry['name'][lang] == null
                              ? mapCountry['name']['en']
                              : '';
                      countryID = mapCountry['id'];
                    });
                  },
                )))),
      ],
    );
  }

  Widget college(List data) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.darkgrey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              hint: Text(hintClg != null ? hintClg : "collegesu".tr,
                  style: TextStyle(
                      fontSize: lang == 'ar' ? 18 : 18,
                      color: AppColors.inputTextColor)),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: data.map((coll) {
                return DropdownMenuItem(
                    value: coll,
                    child: Text(coll['college'][lang] != null
                        ? coll['college'][lang]
                        : coll['college'][lang] == null
                            ? coll['college']['en']
                            : coll['college']['en'] == "  "
                                ? coll['college']['ar']
                                : coll['college']['ar'] == "  "
                                    ? coll['college']['en']
                                    : ''));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  mapClg = value as Map;
                  hintClg = mapClg['college'][lang] != null
                      ? mapClg['college'][lang]
                      : mapClg['college'][lang] == null
                          ? mapClg['college']['en']
                          : '';
                  collegeID = mapClg['id'];
                });
              },
            ))));
  }

  Widget university(List data) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.darkgrey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              hint: Text(hinText != null ? hinText : "universitysu".tr,
                  style: TextStyle(
                      fontSize: lang == 'ar' ? 14 : 16,
                      color: AppColors.inputTextColor)),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: data.map((uni) {
                return DropdownMenuItem(
                    value: uni,
                    child: Text(uni['name'][lang] != null
                        ? uni['name'][lang]
                        : uni['name'][lang] == null
                            ? uni['name']['en']
                            : ''));
              }).toList(),
              onChanged: (dataa) {
                setState(() {
                  mapuni = dataa as Map;
                  hinText = mapuni['name'][lang] != null
                      ? mapuni['name'][lang]
                      : mapuni['name'][lang] == null
                          ? mapuni['name']['en']
                          : '';
                  universitySelected = mapuni['id'];
                });
              },
            ))));
  }

  Widget city(List data) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.darkgrey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              hint: Text(hinCity != null ? hinCity : "city".tr,
                  style: TextStyle(
                      fontSize: lang == 'ar' ? 14 : 16,
                      color: AppColors.inputTextColor)),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: data.map((city) {
                return DropdownMenuItem(
                    value: city,
                    child: Text(
                      city['city'][lang] != null
                          ? city['city'][lang].toString()
                          : city['city'][lang] == null
                              ? city['city']['en'].toString()
                              : '',
                    ));
              }).toList(),
              onChanged: (dataa) {
                setState(() {
                  cityMapping = dataa as Map;
                  hinCity = cityMapping['city'][lang] != null
                      ? cityMapping['city'][lang]
                      : cityMapping['city'][lang] == null
                          ? cityMapping['city']['en']
                          : "";
                  citySelected = cityMapping['id'];
                });
              },
            ))));
  }

  Widget degree() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomTextFiled(
          contentPadding: lang == 'ar'
              ? EdgeInsets.only(right: 10)
              : EdgeInsets.only(left: 20),
          isObscure: false,
          hintText: "degreesu".tr,
          hintStyle: TextStyle(
              fontSize: lang == 'ar' ? 14 : 16,
              color: AppColors.inputTextColor),
          hintColor: lang == 'ar'
              ? AppColors.inputTextColor
              : AppColors.inputTextColor,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          textController: degreeController,
          onSaved: (newValue) {},
          validator: (value) {},
          errorText: '',
        ));
  }

  Widget semester() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10),
        isObscure: false,
        hintText: "semester".tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor:
            lang == 'ar' ? AppColors.inputTextColor : AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: semesterController,
        onSaved: (newValue) {},
        validator: (value) {},
        errorText: '',
      ),
    );
  }
}

class CatagaryModel {
  final id;
  final name;
  CatagaryModel(this.id, this.name);
}
