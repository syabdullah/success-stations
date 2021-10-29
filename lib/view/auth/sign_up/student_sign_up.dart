import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:success_stations/controller/college_controller.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/text_field.dart';
// ignore: unused_import
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


DateTime? dateTime;
var dateFormate = DateFormat("yyyy-MM-dd").format(DateTime.parse(dateTime.toString()));
// var str = JSON.encode(dt, toEncodable: myEncode);

class StudentSignUp extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<StudentSignUp> {
    var finalDate;
  final countryPut = Get.put(ContryController());
  var selectedCountry,statusSelected, selectCountry, selectedCity,selectedRegion,selectedUniversity, selectedCollege, selectCollege, mapuni, mapClgSleceted, hintTextCountry,hintRegionText, hintUniText,hintcityText, hintClgText;

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
  var passwordValue,confirmPasswordValue;
 
  PhoneNumber tttt = PhoneNumber(isoCode: '');

  bool _isChecked = false;
  var myTest;
  var countryIdGet, shortCodeAdd,confirmDate;

 
  final signUpCont = Get.put(SignUpController());
  var lang;
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
        'password':passwordValue,
        "password_confirmation":confirmPasswordValue,
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
    final space20 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            space10,
            fullNameStudent(),
            space10,
            eMail(),
            space10,
            password(),
            space10,
            confirmPassword(),
            space10,
            mobile(),
            space10,
            studentdob(),
             space10,
              GetBuilder<ContryController>(
                init: ContryController(),
                builder:(val) {
                  return country(val.countryListdata);
                } ,
              ),
              space10,
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val){
                  return region(val.regionListdata);
                },
              ),
              space10,
              GetBuilder<ContryController>(
                init: ContryController(),
                builder: (val){
                  return city(val.cityListData);
                },
              ),
              space10,
              GetBuilder<UniversityController>(
                init: UniversityController(),
                builder: (val){
                  return  university(val.dataUni);
                },
              ),space10,
              GetBuilder<CollegeController>(
                init: CollegeController(),
                builder: (val){
                  return college(val.listCollegeData);
                },
              ),
              space10,
              degree(),
              space10,
              about(),
              space10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: .9,
                    child: new Checkbox(
                      activeColor: AppColors.appBarBackGroundColor,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked= value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    'terms'.tr, 
                    style: TextStyle( 
                      fontSize: 14,
                      color: Colors.grey,
                       fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    "terms_condition".tr, style: TextStyle(
                    fontFamily: 'Lato', color: AppColors.appBarBackGroundColor, fontSize: 14, fontWeight: FontWeight.bold )
                  ),
                ],
              ),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: "sign_up_text".tr,fontSize: 16.0,
                callback: _isChecked == true ?  createUser : null
              ),
              space20,
               Container(
              height: 1,
              color:Colors.grey, 
              ),
              space20,
              GestureDetector(
                onTap: (){
                  Get.toNamed('/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have_account".tr,
                      style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300,color: Colors.grey
                      ),
                    ),
                    Text("sign_in".tr, style: TextStyle( fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              space20,
            ],
          ),
        ),
      ),
    );
  }

  Widget fullNameStudent() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'full_name'.tr,
        hintStyle: TextStyle(fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor:   lang == 'ar'? AppColors.inputTextColor:AppColors.inputTextColor ,
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
      margin: EdgeInsets.only(left:20,right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        keyboardType: TextInputType.number,
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10,top:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'semestersu'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
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
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'address'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
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
      // margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        maxLine: 4,
        contentPadding: lang == 'ar'? EdgeInsets.only(right:20,top: 20) :EdgeInsets.only(left:20,top: 20),
        isObscure: false,
        hintText: 'about'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor:   lang == 'ar'? AppColors.inputTextColor:AppColors.inputTextColor ,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: aboutController,
        onSaved: (newValue) {},
        validator: (value) {
          if (value.length == 0) {
            return "aboutfield".tr;
          } else
            return null;
        },
        errorText: '',
      ),
    );
  }

  Widget degree() {
     return  Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: AppColors.inputColor,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(2.0)
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
              child: Container(
                margin: EdgeInsets.only(right:2),
                child: DropdownButton(
                  hint: Text(
                     statusSelected == null? 'degreesu'.tr:statusSelected ,
                    style: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor)
                  ),
                  dropdownColor: AppColors.inPutFieldColor,
                  icon: Icon(Icons.arrow_drop_down),
                  items:  <String>['diploma'.tr ,'bachelor\'s'.tr, 'master\'s'.tr, 'doctorate'.tr].map((String value){
                    return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.grey[800]),
                    )
                  );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      statusSelected = val;
                    });
                  },
                ),
              )
            )
          )
        );
    
  }
  

  Widget eMail() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'emails'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: emailController,
        validator: (val) {
          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if ( val.length == 0 ){
            return 'enterEmail'.tr;
          }
          else if (!regExp.hasMatch(val)) {
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
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure : true,
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        hintText: 'password'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          passwordValue = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: passController,
        validator: (val) {
          if ( val!.length == 0 ){
            return 'EnterPassword'.tr;
          }else if(val != confirmPasswordValue) {
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
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        maxLine: 1,
        isObscure: true,
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        hintText: 'confirmPassword'.tr,
        hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {
          confirmPasswordValue = value;
        },
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: conPassController,
        validator: (val) {
          if ( val!.length == 0 ){
            return 'EnterPasswordConfirm'.tr;
          }else if(val != passwordValue) {
            return 'passwordNotMatch'.tr;
          }
          return null;
        },
        errorText: '',
      ),
    );
  }
  Widget mobile() {
    return  Container(
      width: Get.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFEEEEEE)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InternationalPhoneNumberInput(
        focusNode: FocusNode(),
        cursorColor: AppColors.appBarBackGroundColor,
        autoFocus: false,
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.only(left:10,bottom: 10),
          fillColor: AppColors.inputColor,
          filled: true,
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: "mobilee".tr,
          hintStyle: TextStyle( fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor),
          
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
        onSaved: (PhoneNumber number) {
        },
        initialValue: tttt,
      )
    );
  }
  Widget studentdob() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: TextFormField(
        
        focusNode: FocusNode(),
        validator: (val) {
          if( DateTime.parse(finalDate!).isAfter(DateTime.now())){
            return 'dobb'.tr;
          }
           return null;
        },
        style: TextStyle(
          color:AppColors.inputTextColor,fontSize: 16,fontWeight: FontWeight.bold
        ),
        decoration:InputDecoration( 
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200
            ),
          ),
          // fillColor: AppColors.inputColor,
          // filled: true,
          focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.grey.shade200
          )),
          
          contentPadding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
          hintText: finalDate == null ? 'date_of_birth'.tr : finalDate.toString(),
          hintStyle: TextStyle(fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor, fontWeight: FontWeight.normal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        suffixIcon:  GestureDetector(
          child: Icon(Icons.calendar_today,color: Colors.grey,),
            onTap: () {               
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900, 3, 5),
                // maxTime: DateTime.now(),
                theme: DatePickerTheme(
                  headerColor:AppColors.appBarBackGroundColor,
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(
                    color: AppColors.appBarBackGroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  doneStyle: TextStyle(color:Colors.white, fontSize: lang == 'ar' ? 14 : 16,),
                  cancelStyle: TextStyle(color:AppColors.appBarBackGroundColor,  fontSize: lang == 'ar' ? 14 : 16,),
                ),
                onChanged: (date) {}, 
                onConfirm: (date) {
                  setState(() {
                    dateTime = date;
                    finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
                    
                  });
                },
                currentTime: DateTime.now(), locale: LocaleType.en
              );
            },
          ),
        ) ,
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
            borderRadius: BorderRadius.circular(2.0)
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  hintTextCountry != null ? hintTextCountry : 'country'.tr,
                  style: TextStyle(fontSize: 18, color: AppColors.inputTextColor)
                ),
                dropdownColor: AppColors.inPutFieldColor,
                icon: Icon(Icons.arrow_drop_down),
                items: data.map((coun) {
                  return DropdownMenuItem(value: coun, 
                  child:   Text(
                    coun['name'][lang] !=null ?  coun['name'][lang].toString() : coun['name'][lang] == null ? coun['name']['en'].toString():''
                  )
                );
                }).toList(),
                onChanged: (val) {
                  var mapCountry;
                  setState(() {
                    mapCountry = val as Map;
                    hintTextCountry = mapCountry['name'][lang] !=null ?  mapCountry['name'][lang].toString():  mapCountry['name'][lang] ==null ?  mapCountry['name']['en'].toString():"";
                    selectedCountry = mapCountry['id'];
                    countryPut.getRegion(selectedCountry);
                  });
                },
              )
            )
          )
        ),
      ],
    );
  }

  Widget region(List dataRegion) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text(hintRegionText != null ? hintRegionText : "region".tr,
              style: TextStyle(fontSize: 18, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: dataRegion.map((reg) {
              return DropdownMenuItem(
                value: reg, child:  Text(
                  reg['region'][lang] !=null ?  reg['region'][lang].toString() : reg['region'][lang] ==null ?  reg['region']['en'].toString():'',
                )
              );
            }).toList(),
            onChanged: (data) {
              var mapRegion;
              setState(() {
                mapRegion = data as Map;
                hintRegionText = mapRegion['region'][lang] !=null ? mapRegion['region'][lang].toString():
                mapRegion['region'][lang] ==null ? mapRegion['region']['en'].toString():'' ;
                selectedRegion = data['id'];
                countryPut.getCity(data['id']);
              });
            },
          )
        )
      )
    );
  }

  Widget city(List citydata) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text(hintcityText != null ? hintcityText : "city".tr,
              style:TextStyle(fontSize: 18, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inputColor,
            icon: Icon(Icons.arrow_drop_down),
            items: citydata.map((citt) {
              return DropdownMenuItem(
                value: citt, 
                child: Text(
                  citt['city'][lang] !=null ? citt['city'][lang].toString() :
                  citt['city'][lang] == null ? citt['city']['en'].toString():''
                )
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                var mapCity;
                mapCity = value as Map;
                hintcityText = mapCity['city'][lang] !=null ? mapCity['city'][lang].toString() :
                mapCity['city'][lang] ==null ? mapCity['city']['en'].toString() :'';
                selectedCity = mapCity['id'];
              });
            },
          )
        )
      )
    );
  }

  Widget university(List daattta) {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint:Text(hintUniText !=null ? hintUniText: "universitysu".tr,style: TextStyle(fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: daattta.map((uni) {
              return DropdownMenuItem(
                value: uni,
                child:
                Text (
                  uni['name'][lang] !=null ?  uni['name'][lang].toString():  uni['name'][lang] ==null ?  uni['name']['en'].toString() : ''
                )
              );
            }).toList(),
            onChanged: (dataa) {
              setState(() {
                mapuni = dataa as Map;
                hintUniText =  mapuni['name'][lang] !=null ?  mapuni['name'][lang].toString():  mapuni['name'][lang] == null ?  mapuni['name']['en'].toString():'';
                selectedUniversity = mapuni['id'];
              });
            },
          )
        )
      )
    );
  }

  Widget college(List collegeData) {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text(hintClgText !=null ? hintClgText: "collegesu".tr, style: TextStyle(fontSize: lang == 'ar' ? 14 : 16, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: collegeData.map((coll) {
              return DropdownMenuItem(
                value: coll,
                child: Text(
                  coll['college'][lang] !=null ?  coll['college'][lang].toString() :
                  coll['college'][lang] == null ? coll['college']['en'].toString():'',
                )
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                mapClgSleceted = value as Map;
                hintClgText = mapClgSleceted['college'][lang] !=null ? mapClgSleceted['college'][lang].toString() : 
                mapClgSleceted['college'][lang] == null ? mapClgSleceted['college']['en'].toString(): "";
                selectedCollege =  mapClgSleceted['id'];
              });
            },
          )
        )
      )
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
    return AppButton(
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
