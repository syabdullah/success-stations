import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_field.dart';

class FriendFilter extends StatefulWidget {
  const FriendFilter({Key? key}) : super(key: key);

  @override
  _FriendFilterState createState() => _FriendFilterState();
}

class _FriendFilterState extends State<FriendFilter> {
  var lang,
      countryHint,
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

  @override
  void initState() {
    lang = box.read('lang_code');
    super.initState();
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

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return 
        Scaffold(
          body: Container(
            margin: EdgeInsets.only(top:02),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
              )
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  Container(
                        margin: lang == 'en'
                        ? EdgeInsets.only(top: 8, left: 8)
                        : EdgeInsets.only(top: 8, right: 8),
                        child: Text("filter".tr,
                          style: TextStyle(
                            fontSize: 20, color: Colors.black
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    name(),
                    SizedBox(height: 5),
                    degree(),
                    SizedBox(height: 5),
                    GetBuilder<ContryController>(
                      init: ContryController(),
                      builder:(val) {
                        return country(val.countryListdata);
                      } ,
                    ),
                    SizedBox(height: 5),
                    GetBuilder<ContryController>(
                      init: ContryController(),
                      builder:(val) {
                        return city(val.cityAll);
                      } ,
                    ),
                    SizedBox(height: 5),
                    GetBuilder<ContryController>(
                      init: ContryController(),
                      builder:(val) {
                        return college(val.listCollegeData);
                      } ,
                    ),
                    SizedBox(height:5),
                    GetBuilder<UniversityController>(
                      init: UniversityController(),
                      builder: (val){
                        return  university(val.dataUni);
                      },
                    ),
                    SizedBox(height: 15),
                    buttons()
                  ]
                ),
              ],
            ),

    ),
        );
  }
=======
    return Container(
      margin: EdgeInsets.only(top: 02),
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0))),
      child: ListView(
        children: [
          Drawer(
            child: Column(children: [
              // SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin: lang == 'en'
                      ? EdgeInsets.only(top: 8, left: 8)
                      : EdgeInsets.only(top: 8, right: 8),
                  child: Text("filter".tr,
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
              SizedBox(height: 5),
              name(),
              SizedBox(height: 5),
              degree(),
              SizedBox(height: 5),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return country(val.countryListdata);
                },
              ),
              SizedBox(height: 5),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return city(val.cityAll);
                },
              ),
              SizedBox(height: 5),
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val) {
                  return college(val.listCollegeData);
                },
              ),
              SizedBox(height: 5),
              GetBuilder<UniversityController>(
                init: UniversityController(),
                builder: (val) {
                  return university(val.dataUni);
                },
              ),
              SizedBox(height: 15),
              buttons()
            ]),
          )
        ],
      ),
    );
    }
>>>>>>> 4c2513ae890c80474506b55adbf415b04be150ab

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
            margin: EdgeInsets.only(left: 20, right: 20),
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                color: AppColors.inputColor,
                border: Border.all(color: AppColors.outline),
                borderRadius: BorderRadius.circular(2.0)),
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

  Widget college(List data) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(2.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              hint: Text(hintClg != null ? hintClg : "collegesu".tr,
                  style: TextStyle(
                      fontSize: lang == 'ar' ? 14 : 16,
                      color: AppColors.inputTextColor)),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: data.map((coll) {
                return DropdownMenuItem(
                    value: coll,
                    child: Text(
                      coll['college'][lang] != null
                          ? coll['college'][lang]
                          : coll['college'][lang] == null
                              ? coll['college']['en']
                              : '',
                    ));
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
        margin: EdgeInsets.only(left: 20, right: 20),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(2.0)),
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
        margin: EdgeInsets.only(left: 20, right: 20),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(2.0)),
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Get.height * 0.05,
          margin: lang == 'en'
              ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
              : EdgeInsets.only(top: 8, bottom: 6, right: 8),
          width: Get.width / 3,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: GestureDetector(
              child: Center(
                  child: Text("cancel".tr,
                      style: TextStyle(color: AppColors.inputTextColor))),
              onTap: () {
                Get.back();
              }),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            result();
            Get.back();
          },
          child: Container(
            height: Get.height * 0.05,
            margin: lang == 'en'
                ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
                : EdgeInsets.only(top: 8, bottom: 6, right: 8),
            width: Get.width / 3,
            decoration: BoxDecoration(
                color: AppColors.appBarBackGroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
                child: Text(
              "apply".tr,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
