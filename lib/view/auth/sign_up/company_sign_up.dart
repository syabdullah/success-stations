import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/services_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:dio/dio.dart' as dio;
import 'package:success_stations/utils/app_headers.dart';

// ignore: unused_import
import 'package:success_stations/view/auth/sign_in.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:iqama_validator/iqama_validator.dart';

var finalIndex, shortCode;
var uploadedImage;
var lang;
// class CompanySignUp extends StatefulWidget {
DateTime? dateTime;
var dateFormate =
DateFormat("yyyy-MM-dd").format(DateTime.parse(dateTime.toString()));

class CompanySignUp extends StatefulWidget {
  final val;

  //  late String savedData;

  CompanySignUp({this.val});

  _CompanySignPageState createState() => _CompanySignPageState();
}

XFile? pickedFile;
final ImagePicker _picker = ImagePicker();

class _CompanySignPageState extends State<CompanySignUp> {
  var serText, serId;
  final regionIdByCountry = Get.put(ContryController());
  late String savedData;
  var tyming;
  var editImage;
  var counCode,
      counID,
      hintTextCountry,
      selectedCity,
      selectedCountry,
      selectedRegion,
      hintRegionText,
      hintcityText;
  List selectedValues = [];
  var servID;
  TextEditingController fulNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNUmberController = TextEditingController();
  TextEditingController iqamaController = TextEditingController();
  TextEditingController crController = TextEditingController();
  TextEditingController comNameController = TextEditingController();
  TextEditingController respController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  var passwrd, cnfPass;
  List selectedAnimals2 = [];
  List selectedAnimals5 = [];
  List selectedAnimals3 = [];
  late var serviccesDatta;
  final signUpCont = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  PhoneNumber companyCode = PhoneNumber(isoCode: '');
  GetStorage box = GetStorage();
  var number;
  var cNumber;
  var inputValuePhone;

  bool _isChecked = false;
  bool errorCheck = true;
  var type = 'Account Type';
  var serviceName, serviceId;
  var imageP;
  var image1;

  var v = 1;
  int textcolor = 0;
  var fileName;

  Future getImage() async {
    // await ApiHeaders().getData();
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image1 = pickedFile!.path;
        fileName = pickedFile!.path.split('/').last;
      } else {}
    });
    try {

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(pickedFile!.path,
            filename: fileName),
      });
      Get.find<AdPostingController>().uploadAdImage(formData);
      uploadedImage = Get.find<AdPostingController>().adUpload['name'];
    } catch (e) {}
  }

  List<GroupModel> _group = [
    GroupModel(
      text: "individual".tr,
      index: 1,
      image: Image.asset("assets/individual.png"),
    ),
    GroupModel(
      text: "Bussnise".tr,
      index: 2,
      image: Image.asset("assets/Bussnise.png"),
    ),
  ];
  List servicesdemo = [
    "flutter",
    "java",
    "reactjs",
    "Xcode",
  ];

  @override
  void initState() {
    super.initState();
    lang = box.read('lang_code');
    counCode = Get.arguments;
    inputValuePhone = counCode['short_code'];
    selectedCountry = counCode['id'];
    regionIdByCountry.getRegion(selectedCountry);
    print(".......$inputValuePhone");
    companyCode = PhoneNumber(isoCode: inputValuePhone);
    errorCheck = true;
    hintTextCountry = counCode['name'][lang];

    // image = box.read('user_image');
    // imageP = box.read('user_image_local');
  }

  companyUser() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var json = {
        "name": nameController.text,
        'email': emailController.text,
        'password': passwrd,
        "password_confirmation": cnfPass,
        "mobile": cNumber.toString(),
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "user_type": 4,
        "cr_number": crController.text,
        'company_name': comNameController.text,
        'service_ids[]': selectedAnimals2
      };
      signUpCont.companyAccountData(json);
    }
  }

  individualSignUp() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var individualJson = {
        "name": nameController.text,
        'email': emailController.text,
        'password': passwrd,
        "password_confirmation": cnfPass,
        "mobile": number.toString(),
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "date_of_birth": finalDate,
        "user_type": 3,
        'iqama_number': iqamaController.text,
        'service_ids[]': selectedAnimals2
      };
      signUpCont.individualAccountData(individualJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    // imageP = box.read('user_image_local').toString();
    // image = box.read('user_image');
    final space20 = SizedBox(height: getSize(Get.width * 0.02, context));
    final space10 = SizedBox(height: getSize(Get.width * 0.01, context));
    final space25 = SizedBox(height: getSize(Get.width * 0.025, context));
    final width10 = SizedBox(width: getSize(Get.width * 0.02, context));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.023),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    space20,
                    space20,
                    fullName(),
                    space25,
                    eMail(),
                    space25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        password(),
                        confirmPassword(),
                      ],
                    ),
                    space25,
                    mobile(),
                    space25,

                    // GetBuilder<ContryController>(
                    //   init: ContryController(),
                    //   builder:(val) {
                    //     return val.countryData != null && val.countryData['data']!=null && val.countryData['success'] == true  ?  country(val.countryData['data']):
                    //     Container();
                    //   } ,
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<ContryController>(
                          init: ContryController(),
                          builder: (val) {
                            return region(val.regionListdata);
                          },
                        ),
                        GetBuilder<ContryController>(
                          init: ContryController(),
                          builder: (val) {
                            return city(val.cityListData);
                          },
                        ),
                      ],
                    ),
                    space25,
                    radioalert(),
                    space25,
                    GetBuilder<ServicesController>(
                      init: ServicesController(),
                      builder: (val){
                        return services(val.servicesListdata, );
                      },
                    ),

                    // GetBuilder<ServicesController>(
                    //   init: ServicesController(),
                    //   builder: (val) {
                    //     return
                    //     services(
                    //       val.servicesListdata,
                    //     );
                    //   },
                    // ),
                    space25,
                    // v == 2 ? comName() : space10,
                    // v == 2
                    //     ? cR()
                    //     : v == 1
                    //         ? Container(
                    //             margin: EdgeInsets.only(bottom: 10),
                    //             child: Column(
                    //               children: [
                    //                 iqama(),
                    //               ],
                    //             ))
                    //         : space10,
                    // responsible(),
                    // space10,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       decoration:
                    //           BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    //       child: Checkbox(
                    //         activeColor: AppColors.whitedColor,
                    //         value: _isChecked,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _isChecked = value!;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     Text("terms".tr,
                    //         style: TextStyle(
                    //             fontFamily: 'Lato',
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.bold)),
                    //     Text("terms_condition".tr,
                    //         style: TextStyle(
                    //             fontFamily: 'Lato',
                    //             color: AppColors.whitedColor,
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.bold)),
                    //   ],
                    // ),
                    // space20,
                    // submitButton(
                    //     buttonText: 'sign_up_text'.tr,
                    //     bgcolor: AppColors.whitedColor,
                    //     textColor: AppColors.white,
                    //     fontSize: 18.0,
                    //     callback: _isChecked == true
                    //         ? v == 1
                    //             ? individualSignUp
                    //             : companyUser
                    //         : null),
                    // space20,
                    // Container(
                    //   height: 1,
                    //   color: Colors.grey,
                    // ),
                    //
                    // space20,
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed('/login');
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "have_account".tr,
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w300,
                    //             color: Colors.grey),
                    //       ),
                    //       Text(
                    //         "sign_in".tr,
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             color: AppColors.whitedColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // space20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {

                            getImage();
                          },
                          child: Container(
                            height: Get.height*0.15,
                            width: Get.width*0.26,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.outline,width: 1.5)
                            ),


                            child:

                            fileName != null
                                ? Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  height:Get.height*0.001,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.outline,width: 1.5),
                                      shape:BoxShape.circle
                                  ),
                                  child:CircleAvatar(
                                    radius: 20,
                                      backgroundImage:
                                      FileImage( File(image1),

                                      )


                                  )

                              ),
                            )


                                :Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                  height:Get.height*0.1,
                            decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.outline,width: 1.5),
                              shape:BoxShape.circle
                            ),
                                      child:Center(child: Text("Logo",style: TextStyle(fontWeight: FontWeight.bold)))

                                  ),
                                ),


                            // decoration: BoxDecoration(color: ),
                          ),
                        ),
                        aboutCompny(),


                      ],
                    ),
                    space25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: .9,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor:AppColors.whitedColor ,
                            ),
                            child: Checkbox(
                              activeColor: AppColors.whitedColor,

                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text('termsline'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontFamily: "andada",
                                  fontWeight: FontWeight.w600)),
                        ),
                        // Text("terms_condition".tr,
                        //     style: TextStyle(
                        //         fontFamily: 'Lato',
                        //         color: AppColors.black,
                        //         fontSize: 13,
                        //         fontWeight: FontWeight.bold)),
                      ],
                    ),
                    space20,
                    submitButton(
                        buttonText: 'sign_up'.tr,
                        bgcolor: AppColors.whitedColor,
                        textColor: AppColors.white,
                        fontSize: 18.0,
                        callback: _isChecked == true
                            ? v == 1
                            ? individualSignUp
                            : companyUser
                            : null),
                    space25,




                  ],
                ),
              ),
              Container(
                height: Get.height*0.08,
                margin: EdgeInsets.only( bottom:  Get.height*0.005,),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Divider(
                      color: Colors.black,
                    ),

                    Padding(
                      padding:  EdgeInsets.all(Get.height*0.004),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "have_account".tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Source_Sans_Pro",
                                fontSize: 17),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          GestureDetector(
                              onTap: () {

                                Get.toNamed('/login');

                              },
                              child: Text(
                                "sign_in".tr,
                                style: TextStyle(
                                  color:AppColors.whitedColor,
                                  fontFamily: "Source_Sans_Pro",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fullName() {
    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width / 19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width / 19),
        // padding: EdgeInsets.only(top: 10),
        isObscure: false,
        color: Colors.white,
        hintText: "full_name".tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
        validator: (value) {
          if (value.length == 0) {
            return "namereq".tr;
          } else
            return null;
        },
        errorText: '',
      ),
    );
  }

  Widget eMail() {
    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width,
      child: CustomTextFiled(
        isObscure: false,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width / 19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width / 19),
        hintText: "emails".tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        color: Colors.white,
        onChanged: (value) {},
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: emailController,
        validator: (val) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if (val.length == 0) {
            return 'enterEmail'.tr;
          } else if (!regExp.hasMatch(val)) {
            return "enterEmail".tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget mobile() {
    return Container(
      // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: AppColors.outline,width: 1.5)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(child: Container(height : 30,width:30,child: Image.network(counCode["flag"]["url"]))),
            ),
            Container(child: Center(child: Text('+ ${counCode["id"]}',style: TextStyle(color: Colors.grey),)),),
            Container(
              width: Get.width * 0.6,
              child: TextField(
                focusNode: FocusNode(),
                cursorColor: AppColors.whitedColor,
                autofocus: false,
                decoration : InputDecoration(
                  contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, bottom: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  // hintText: "mobilee".tr,
                  // hintStyle: TextStyle(
                  //     fontSize: lang == 'ar' ? 14 : 16,
                  //     color: AppColors.inputTextColor),
                ),
                // autoValidateMode: AutovalidateMode.onUserInteraction,
                // selectorTextStyle: TextStyle(color: Colors.black),
                // textFieldController: mobileController,
                // formatInput: true,
              ),
            ),
          ],
        ));

      // Container(
      // // margin: EdgeInsets.only(left: 20, right: 20),
      //   width: Get.width,
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       // borderRadius: BorderRadius.circular(5),
      //       border: Border.all(color: AppColors.outline,width: 1.5)),
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: InternationalPhoneNumberInput(
      //     focusNode: FocusNode(),
      //     cursorColor: AppColors.whitedColor,
      //     autoFocus: false,
      //     inputDecoration: InputDecoration(
      //       contentPadding: EdgeInsets.only(left: 10, bottom: 10),
      //       fillColor: Colors.white,
      //       filled: true,
      //       border: InputBorder.none,
      //       errorBorder: OutlineInputBorder(
      //         borderSide: BorderSide(color: Colors.red),
      //       ),
      //       focusedErrorBorder: OutlineInputBorder(
      //         borderSide: BorderSide(color: Colors.red),
      //       ),
      //       // hintText: "mobilee".tr,
      //       // hintStyle: TextStyle(
      //       //     fontSize: lang == 'ar' ? 14 : 16,
      //       //     color: AppColors.inputTextColor),
      //     ),
      //     onInputChanged: (PhoneNumber numberr) {
      //       number = numberr;
      //     },
      //     onInputValidated: (bool value) {},
      //     selectorConfig: SelectorConfig(
      //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      //     ),
      //     ignoreBlank: false,
      //     autoValidateMode: AutovalidateMode.onUserInteraction,
      //     selectorTextStyle: TextStyle(color: Colors.black),
      //     textFieldController: mobileNUmberController,
      //     formatInput: true,
      //     inputBorder: OutlineInputBorder(),
      //     onSaved: (PhoneNumber number) {},
      //     initialValue: companyCode,
      //   ));
  }

  var finalDate;

  Widget companyDob() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: TextFormField(
        focusNode: FocusNode(),
        validator: (val) {
          if (DateTime.parse(finalDate!).isAfter(DateTime.now())) {
            return 'dobb'.tr;
          }
          return null;
        },
        style: TextStyle(
            color: AppColors.inputTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          // fillColor: AppColors.inputColor,
          // filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),

          contentPadding:
          EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          hintText:
          finalDate == null ? 'date_of_birth'.tr : finalDate.toString(),
          hintStyle: TextStyle(
              fontSize: lang == 'ar' ? 12 : 14,
              color: AppColors.inputTextColor,
              fontWeight: FontWeight.normal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 3, 5),
                  // maxTime: DateTime.now(),
                  theme: DatePickerTheme(
                    headerColor: AppColors.whitedColor,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                        color: AppColors.whitedColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle: TextStyle(
                      color: Colors.white,
                      fontSize: lang == 'ar' ? 12 : 14,
                    ),
                    cancelStyle: TextStyle(
                      color: AppColors.whitedColor,
                      fontSize: lang == 'ar' ? 12 : 14,
                    ),
                  ),
                  onChanged: (date) {}, onConfirm: (date) {
                    setState(() {
                      dateTime = date;
                      finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
          ),
        ),
      ),
    );
  }

  Widget comName() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10, right: 10),
        isObscure: false,
        hintText: "company".tr,
        hintStyle: TextStyle(fontSize: 10, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: comNameController,
        onSaved: (String? newValue) {},
        validator: (value) {
          if (value.isEmpty) {
            return 'enterSomeText'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget country(List data) {
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
                  hint: Text(
                      hintTextCountry != null ? hintTextCountry : 'country'.tr,
                      style:
                      TextStyle(fontSize: 10, color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: data.map((coun) {
                    return DropdownMenuItem(
                        value: coun,
                        child: Text(
                          // coun['name'][lang]!=null ?coun['name'][lang] : ''
                          coun['name'][lang] != null
                              ? coun['name'][lang].toString()
                              : coun['name'][lang] == null
                              ? coun['name']['en'].toString()
                              : '',
                        ));
                  }).toList(),
                  onChanged: (val) {
                    var mapCountry;
                    setState(() {
                      mapCountry = val as Map;
                      hintTextCountry = mapCountry['name'][lang] != null
                          ? mapCountry['name'][lang].toString()
                          : mapCountry['name'][lang] == null
                          ? mapCountry['name']['en']
                          : '';
                      selectedCountry = mapCountry['id'];
                      regionIdByCountry.getRegion(selectedCountry);
                      hintRegionText = 'Region';
                      hintcityText = 'City';
                    });
                  },
                ))));
  }

  Widget region(List dataRegion) {
    return Container(
      // margin: lang == 'ar'
      //     ? EdgeInsets.only(
      //     right: 20, left: MediaQuery.of(context).size.width / 46)
      //     : EdgeInsets.only(
      //     left: 20, right: MediaQuery.of(context).size.width / 46),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(2.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(hintRegionText != null ? hintRegionText : "region".tr,
                      style:
                      TextStyle(fontSize: 14, color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: dataRegion.map((reg) {
                    return DropdownMenuItem(
                        value: reg,
                        child: Text(
                          reg['region'][lang] != null
                              ? reg['region'][lang].toString()
                              : reg['region'][lang] == null
                              ? reg['region']['en']
                              : "",
                        ));
                  }).toList(),
                  onChanged: (data) {
                    var mapRegion;
                    setState(() {
                      mapRegion = data as Map;
                      hintRegionText = mapRegion['region'][lang] != null
                          ? mapRegion['region'][lang].toString()
                          : mapRegion['region'][lang] == null
                          ? mapRegion['region']['en'].toString()
                          : '';
                      selectedRegion = data['id'];
                      regionIdByCountry.getCity(data['id']);
                    });
                  },
                ))));
  }

  Widget city(List citydata) {
    return Container(
      // margin:lang == 'ar'
      //     ?  EdgeInsets.only(left: 4):EdgeInsets.only(right: 4),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(2.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(hintcityText != null ? hintcityText : "city".tr,
                      style:
                      TextStyle(fontSize: 14, color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inputColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: citydata.map((citt) {
                    return DropdownMenuItem(
                        value: citt,
                        child: Text(citt['city'][lang] != null
                            ? citt['city'][lang]
                            : citt['city'][lang] == null
                            ? citt['city']['en'].toString()
                            : ''));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      var mapCity;
                      mapCity = value as Map;
                      hintcityText = mapCity['city'][lang] != null
                          ? mapCity['city'][lang].toString()
                          : mapCity['city'][lang] == null
                          ? mapCity['city']['en'].toString()
                          : '';
                      selectedCity = mapCity['id'];
                    });
                  },
                ))));
  }

  Widget services(List serviceName) {
    return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.01),
                    child: Text(
                      "services".tr,
                      style: TextStyle(
                        fontSize: 16,
                        color:Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              // space25,
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.outline,width: 1.5)),
                height: Get.height*0.13,
                width: double.infinity,
                child: Padding(
                  padding:  EdgeInsets.all(Get.height*0.008),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      childAspectRatio: Get.height*0.004 ,
                    ),
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: serviceName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: Get.height*0.04,
                        decoration: BoxDecoration(
                            border:
                            Border.all( color:AppColors.outline),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                              serviceName[index]['servics_name'],
                              style: TextStyle(color: Colors.grey),
                            )),
                      );
                    },
                  ),
                ),
              ),
            ]);
  }
  Widget aboutCompny() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.outline,width: 1.5)
        ),
        height: Get.height*0.15,
        width: Get.width * 0.68,
        // margin: EdgeInsets.symmetric(horizontal: Get.width*0.02),

        // isObscure: false,

        child: TextFormField(


          controller:aboutController ,
          maxLines: 5,

          // obscureText: passwordVisible,
          decoration: InputDecoration(
            contentPadding: lang == 'ar'
                ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19, top: MediaQuery.of(context).size.width/19)
                : EdgeInsets.only(left: MediaQuery.of(context).size.width/19, top: MediaQuery.of(context).size.width/19),

            hintText: ( "aboutsu".tr),
            hintStyle: TextStyle(
                fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),

            // labelStyle: TextStyle(color: AppColors.basicColor),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide:BorderSide(color:Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color:Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              //borderRadius: BorderRadius.circular(20.0),

              borderSide: BorderSide(color:Colors.transparent),
            ),
            errorText: '',
          ),
          validator: (value) {
            if (value!.length == 0) {
              return "aboutfield".tr;
            } else
              return null;
          },


          // errorText: '',
          // onSaved: (val) => email = TextEditingController(text: val),
        ));
  }

  Widget iqama() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10, right: 10),
        isObscure: false,
        hintText: "enter_iqama_number".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: iqamaController,
        validator: (value) {
          //   if( value.length  == 0){
          //     return 'iqama'.tr;
          //   }
          //   else if(IqamaValidator.validate(value) == false) {
          //     return "iqqamaNum".tr;
          //   }
          //  else return null;
        },
        errorText: '',
      ),
    );
  }

  Widget password() {
    return Container(
      // margin: lang == 'ar'
      //     ? EdgeInsets.only(
      //     right: 20, left: MediaQuery.of(context).size.width / 46)
      //     : EdgeInsets.only(
      //     left: 20, right: MediaQuery.of(context).size.width / 46),
      width: Get.width * 0.46,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure: true,
        color: Colors.white,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width / 19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width / 19),
        hintText: 'password'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 12 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          passwrd = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: passController,
        validator: (val) {
          if (val!.length == 0) {
            return 'EnterPassword'.tr;
          } else if (val != cnfPass) {
            return 'passwordNotMatch'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget confirmPassword() {
    return Container(
      // margin:
      // lang == 'ar' ? EdgeInsets.only(left: 4) : EdgeInsets.only(right: 4),
      width: Get.width * 0.46,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure: true,
        color: Colors.white,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width / 19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width / 19),
        hintText: 'confirmPassword'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 12 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          cnfPass = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: conPassController,
        validator: (val) {
          if (val!.length == 0) {
            return 'EnterPasswordConfirm'.tr;
          } else if (val != passwrd) {
            return 'passwordNotMatch'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget responsible() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10, right: 10),
        isObscure: false,
        hintText: "Responsible".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: respController,
        validator: (value) {
          if (value.length == 0) {
            return 'resp'.tr;
          } else
            return null;
        },
        errorText: '',
      ),
    );
  }

  Widget mobileNumber() {
    return Container(
        width: Get.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Color(0xFFEEEEEE))),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: InternationalPhoneNumberInput(
          focusNode: FocusNode(),
          cursorColor: AppColors.whitedColor,
          autoFocus: false,
          inputDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10, bottom: 10),
            fillColor: AppColors.inputColor,
            filled: true,
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: "mobilee".tr,
            hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
          ),
          onInputChanged: (PhoneNumber number) {
            cNumber = number;
          },
          onInputValidated: (bool value) {},
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: TextStyle(color: Colors.black),
          textFieldController: phoneController,
          formatInput: true,
          inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          onSaved: (PhoneNumber number) {},
          initialValue: companyCode,
        ));
  }

  Widget cR() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10, right: 10),
        isObscure: false,
        hintText: "crs".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: crController,
        validator: (value) {
          if (value.isEmpty) {
            return "crEn".tr;
          }
          return null;
        },
        errorText: '',
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
        fontWeight}) {
    return AppButton2(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  radioalert() {
    return Container(
      // margin:lang == 'ar'? EdgeInsets.only(right:20) :EdgeInsets.only(left:10,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.01),
              child: Text(
                "Account_type".tr,
                style: TextStyle(
                    fontSize: 16, color:Colors.black),
              )),

          Padding(
            padding: EdgeInsets.only(top: Get.height*0.008),
            child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.outline,width: 1.5)),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Radio(
                    //   value: t.index,
                    //   groupValue: v,
                    //   activeColor:AppColors.whitedColor,
                    //   onChanged: (int?value ) {
                    //     setState(() {
                    //       v = value!;
                    //     });
                    //   },
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          textcolor = 0;
                        });
                        Radio(
                          value: 1,
                          groupValue: v,
                          // activeColor:AppColors.whitedColor,
                          onChanged: (value) => setState(() => v = v),
                        );
                      },
                      child: Container(

                        child: Padding(
                          padding:  EdgeInsets.all(Get.height*0.004),
                          child: Row(
                            children: [
                              Padding(
                                  padding: lang == 'ar'
                                      ? EdgeInsets.only(top: Get.height*0.008,bottom: Get.height*0.008,
                                      left: Get.height*0.018,right: Get.height*0.008)
                                      : EdgeInsets.only(top: Get.height*0.008,bottom: Get.height*0.008,
                                      left: Get.height*0.008,right: Get.height*0.018),
                                  child: Image.asset("assets/individual.png")),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "individual".tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: textcolor == 0
                                        ? AppColors.appBarBackGroundColor
                                        : AppColors.inputTextColor,
                                    decoration: textcolor == 0
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationThickness: 2,
                                    fontWeight: textcolor == 0
                                        ? FontWeight.w700
                                        : FontWeight.w200),
                              ),
                            ],
                          ),
                        ),

                      ),
                    ),
                    Container(
                      width: Get.width*0.005,
                      decoration: BoxDecoration(
                          color: AppColors.outline

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          textcolor = 1;
                        });
                        Radio(
                          value: 2,
                          groupValue: v,
                          // activeColor:AppColors.whitedColor,
                          onChanged: (value) => setState(() => v = v),
                        );
                      },
                      child: Container(

                        // width: MediaQuery.of(context).size.width * 0.46,
                        child: Row(
                          children: [
                            Text(
                              "business".tr,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: textcolor == 1
                                      ?  AppColors.appBarBackGroundColor
                                      :  AppColors.inputTextColor,
                                  decoration: textcolor == 1
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  decorationThickness: 2,
                                  fontWeight: textcolor == 1
                                      ? FontWeight.w700
                                      : FontWeight.w200),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Padding(
                              padding: lang == 'ar'
                                  ? EdgeInsets.only(top: Get.height*0.008,bottom: Get.height*0.008,
                                  left: Get.height*0.008,right: Get.height*0.018)
                                  : EdgeInsets.only(top: Get.height*0.008,bottom: Get.height*0.008,
                                  left: Get.height*0.018,right: Get.height*0.008),
                              child: Image.asset("assets/Bussnise.png"),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(color: AppColors.outline)),
                      ),
                    )
                    // Container(
                    // child: Text(t.text,style: TextStyle(fontSize: 12,color: Colors.grey),),)
                  ],
                )
            ),
          ),



        ],
      ),
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class GroupModel {
  String text;
  int index;
  Image image;

  GroupModel({
    required this.text,
    required this.index,
    required this.image,
  });
}
