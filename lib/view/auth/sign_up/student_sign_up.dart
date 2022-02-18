import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/college_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:dio/dio.dart' as dio;

DateTime? dateTime;
var dateFormate =
DateFormat("yyyy-MM-dd").format(DateTime.parse(dateTime.toString()));
// var str = JSON.encode(dt, toEncodable: myEncode);

class StudentSignUp extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<StudentSignUp> {
  var finalDate;
  final countryPut = Get.put(ContryController());
  var selectedCountry,
      statusSelected,
      selectCountry,
      selectedCity,
      selectedRegion,
      selectedUniversity,
      selectedCollege,
      selectCollege,
      mapuni,
      mapClgSleceted,
      hintTextCountry,
      hintRegionText,
      hintUniText,
      hintcityText,
      hintClgText;

  late String firstName, emailSaved, mobileSaved, dobSaved;
  var arrayDataDegree = ['Diploma, Bachelor, Masrter, Doctorate'];
  bool passwordVisible = true;
  bool isvisible = true;

  final formKey = GlobalKey<FormState>();
  GetStorage box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController conPassController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  String initialCountry = 'PK';
  var number;
  var passwordValue, confirmPasswordValue;

  PhoneNumber tttt = PhoneNumber(isoCode: '');

  bool _isChecked = false;
  var myTest;
  var countryIdGet, shortCodeAdd, confirmDate;

  final signUpCont = Get.put(SignUpController());
  var lang;

  XFile? pickedFile;
  final ImagePicker _picker = ImagePicker();
  var image1;
  var fileName;
  var uploadedImage;

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



  @override
  void initState() {
    lang = box.read('lang_code');
    countryPut.getCountries();
    countryIdGet = Get.arguments;
    print("argumentss.........$countryIdGet");
    myTest = countryIdGet['short_code'];
    tttt = PhoneNumber(isoCode: myTest);
    hintTextCountry = countryIdGet['name'][lang];
    selectedCountry = countryIdGet['id'];
    countryPut.getRegion(selectedCountry);
    super.initState();
  }

  void createUser() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var json = {
        "name": nameController.text,
        'email': emailController.text,
        'password': passwordValue,
        "password_confirmation": confirmPasswordValue,
        "mobile": number.toString(),
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "user_type": 2,
        "date_of_birth": finalDate,
        "college_id": selectedCollege,
        'university_id': selectedUniversity,
        'about': aboutController.text,
        'degree': statusSelected
      };
      signUpCont.createAccountData(json);
    }
  }

  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(Get.width*0.02, context));
    final space10 = SizedBox(height: getSize(Get.width*0.01, context));
    final space25 = SizedBox(height: getSize(Get.width*0.025, context));
    final width10 = SizedBox(width: getSize(Get.width*0.02, context));
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar:  singIn(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:Get.width*0.023),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    space20,
                    space20,

                    fullNameStudent(),
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
                    // space10,
                    // studentdob(),
                    // space10,
                    // GetBuilder<ContryController>(
                    //   init: ContryController(),
                    //   builder: (val) {
                    //     return country(val.countryListdata);
                    //   },
                    // ),
                    space25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<ContryController>(
                          init: ContryController(),
                          builder: (val) {
                            return region(val.regionListdata);
                          },
                        ),
                        SizedBox(width: 0.5,),
                        GetBuilder<ContryController>(
                          init: ContryController(),
                          builder: (val) {
                            return city(val.cityListData);
                          },
                        ),
                      ],
                    ),
                    space25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<UniversityController>(
                          init: UniversityController(),
                          builder: (val) {
                            return university(val.dataUni);
                          },
                        ),
                        SizedBox(
                          width: 1.8,
                        ),
                        GetBuilder<CollegeController>(
                          init: CollegeController(),
                          builder: (val) {
                            return college(val.listCollegeData);
                          },
                        ),
                      ],
                    ),
                    space25,
                    degree(),
                    space25,
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


                            child:  GestureDetector(

                              child: fileName != null
                                  ?Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                        FileImage( File(image1),

                                        )


                                    ),
                                  )
                                  :Image.asset(AppImages.man,height: Get.height*0.1,),
                            ),


                            // decoration: BoxDecoration(color: ),
                          ),
                        ),
                        about(),


                      ],
                    ),
                    space25,
                    space20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: .9,
                          child: new Checkbox(
                            activeColor: AppColors.whitedColor,
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                        ),
                        Text('termsline'.tr,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: "andada",
                                fontWeight: FontWeight.w600
                            )),
                        // Text("terms_condition".tr,
                        //     style: TextStyle(
                        //         fontFamily: 'Lato',
                        //         color: AppColors.whitedColor,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.bold)),
                      ],
                    ),
                    space20,
                    submitButton(
                        bgcolor: AppColors.whitedColor,
                        textColor: AppColors.white,
                        buttonText: "sign_up".tr,
                        fontSize: 16.0,
                        fontFamily: "andada",
                        callback: _isChecked == true ? createUser : null),
                    space20,



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
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget fullNameStudent() {
    return Container(
      // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
      width: Get.width,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        isObscure: false,
        color: Colors.white,
        hintText: 'full_name'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor:
        lang == 'ar' ? AppColors.inputTextColor : AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
        onSaved: (newValue) {},
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

  Widget semester() {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        keyboardType: TextInputType.number,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19, top: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        isObscure: false,
        hintText: 'semestersu'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14: 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: semesterController,
        onSaved: (newValue) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'enteringText'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget address() {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
      width: Get.width * 0.9,

      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        isObscure: false,
        hintText: 'address'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: addressController,
        onSaved: (newValue) {},
        validator: (value) {
          if (value.length == 0) {
            return "adressField".tr;
          } else
            return null;
        },
        errorText: '',
      ),
    );
  }


  Widget about() {
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

            hintText: ('about'.tr),
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

  Widget degree() {
    return Container(
      // margin: lang == 'ar' ? EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19):EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
        width: Get.width ,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(0.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: Container(
                  margin: EdgeInsets.only(right: 2),
                  child: DropdownButton(
                    hint: Text(
                        statusSelected == null ? 'degreesu'.tr : statusSelected,
                        style: TextStyle(
                            fontSize: lang == 'ar' ? 14 : 14,
                            color: AppColors.inputTextColor)),
                    dropdownColor: AppColors.inPutFieldColor,
                    icon: Icon(Icons.arrow_drop_down),
                    items: <String>[
                      'diploma'.tr,
                      'bachelor\'s'.tr,
                      'master\'s'.tr,
                      'doctorate'.tr
                    ].map((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.grey[800]),
                          ));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        statusSelected = val;
                      });
                    },
                  ),
                ))));
  }

  Widget eMail() {
    return Container(
      // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
      width: Get.width ,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        isObscure: false,
        color: Colors.white,
        hintText: 'emailsS'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
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
            return "email_Valid".tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget password() {
    return Container(
      // margin: lang == 'ar'
      //     ? EdgeInsets.only(
      //         right: MediaQuery.of(context).size.width/19, left: MediaQuery.of(context).size.width / 46)
      //     : EdgeInsets.only(
      //         left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width / 46),
      width: Get.width * 0.46,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure: true,
        color: Colors.white,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        hintText: 'password'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14 : 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          passwordValue = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: passController,
        validator: (val) {
          if (val!.length == 0) {
            return 'EnterPassword'.tr;
          } else if (val != confirmPasswordValue) {
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
      //     lang == 'ar' ? EdgeInsets.only(left: MediaQuery.of(context).size.width/19) : EdgeInsets.only(right: MediaQuery.of(context).size.width/19),
      width: Get.width * 0.46,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure: true,
        color: Colors.white,
        contentPadding: lang == 'ar'
            ? EdgeInsets.only(right: MediaQuery.of(context).size.width/19)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width/19),
        hintText: 'confirmPassword'.tr,
        hintStyle: TextStyle(
            fontSize: lang == 'ar' ? 14: 14, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          confirmPasswordValue = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: conPassController,
        validator: (val) {
          if (val!.length == 0) {
            return 'EnterPasswordConfirm'.tr;
          } else if (val != passwordValue) {
            return 'passwordNotMatch'.tr;
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: InternationalPhoneNumberInput(
          focusNode: FocusNode(),
          cursorColor: AppColors.whitedColor,
          autoFocus: false,
          inputDecoration: InputDecoration(
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
          onInputChanged: (PhoneNumber numberr) {
            number = numberr;
          },
          onInputValidated: (bool value) {},
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: TextStyle(color: Colors.black),
          textFieldController: mobileController,
          formatInput: true,
          inputBorder: OutlineInputBorder(),
          onSaved: (PhoneNumber number) {},
          initialValue: tttt,
        ));
  }

  Widget studentdob() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
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
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          // fillColor: AppColors.inputColor,
          // filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),

          contentPadding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width/19, top: MediaQuery.of(context).size.width/19, bottom: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
          hintText:
          finalDate == null ? 'date_of_birth'.tr : finalDate.toString(),
          hintStyle: TextStyle(
              fontSize: lang == 'ar' ? 14 : 16,
              color: AppColors.inputTextColor,
              fontWeight: FontWeight.normal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          fillColor: Colors.white,
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
                      fontSize: lang == 'ar' ? 14 : 16,
                    ),
                    cancelStyle: TextStyle(
                      color: AppColors.whitedColor,
                      fontSize: lang == 'ar' ? 14 : 16,
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

  Widget country(List data) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width/19),
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.outline),
                borderRadius: BorderRadius.circular(0.0)),
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                          hintTextCountry != null ? hintTextCountry : 'country'.tr,
                          style: TextStyle(
                              fontSize: 10, color: AppColors.inputTextColor)),
                      dropdownColor: AppColors.inPutFieldColor,
                      icon: Icon(Icons.arrow_drop_down),
                      items: data.map((coun) {
                        return DropdownMenuItem(
                            value: coun,
                            child: Text(coun['name'][lang] != null
                                ? coun['name'][lang].toString()
                                : coun['name']['ar'] == null
                                ? coun['name']['en'].toString()
                                : coun['name']['en'] == null
                                ? coun['name']['ar'].toString()
                                : ''));
                      }).toList(),
                      onChanged: (val) {
                        var mapCountry;
                        setState(() {
                          mapCountry = val as Map;
                          hintTextCountry = mapCountry['name'][lang] != null
                              ? mapCountry['name'][lang].toString()
                              : mapCountry['name'][lang] == null
                              ? mapCountry['name']['en'].toString()
                              : mapCountry['name']['en'] == null
                              ? mapCountry['name']['ar']
                              : mapCountry['name']['ar'] == null
                              ? mapCountry['name']['en']
                              : '';
                          selectedCountry = mapCountry['id'];
                          countryPut.getRegion(selectedCountry);
                        });
                      },
                    )))),
      ],
    );
  }

  Widget region(List dataRegion) {
    return Container(
      // margin: lang == 'ar' ?EdgeInsets.only(
      //     right: MediaQuery.of(context).size.width/20, left: MediaQuery.of(context).size.width / 46):EdgeInsets.only(
      //     left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width / 46),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(0.0)),
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
                              : reg['region']['en'] == null
                              ? reg['region']['ar'].toString()
                              : reg['region']['ar'] == null
                              ? reg['region']['en'].toString()
                              : '',
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
                          : mapRegion['region']['en'] == null
                          ? mapRegion['region']['ar']
                          : mapRegion['region']['ar'] == null
                          ? mapRegion['region']['en']
                          : '';
                      selectedRegion = data['id'];
                      countryPut.getCity(data['id']);
                    });
                  },
                ))));
  }

  Widget city(List citydata) {
    return Container(
      // margin:  lang == 'ar' ?EdgeInsets.only(left: 4):EdgeInsets.only(right: 4),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(0.0)),
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
                            ? citt['city'][lang].toString()
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


                      // selectedCity = mapCity['id'];
                      // selectedRegion = data['id'];
                      // UniversityController().getUniversities(selectedCity);
                      // countryPut.getCity(selectedRegion);
                    });
                  },
                ))));
  }

  Widget university(List daattta) {
    return Container(
      // margin: lang == 'ar' ?EdgeInsets.only(
      //     right: MediaQuery.of(context).size.width/20, left: MediaQuery.of(context).size.width / 46):EdgeInsets.only(
      //     left: MediaQuery.of(context).size.width/19, right: MediaQuery.of(context).size.width / 46),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(0.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(hintUniText != null ? hintUniText : "universitysu".tr,
                      style: TextStyle(
                          fontSize: lang == 'ar' ? 14: 14,
                          color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: daattta.map((uni) {
                    return DropdownMenuItem(
                        value: uni,
                        child: Text(uni['name'][lang] != null
                            ? uni['name'][lang].toString()
                            : uni['name'][lang] == null
                            ? uni['name']['en'].toString()
                            : ''));
                  }).toList(),
                  onChanged: (dataa) {
                    setState(() {
                      mapuni = dataa as Map;
                      hintUniText = mapuni['name'][lang] != null
                          ? mapuni['name'][lang].toString()
                          : mapuni['name'][lang] == null
                          ? mapuni['name']['en'].toString()
                          : '';
                      selectedUniversity = mapuni['id'];
                    });
                  },
                ))));
  }

  Widget college(List collegeData) {
    return Container(
      // margin:  lang == 'ar' ?EdgeInsets.only(left: 4):EdgeInsets.only(right: 4),
        width: Get.width * 0.46,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline,width: 1.5),
            borderRadius: BorderRadius.circular(0.0)),
        child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(hintClgText != null ? hintClgText : "collegesu".tr,
                      style: TextStyle(
                          fontSize: lang == 'ar' ? 14 : 14,
                          color: AppColors.inputTextColor)),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items: collegeData.map((coll) {
                    return DropdownMenuItem(
                        value: coll,
                        child: Text(
                          coll['college'][lang] != null
                              ? coll['college'][lang].toString()
                              : coll['college'][lang] == null
                              ? coll['college']['en'].toString()
                              : '',
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      mapClgSleceted = value as Map;
                      hintClgText = mapClgSleceted['college'][lang] != null
                          ? mapClgSleceted['college'][lang].toString()
                          : mapClgSleceted['college'][lang] == null
                          ? mapClgSleceted['college']['en'].toString()
                          : "";
                      selectedCollege = mapClgSleceted['id'];
                    });
                  },
                ))));
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
}
