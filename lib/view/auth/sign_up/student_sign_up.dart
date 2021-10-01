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
  var selectedCountry, selectCountry, selectedCity,selectedRegion,selectedUniversity, selectedCollege, selectCollege, mapuni, mapClgSleceted, hintTextCountry,hintRegionText, hintUniText,hintcityText, hintClgText;

  late String firstName, emailSaved, mobileSaved, dobSaved;

  final formKey = GlobalKey<FormState>();
   GetStorage box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  String initialCountry = 'PK';
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
    myTest = countryIdGet[0].toString();
    tttt = PhoneNumber(isoCode: myTest);
    super.initState();
  }

  void createUser() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var json = {
        "name": nameController.text,
        'email': emailController.text,
        "mobile": mobileController.text,
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "user_type": 2,
        "date_of_birth": finalDate,
        "college_id": selectedCollege,
        'university_id': selectedUniversity,
        'semester': semesterController.text,
        'address': addressController.text,
        'about': aboutController.text,
        'degree': degreeController.text
      };
      print("json of the user data .....$json");
      
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
            // SizedBox(height:10),
            eMail(),
            // GetBuilder<SignUpController>(
            //   init: SignUpController(),
            //   builder: (val){
            //     return  signUpCont.resultInvalid.isTrue ? Container(
            //       margin:EdgeInsets.only(left:10),
            //       alignment: Alignment.topLeft,
            //       child: Container(
            //           margin:EdgeInsets.only(left:10),
            //         alignment: Alignment.topLeft,
            //         child: Text(signUpCont.signup['errors']['email'][0],
            //         style: TextStyle(color: Colors.red),)
            //       )
            //       ):Container();

              //    }),
              
              // SizedBox(height:10),
              space10,
              mobile(),
              space10,
              address(),
              space10,
              about(),
              space10,
              degree(),
              space10,
              studentdob(),
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
                  return university(val.dataUni);
                },
              ),
              space10,
              semester(),
              
              space10,
              GetBuilder<CollegeController>(
                init: CollegeController(),
                builder: (val){
                  return college(val.listCollegeData);
                },
              ),
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
                          // _isChecked= true;
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
                // callback:  createUser
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
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
        onSaved: (newValue) {},
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

  Widget semester() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'digitSemester'.tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: semesterController,
        onSaved: (newValue) {},
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

  Widget address() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'address'.tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: addressController,
        onSaved: (newValue) {},
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

  Widget about() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'aboutsu'.tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: aboutController,
        onSaved: (newValue) {},
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

  Widget degree() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'degreesu'.tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: degreeController,
        onSaved: (newValue) {},
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

  Widget eMail() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: 'emails'.tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (newValue) {},
        onFieldSubmitted: (value) {},
        textController: emailController,
        validator: (val) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if ( val.length == 0 ){
            return 'enterEmail'.tr;
          }
          else if (!regExp.hasMatch(val)) {
            return "Enter Valid Email Address";
          }
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget mobile() {
    return Container(
      width: Get.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFEEEEEE)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InternationalPhoneNumberInput(
        focusNode: FocusNode(),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.only(left:10,bottom:10,right: 10),
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
          hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        ),
        onInputChanged: (PhoneNumber number) {
        },
        onInputValidated: (bool value) {
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        // initialValue: n,
        textFieldController: mobileController,
        formatInput: false,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
        },
        initialValue: tttt,
      )
    );
  }


  Widget studentdob() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical:1.0,horizontal: 10),
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.outline)
      ),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1900, 3, 5),
            maxTime: DateTime.now(),
            theme: DatePickerTheme(
              headerColor:AppColors.appBarBackGroundColor,
              backgroundColor: Colors.white,
              itemStyle: TextStyle(
                color: AppColors.appBarBackGroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
              doneStyle: TextStyle(color:Colors.white, fontSize: 16),
              // cancelStyle: TextStyle(color:Colors.white, fontSize: 16),
            ),
            onChanged: (date) {
              print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
            }, 
            onConfirm: (date) {
              setState(() {
                dateTime = date;
                print('confirm...sheeee $dateTime');
                  finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
                  print("kjxlkasjxklshxkjshxbikjscjxgdscjsbckkjhscvhds$finalDate");
                
              });
              
            },    
            currentTime: DateTime.now(), locale: LocaleType.en
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child:  Text(dateTime == null ? 'date_of_birth'.tr : finalDate.toString() ,textAlign: TextAlign.left, style: TextStyle(color: Colors.grey[500],fontSize: 16))),
            GestureDetector(
              child: Icon(Icons.calendar_today,color: Colors.grey,),
               onTap: () {               
                DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 3, 5),
                  maxTime: DateTime.now(),
                  theme: DatePickerTheme(
                    headerColor:AppColors.appBarBackGroundColor,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                      color: AppColors.appBarBackGroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    doneStyle: TextStyle(color:Colors.white, fontSize: 16),
                    cancelStyle: TextStyle(color:AppColors.appBarBackGroundColor, fontSize: 16),
                  ),
                  onChanged: (date) {
                    print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
                  }, 
                  onConfirm: (date) {
                    setState(() {
                      dateTime = date;
                      print('confirm...sheeee $dateTime');
                       finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
                       print("kjxlkasjxklshxkjshxbikjscjxgdscjsbckkjhscvhds$finalDate");
                      
                    });
                    
                  },    
                  currentTime: DateTime.now(), locale: LocaleType.en
                );
              },
            ),
          ],
        ),
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
                  child:  coun['name'] !=null ?  Text(
                    coun['name'][lang]
                  ): Container()
                );
                }).toList(),
                onChanged: (val) {
                  var mapCountry;
                  setState(() {
                    mapCountry = val as Map;
                    hintTextCountry = mapCountry['name'][lang];
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
                value: reg, child: reg['region'] !=null ? Text(reg['region'] ):Container()
              );
            }).toList(),
            onChanged: (data) {
              var mapRegion;
              setState(() {
                mapRegion = data as Map;
                hintRegionText = mapRegion['region'];
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
              return DropdownMenuItem(value: citt, child: Text(citt['city']));
            }).toList(),
            onChanged: (value) {
              setState(() {
                var mapCity;
                mapCity = value as Map;
                hintcityText = mapCity['city'];
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
            hint:Text(hintUniText !=null ? hintUniText: "universitysu".tr,style: TextStyle(fontSize: 16, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: daattta.map((uni) {
              return DropdownMenuItem(
                value: uni,
                child:Text(uni['name'])
              );
            }).toList(),
            onChanged: (dataa) {
              setState(() {
                mapuni = dataa as Map;
                hintUniText =  mapuni['name'];
                selectedUniversity = dataa['id'];
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
            hint: Text(hintClgText !=null ? hintClgText: "collegesu".tr, style: TextStyle(fontSize: 16, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: collegeData.map((coll) {
              return DropdownMenuItem(
                value: coll,
                child:Text(coll['college'])
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                mapClgSleceted = value as Map;
                hintClgText = mapClgSleceted['college'];
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
