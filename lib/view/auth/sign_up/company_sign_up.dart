

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:success_stations/controller/city_controller.dart';
import 'package:success_stations/controller/country_controller.dart';
import 'package:success_stations/controller/region_controller.dart';
import 'package:success_stations/controller/services_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:intl/intl.dart';

import 'package:success_stations/view/auth/sign_in.dart';
 var finalIndex;

  DateTime  ? dateTime;
   var dateFormate = DateFormat("yyyy-MM-dd").format(DateTime.parse(dateTime.toString()));

 
class CompanySignUp extends StatefulWidget {

  final val;
  //  late String savedData;
  

  CompanySignUp({this.val});

  _CompanySignPageState createState() => _CompanySignPageState();
}
class _CompanySignPageState extends State<CompanySignUp> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   late String savedData;
   var tyming;
   List selectedValues = [];



  var array = [
    {
      "display": "Australia",
      "value": 1,
    },
    {
      "display": "Canada",
      "value": 2,
    },
    {
      "display": "India",
      "value": 3,
    },
    {
      "display": "United States",
      "value": 4,
    }
  ];

  TextEditingController fulNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController =  TextEditingController();
  TextEditingController mobileController =  TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController iqamaController =  TextEditingController();
  TextEditingController crController =  TextEditingController();
  TextEditingController comNameController =TextEditingController();
  TextEditingController respController= TextEditingController();
  TextEditingController dobController = TextEditingController();

  final signUpCont = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();

  bool _isChecked = false;
   bool errorCheck = true;
  

  var valueRadio ,hintTextCountry,selectedRegion,  hintRegionText, selectedCountry, hintcityText, selectedCity; 
  
  var v = 1;

   List<GroupModel> _group = [
    GroupModel(
      text: "individual".tr,
      index:1 
    ),
    GroupModel(
      text: "company".tr,
      index:2 
    ),
  ];

  

  @override 
  void initState() {
    super.initState();
      errorCheck = true;
  }
   
  companyUser() {
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      var json = {
        "name": nameController.text,
        'email': emailController.text,
        "mobile": mobile1Controller.text, 
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "user_type":  4,
        "cr_number":  crController.text ,
        'company_name':comNameController.text,
        'service_ids[]': selectedValues
      };
      signUpCont.companyAccountData(json);
    }
  }
  individualSignUp() {
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      var individualJson = {
        "name": nameController.text,
        'email': emailController.text,
        "mobile": mobile1Controller.text, 
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "date_of_birth" : finalDate,
        "user_type":  3,
        'iqama_number': iqamaController.text,
        // 'service_ids[]': selectedValues

      };
      print("....>!!!!!!!!!!!!!!..//////..........$individualJson");
      signUpCont.individualAccountData(individualJson);
    }
  }
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              space20,
              fullName(),
              space10,
              eMail(),
              // v == 1? 
              // GetBuilder<SignUpController>(
              //   init: SignUpController(),
              //   builder: (val){
              //     return signUpCont.resultInvalid.isTrue  &&  errorCheck == true? 
              //     Container(
              //       margin:EdgeInsets.only(left:10),
              //       alignment: Alignment.topLeft,
              //       child: Container(
              //         margin:EdgeInsets.only(left:10),
              //         alignment: Alignment.topLeft,
              //         child: Text( signUpCont.indiviualSignup['errors']['email'][0],
              //         style: TextStyle(color: Colors.red),
              //         )
              //       )
              //     ):Container() ;
              //   }
              // ): 
              // GetBuilder<SignUpController>(
              //   init: SignUpController(),
              //   builder: (val){
              //     return signUpCont.resultInvalid.isTrue && errorCheck == true ? 
              //     Container(
              //       margin:EdgeInsets.only(left:10),
              //       alignment: Alignment.topLeft,
              //       child: Container(
              //           margin:EdgeInsets.only(left:10),
              //         alignment: Alignment.topLeft,
              //         child: Text( signUpCont.companySignUp['errors']['email'][0] ,
              //         style: TextStyle(color: Colors.red),
              //         )
              //       )
              //     ): Container();
              //   }
              // ),
              space10,
              mobile(),
              space10 ,
              // v != 2 ? SizedBox(
              //   height: 
              //   Get.height / 9.3,
              //   child: companyDob()
              // ): 
              space10,
              GetBuilder<ContryController>(
                init: ContryController(),
                builder:(val) {
                  return country(val.countryListdata);
                } ,
              ),
              space10,
              GetBuilder<RegionController>(
                init: RegionController(),
                builder: (val){
                  return region(val.listDataRegion);
                },
              ),
              space10,
              GetBuilder<CityController>(
                init: CityController(),
                builder: (val){
                  return city(val.cityListData);
                },
              ),
              space10,
              v == 1 ?
              companyDob()
              : Container(),
              v ==2 ? 
              GetBuilder<ServicesController>(
                init: ServicesController(),
                builder: (val){
                  return services(val.servicesListdata);
                },
              ): Container(),
              space10,
              radioalert(),
              v == 2 ? 
              SizedBox(
                height: Get.height/ 9.3,
                child: comName()
              ):
              space10,
              v == 2 ?
              cR():
              space10,
              v == 1 ? SizedBox(
                height: Get.height / 9.3,
                child: iqama()
              ): 
              space10,
              responsible(),
              space10,
              mobileNumber(),
              space10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked= value!;
                      });
                    },
                  ),
                  Text(
                    "terms".tr, 
                    style: TextStyle(
                      fontFamily: 'Lato', fontSize: 14, fontWeight: FontWeight.w300
                    )
                  ),
                  Text(
                    "terms_condition".tr, style: TextStyle(
                    fontFamily: 'Lato', color: AppColors.appBarBackGroundColor, fontSize: 14, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              space20,
              submitButton(
                buttonText: 'sign_up_text'.tr, 
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun, 
                callback:   _isChecked == true ?  v == 1 ? individualSignUp : companyUser: null 
              ),
              space20,
              GestureDetector(
                onTap: (){
                  Get.to(SignIn());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have_account".tr, 
                      style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300
                      ),
                    ),
                    Text("sign_in".tr, style: TextStyle(fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              space20,
            ],
          ),
        ),
      )
    );
  }

  Widget fullName() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "full_name".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) { },
        textController: nameController,
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return "Name is Required";
          } else if (!regExp.hasMatch(value)) {
            return "Name must be a-z and A-Z";
          }
          else
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget eMail() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:"email".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (newValue) {
        }, 
        onFieldSubmitted: (value) {  },
        textController: emailController,
        validator: (val) {
          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if ( val.length == 0 ){
            return 'Enter An Email';
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
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "mobile".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: mobile1Controller,
          validator: (value) {
          String  pattern =r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
          RegExp regExp = RegExp(pattern);
          if( value.length  == 0){
            return 'Enter Mobile Number';
          }
          else if(!regExp.hasMatch(value)) {
              return "Phone must be in digits";
          }
          else if(value.length !=12){
            return 'Mobile Number must be of 12 digits';
          }
          else 
          return null;
        }, 
        errorText: '',
      ),
    );
  }
  var finalDate;
  Widget companyDob() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child:   Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: WrapCrossAlignment.s,
          children: <Widget>[
            Text(dateTime == null ? 'Date Of Birth' : dateFormate, style: TextStyle(color: Colors.grey[500])),
            // ignore: deprecated_member_use
            GestureDetector(
              child: Icon(Icons.calendar_today),
              onTap: () {
                
                showDatePicker(
                  context: context,
                  initialDate:  DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now()
                ).then((date) {
                  setState(() {               
                    dateTime = date;
                    finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
                    print("..................$finalDate");
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
  Widget comName() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "company".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {},  
        textController: comNameController,
        onSaved: (String? newValue) {  
        }, 
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return " Company Name is Required";
          } else if (!regExp.hasMatch(value)) {
            return "Name must be a-z and A-Z";
          }
          else
          return null;
        }, 
        errorText: '',
      ),
    );
  }

  Widget country(List data) {
    return Container(
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
            hint: Text(
              hintTextCountry != null ? hintTextCountry : 'country'.tr, 
              style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: data.map((coun) {
              return DropdownMenuItem(
                value: coun,
                child:Text(coun['name'])
              );
            }).toList(),
            onChanged: (val) {
              var mapCountry;
              setState(() {
                mapCountry = val as Map;
                hintTextCountry = mapCountry['name'];
                selectedCountry = mapCountry['id'];
              });
            },
          )
        )
      )
    );
  }

  
  Widget region(List dataRegion) {
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
            hint:Text(hintRegionText !=null ?hintRegionText : "region".tr, 
              style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: dataRegion.map((reg) {
              return DropdownMenuItem(
                value: reg,
                child:Text(
                  reg['region']
                )
              );
            }).toList(),
            onChanged: (data) {
              var mapRegion;
              setState(() {
                mapRegion = data as Map ;
                hintRegionText = mapRegion['region'];
                selectedRegion = data['id'];
              });
            },
          )
        )
      )
    );
  }

  Widget city(List citydata) {
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
            hint:Text(
              hintcityText !=null ? hintcityText : "city".tr, style: TextStyle(
                fontSize: 13, color: AppColors.inputTextColor
              )
            ),
            dropdownColor: AppColors.inputColor,
            icon: Icon(Icons.arrow_drop_down),
            items: citydata.map((citt) {
              // print(',,,,!!<<!<!<!<!<!<,,,,,,,cityDatat.....$citt');
              return DropdownMenuItem(
                value: citt,
                child:Text(citt['city'])
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                var mapCity ;
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


  Widget services( allServices){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            MultiSelectFormField(
              autovalidate: false,
              chipBackGroundColor: Colors.grey[200],
              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              checkBoxActiveColor: Colors.white,
              checkBoxCheckColor: Colors.green,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "services".tr,
                style: TextStyle(fontSize: 16),
              ),
              dataSource: allServices !=null ? allServices: '' ,
              textField: 'servics_name',
              valueField: 'id',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text('more'.tr),
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                 selectedValues = value;
                });
              },
            ),

          ]
        ),
      )
    );
     
  }

  Widget iqama() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "enter_iqama_number".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: iqamaController,
        validator: (value) {
          String  pattern =r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
          RegExp regExp = RegExp(pattern);
          if( value.length  == 0){
            return 'Enter Iqama Number';
          }
          else if(!regExp.hasMatch(value)) {
              return "Iqama must be in digits";
          }
          else if(value.length !=13){
            return 'Mobile Number must be of 13 digits';
          }
          else 
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget responsible() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "Responsible".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: respController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

  Widget mobileNumber() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: "mobile_number".tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: mobileController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

   

  Widget cR() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: AppString.cr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: crController,
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return " CR is Required";
          } else if (!regExp.hasMatch(value)) {
            return "CR must be a-z and A-Z";
          }
          else
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,
    );
  }

  radioalert() {
    return  Row(
      children: [
        Container(
          padding: EdgeInsets.only(left:20),
          child: Text("Account_type".tr)
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: _group.map((t) => 
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: t.index,
                    groupValue: v,
                    activeColor: Colors.blue,
                    onChanged: (int?value ) {
                      setState(() {
                        v = value!;
                      });
                    },
                  ),Container(
                  child: Text(t.text))
                ],
              ),
            )).toList()
          ),
        ),
      ],
    );
  }
}

class GroupModel {
  String text;
  int index;
  GroupModel({required this.text, required this.index});
}

