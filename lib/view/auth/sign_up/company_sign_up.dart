

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:success_stations/controller/city_controller.dart';
import 'package:success_stations/controller/country_controller.dart';
import 'package:success_stations/controller/region_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';


import 'package:success_stations/view/auth/sign_in.dart';
 var finalIndex;
class CompanySignUp extends StatefulWidget {

  final val;
 

  CompanySignUp({this.val});

  _CompanySignPageState createState() => _CompanySignPageState();
}
class _CompanySignPageState extends State<CompanySignUp> {

  late List _myActivities;

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

  bool _isChecked = true;

  var valueRadio ,hintTextCountry,selectedRegion,  hintRegionText, selectedCountry, hintcityText, selectedCity; 
  
  var v = 1;
   List _selected3 = [];

   List<GroupModel> _group = [
    GroupModel(
      text: ' Individual',
      index:1 
    ),
    GroupModel(
      text: 'Company',
      index:2 
    ),
  ];
  

  @override 
  void initState() {
    super.initState();
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
      };
      signUpCont.companyAccountData(json);
    }
  }
  individualSignUp() {
    // print("...................");
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
        "date_of_birth" : dobController.text,
        "user_type":  3,
        'iqama_number': iqamaController.text

      };
      // print("......!!!!!!! jsong of the company$individualJson ");
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
              space10,
              mobile(),
              space10 ,
              v != 2 ? SizedBox(
                height: 
                Get.height / 9.3,
                child: companyDob()
              ): 
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
              // space10,
              // GetBuilder<ServicesController>(
              //   init: ServicesController(),
              //   builder: (val){
              //     return services(val.servicesListdata);
              //   },
              // ),
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
                    AppString.termServices, 
                    style: TextStyle(
                      fontFamily: 'Lato', fontSize: 14, fontWeight: FontWeight.w300
                    )
                  ),
                  Text(
                    AppString.termCondition, style: TextStyle(
                    fontFamily: 'Lato', color: AppColors.appBarBackGroundColor, fontSize: 14, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              space20,
              submitButton(
                buttonText: AppString.signUp, 
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun, 
                callback: v == 1 ? individualSignUp : companyUser
              ),
              space20,
              GestureDetector(
                onTap: (){
                  Get.to(SignIn());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.existAccount, 
                      style: TextStyle( fontSize: 13, fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(AppString.signIn, style: TextStyle(fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
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
        hintText: AppString.fullName,
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

  //  Widget eMail() {
  //   return  Container(
  //     margin:EdgeInsets.only(left:20, right: 20),
  //     width: Get.width * 0.9,
  //     child: CustomTextFiled(
  //       hintText:AppString.email,
  //       hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
  //       hintColor: AppColors.inputTextColor,
  //       onChanged: (value) {  },
  //       onSaved: (String? newValue) {  }, 
  //       onFieldSubmitted: (value) {  }, 
  //       // isObscure: true,
  //       textController: emailController,
  //       validator: (val) {
  //         String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //         RegExp regExp = RegExp(pattern);
  //         if ( val.length == 0 ){
  //           return 'Enter an Email';
  //         }
  //         else if (!regExp.hasMatch(val)) {
  //           return "Enter Valid Email Address";
  //         }
  //         return null;
  //       }, 
  //       errorText: '',
  //     ),
  //   );
  // }
  Widget eMail() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:AppString.email,
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
        hintText: AppString.mobile,
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
  Widget companyDob() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: AppString.dob,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {},  
        textController: dobController,
        onSaved: (String? newValue) {  
        }, 
        validator: (value) {
          String pattern = (r'^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$');
          RegExp regExp = RegExp(pattern);
          if (value.length == 0) {
            return 'Enter your DOB';
            } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid birthday format is yyyy-mm-dd';
            }
            return null;
          }, 
        errorText: '',
      ),
    );
  }
  Widget comName() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: AppString.companyName,
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
              hintTextCountry != null ? hintTextCountry : 'country', 
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
            hint:Text(hintRegionText !=null ?hintRegionText : "Region", 
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
              hintcityText !=null ? hintcityText : "City", style: TextStyle(
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


  Widget services(servicesListdata){
    print("Z......A........M......A...................N$servicesListdata");
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          MultiSelectFormField(
                  autovalidate: false,
                  title: Text('My workouts'),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                  },
                  dataSource: servicesListdata.map((e) {
                    print("PRINTEED VALUE OF THE EEEEEEEE........................>>>>>>$e");
                     e['servics_name'].toList();
                  }),

                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  // hintText: 'Please choose one or more',
                  // value: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              
        ],
      )

    );
  }

  Widget iqama() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: AppString.idIqama,
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
        hintText: AppString.response,
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
        hintText: AppString.mobNum,
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
        validator: (value) {  }, 
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
          child: Text(AppString.accountType)
        ),
        Expanded(
          child: Row(
            children: _group.map((t) => 
            Expanded(
              child: Row(
                children: [
                  Radio(
                    value: t.index,
                    groupValue: v,
                    activeColor: Colors.blue,
                    onChanged: (int?value ) {
                      setState(() {
                        // print(" radio button values................$value");
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

