import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/city_controller.dart';
import 'package:success_stations/controller/college_controller.dart';
import 'package:success_stations/controller/country_controller.dart';
import 'package:success_stations/controller/region_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/view/auth/sign_in.dart';


class StudentSignUp extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}
class _SignPageState extends State<StudentSignUp> {

  var selectedCountry,selectCountry,  selectedCity , selectedRegion, selectedUniversity, selectedCollege, 
  selectCollege, mapuni, mapClgSleceted, hintTextCountry ,hintRegionText, hintUniText, hintcityText, hintClgText;

  late String firstName, emailSaved , mobileSaved, dobSaved;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController =  TextEditingController();
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController dobController =  TextEditingController();
  final TextEditingController mobileController =  TextEditingController();
  final TextEditingController semesterController =  TextEditingController();
  final TextEditingController addressController =  TextEditingController();
  final TextEditingController aboutController =  TextEditingController();
  final TextEditingController degreeController =  TextEditingController();

  bool _isChecked=false;
  
  final countryPut = Get.put(ContryController());
  final signUpCont = Get.put(SignUpController());

  @override 
  void initState() {
    countryPut.getCountries();
    super.initState();
  }
  void createUser() {
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      var json = {
      "name": nameController.text,
      'email': emailController.text,
      "mobile": mobileController.text, 
      "country_id": selectedCountry,
      "city_id": selectedCity,
      "region_id": selectedRegion,
      "user_type": 2,
      "date_of_birth": dobController.text,
      "college_id": selectedCollege,
      'university_id':selectedUniversity,
      'semester': semesterController.text,
      'address': addressController.text,
      'about': aboutController.text,
      'degree': degreeController.text
    };
    signUpCont.createAccountData(json);

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
              fullNameStudent(),
              space10,
              eMail(),
              space10,
              mobile(),
              space10,
              studentdob(),
              space10,
              semester(),
              space10,
              address(),
              space10,
              about(),
              space10,
              degree(),
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
              GetBuilder<UniversityController>(
                init: UniversityController(),
                builder: (val){
                  return university(val.dataUni);
                },
              ),
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
                  new Checkbox(
                    activeColor: Colors.blue,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked= value!;
                      });
                    },
                  ),
                  Text(
                    'terms'.tr, 
                    style: TextStyle( 
                      fontSize: 14, fontWeight: FontWeight.w300
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
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: "sign_up_text".tr,
                callback: createUser
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
                    Text("sign_in".tr, style: TextStyle( fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
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

  Widget fullNameStudent() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: 'full_name'.tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  },
        textController: nameController,
        onSaved: (newValue) { 
        }, 
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

  Widget semester() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: 'Semester',
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  },
        textController: semesterController,
        onSaved: (newValue) { 
        }, 
        validator: (value) { 
          String  pattern =r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
          RegExp regExp = RegExp(pattern);
          if (value.length == 0) {
            return "semester Field Required";
          } 
          else if(!regExp.hasMatch(value)) {
            return "semester must be in digits";
          }
          else
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
        isObscure: false,
        hintText: 'address',
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  },
        textController: addressController,
        onSaved: (newValue) { 
        }, 
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return "Address Field is Required";
          } else if (!regExp.hasMatch(value)) {
            return "adddress must be a-z and A-Z";
          }
          else
          return null;
        },
        errorText: '',
      ),
    );
  }
  
   Widget about() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: 'About',
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  },
        textController: aboutController,
        onSaved: (newValue) { 
        }, 
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return "About field is Required";
          } else if (!regExp.hasMatch(value)) {
            return "About must be a-z and A-Z";
          }
          else
          return null;
        },
        errorText: '',
      ),
    );
  }

  Widget degree() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: 'Degree',
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  },
        textController: degreeController,
        onSaved: (newValue) { 
        }, 
        validator: (value) { 
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = RegExp(patttern);
          if (value.length == 0) {
            return "Degree field is Required";
          } else if (!regExp.hasMatch(value)) {
            return "Degree must be a-z and A-Z";
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
        hintText: 'email'.tr,
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
        hintText: 'mobile'.tr,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {}, 
        textController: mobileController,
        onSaved: (String? newValue) {}, 
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

  Widget studentdob() {
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
            return 'Please enter your birthday';
            } else if (!regExp.hasMatch(value)) {
            return 'Please enter a valid birthday format is yyyy-mm-dd';
            }
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
              style:  TextStyle(fontSize: 13,  color: AppColors.inputTextColor )
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
            hint:Text(hintUniText !=null ? hintUniText: "university".tr,style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
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
            hint: Text(hintClgText !=null ? hintClgText: "college".tr, style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
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
  
}

