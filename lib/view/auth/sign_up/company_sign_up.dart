import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:success_stations/controller/std_sign_up_controller.dart';
import 'package:success_stations/controller/services_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:success_stations/styling/text_field.dart';
import 'package:intl/intl.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/auth/sign_up/orLine.dart';


var finalIndex, shortCode;

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

class _CompanySignPageState extends State<CompanySignUp> {
  var serText, serId;
  final regionIdByCountry = Get.put(ContryController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String savedData;
  var tyming;
  var counCode, counID, hintTextCountry,selectedCity, selectedCountry, selectedRegion , hintRegionText, hintcityText;
  List selectedValues = [];
  var servID;

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
  final _multiSelectKey = GlobalKey<FormFieldState>();
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
   List selectedAnimals2 = [];
   List selectedAnimals5 = [];
    List  selectedAnimals3 = [];
    late var serviccesDatta;
  final signUpCont = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  PhoneNumber companyCode = PhoneNumber(isoCode: '');
  var inputValuePhone ;
  bool _isChecked = false;
   bool errorCheck = true;
    var type = 'Account Type';
    var serviceName,serviceId;

  var v = 1;

  List<GroupModel> _group = [
    GroupModel(text: "individual".tr, index: 1,),
    GroupModel(text: "company".tr, index: 2,  ),
  ];

  @override
  void initState() {
    super.initState();
    counCode = Get.arguments;
    print("..... councode.............$counCode");
    inputValuePhone = counCode[0].toString();
    companyCode = PhoneNumber(isoCode: inputValuePhone);
    errorCheck = true;
  }

  companyUser() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var json = {
        "name": nameController.text,
        'email': emailController.text,
        "mobile": mobileNUmberController.text,
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "user_type":  4,
        "cr_number":  crController.text ,
        'company_name':comNameController.text,
        'service_ids[]': selectedAnimals2
      };
      print("compamny servicesa... json ...$json");
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
        "mobile": phoneController.text,
        "country_id": selectedCountry,
        "city_id": selectedCity,
        "region_id": selectedRegion,
        "date_of_birth": finalDate,
        "user_type": 3,
        'iqama_number': iqamaController.text,
        'service_ids[]': selectedAnimals2
      };
       print("compamny servicesa... json ...$individualJson");
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
              space10,
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
              v == 1 ?
              Column(
                children: [
                  companyDob(),
                   GetBuilder<ServicesController>(
                    init: ServicesController(),
                    builder: (val){
                     
                      return services(val.servicesListdata, );
                    },
                  ),
                ],
              )
              
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
            
               comName()
              
              :space10,
              v == 2 ?
              cR():
              // space10,
              v == 1 ? 
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    iqama(),
                    // space10,
              //       GetBuilder<ServicesController>(
              //   init: ServicesController(),
              //   builder: (val){
              //     return services(val.servicesListdata);
              //   },
              // ),
                  ],
                )): 
              space10,
              responsible(),
              space10,
              mobileNumber(),
              space10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60)
                    ),
                    child: Checkbox(
                      activeColor: Colors.blue,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked= value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    "terms".tr, 
                    style: TextStyle(
                      fontFamily: 'Lato', fontSize: 14, fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    "terms_condition".tr, style: TextStyle(
                    fontFamily: 'Lato', color: AppColors.appBarBackGroundColor, fontSize: 12,  fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              space20,
              submitButton(
                buttonText: 'sign_up_text'.tr, 
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,fontSize: 18.0, 
                callback:   _isChecked == true ?  v == 1 ? individualSignUp : companyUser: null 
              ),
              space20,
            Container(
              height: 1,
              color:Colors.grey, 
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
                      style: TextStyle( fontSize: 18, fontWeight: FontWeight.w300,color: Colors.grey
                      ),
                    ),
                    Text("sign_in".tr, style: TextStyle(fontSize: 18,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
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

  Widget fullName() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10,right: 10),
        padding :EdgeInsets.only(top:10), 
        isObscure: false,
        hintText: "full_name".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
        validator: (value) {
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return "namereq".tr;
          } else if (!regExp.hasMatch(value)) {
            return "Name must be a-z and A-Z";
          } else
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
        isObscure: false,
         contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10,right: 10),
        hintText:"emails".tr,
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
      width: Get.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFEEEEEE)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InternationalPhoneNumberInput(
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10,bottom: 10),
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
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        // initialValue: n,
        textFieldController: mobileNUmberController,
        formatInput: false,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
        initialValue: companyCode,
      )
    );
  }

  var finalDate;
  Widget companyDob() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(vertical:1.0,horizontal: 10),
      margin: EdgeInsets.only(left: 18,right: 20,bottom: 10),
      decoration: BoxDecoration(
        color:AppColors.inputColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.outline)
      ),
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now()).then((date) {
            setState(() {
              dateTime = date;
              finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
            });
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(dateTime == null ? 'date_of_birth'.tr : dateFormate, style: TextStyle(color: Colors.grey[500],fontSize: 17)),
            GestureDetector(
              child: Icon(Icons.calendar_today,color: Colors.grey),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now()).then((date) {
                  setState(() {
                    dateTime = date;
                    finalDate = DateFormat('yyyy-MM-dd').format(dateTime!);
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
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: "company".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: comNameController,
        onSaved: (String? newValue) {},
        validator: (value) {
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return " companyName".tr;
          } else if (!regExp.hasMatch(value)) {
            return "Name must be a-z and A-Z";
          } else
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
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text(hintTextCountry != null ? hintTextCountry : 'country'.tr,
              style: TextStyle(fontSize: 18, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: data.map((coun) {
              return DropdownMenuItem(value: coun, child: Text(coun['name']));
            }).toList(),
            onChanged: (val) {
              var mapCountry;
              setState(() {
                mapCountry = val as Map;
                hintTextCountry = mapCountry['name'];
                selectedCountry = mapCountry['id'];
                regionIdByCountry.getRegion(selectedCountry);
              });
            },
          )
        )
      )
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
              style:TextStyle(fontSize: 18, color: AppColors.inputTextColor)
            ),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            items: dataRegion.map((reg) {
              return DropdownMenuItem(value: reg, child: Text(reg['region']));
            }).toList(),
            onChanged: (data) {
              var mapRegion;
              setState(() {
                mapRegion = data as Map;
                hintRegionText = mapRegion['region'];
                selectedRegion = data['id'];
                regionIdByCountry.getCity(data['id']);
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
                fontSize: 16, color: AppColors.inputTextColor
              )
            ),
            dropdownColor: AppColors.inputColor,
            icon: Icon(Icons.arrow_drop_down),
            items: citydata.map((citt) {
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


  Widget services(List serviceName){
    print("Builder calling .,...$serviceName");
    return Container(
        width: Get.width/1.1,
                decoration: BoxDecoration(
                  color: AppColors.inPutFieldColor,
                  border: Border.all(
                    color: AppColors.outline
                    // width: 2,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Services"),
                      items: serviceName.map((e) => MultiSelectItem(e, e['servics_name'] !=null ? e['servics_name']:'')).toList(),
                      onConfirm: (values) {
                        var valLoop = values ;
                        for(int c = 0 ; c < valLoop.length ; c++){
                          var idGetServices = valLoop[c] as Map ;
                          var servID =  idGetServices['id'];
                          selectedAnimals2.add(servID);
                        }
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            selectedAnimals2.remove(value);
                          });
                        },
                      ),
                    ),
                    // selectedAnimals2 == null || selectedAnimals2.isEmpty
                    //     ? Container(
                    //         padding: EdgeInsets.all(10),
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           "None selected",
                    //           style: TextStyle(color: Colors.black54),
                    //         ))
                    //     : Container(),
      
          // MultiSelectBottomSheetField(
            
          //   // initialChildSize: 0.7,
          //   listType: MultiSelectListType.CHIP,
          //   searchable: true,
          //   decoration: BoxDecoration(
          //     color: AppColors.inputColor,
          //     border: Border.all(
          //       color: AppColors.inputTextColor
          //     )
          //   ),
          //   buttonText: Text("Services"),
          //   items: serviceName.map((e) => MultiSelectItem(e, e['servics_name'] !=null ? e['servics_name']:'')).toList(),
          //   onConfirm: (e) {
           
          //     // print(",msxmxm,xmxm,samxsm,xslkxcjmdkjcdskcmjs${ e[0]['id']}");
              
              
          //   },
          //   chipDisplay: MultiSelectChipDisplay(
          //     onTap: (value) {
               
               
          //       setState(() {
          //         selectedAnimals2.remove(value);
          //       });
          //     },
          //   ),
          // ),
                
      ] ));
  }

  Widget iqama() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10,right: 10),
        isObscure: false,
        hintText: "enter_iqama_number".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        // isObscure: true,
        textController: iqamaController,
        validator: (value) {
          String pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
          RegExp regExp = RegExp(pattern);
          if( value.length  == 0){
            return 'iqama'.tr;
          }
          else if(!regExp.hasMatch(value)) {
              return "Iqama must be in digits";
          }
          else if(value.length !=13){
            return 'Mobile Number must be of 13 digits';
          } else
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
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10,right: 10),
        isObscure: false,
        hintText: "Responsible".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {},
        textController: respController,
        validator: (value) {},
        errorText: '',
      ),
    );
  }

  Widget mobileNumber() {
    return  Container(
      width: Get.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFEEEEEE)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InternationalPhoneNumberInput(
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
          hintStyle: TextStyle(fontSize: 16, color: AppColors.inputTextColor),
        ),
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        // initialValue: n,
        textFieldController: phoneController,
        formatInput: false,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
        initialValue: companyCode,
      )
    );
  }

  Widget cR() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20,top: 10,bottom: 10),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        contentPadding: lang == 'ar'? EdgeInsets.only(right:10) :EdgeInsets.only(left:10),
        isObscure: false,
        hintText: "crs".tr,
        hintStyle: TextStyle(fontSize: 16, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {},
        onSaved: (String? newValue) {},
        onFieldSubmitted: (value) {}, 
        textController: crController,
        validator: (value) {
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return " crs".tr;
          } else if (!regExp.hasMatch(value)) {
            return "CR must be a-z and A-Z";
          } else
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

  radioalert() {
    return Container(
      margin:lang == 'ar'? EdgeInsets.only(right:20) :EdgeInsets.only(left:10,right: 20),
      child: Row(
        children: [
          Container(
            padding:lang == 'ar'? EdgeInsets.only(right:30) :EdgeInsets.only(left:10),
            child: Text("Account_type".tr,style: TextStyle(fontSize: 16,color: Colors.grey),)
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
                      activeColor:AppColors.appBarBackGroundColor,
                      onChanged: (int?value ) {
                        setState(() {
                          v = value!;
                        });
                      },
                    ),Container(
                    child: Text(t.text,style: TextStyle(fontSize: 16,color: Colors.grey),),)
                  ],
                ),
              )).toList()
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
  GroupModel({required this.text, required this.index,});
}
