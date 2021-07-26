import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/city_controller.dart';
import 'package:success_stations/controller/college_controller.dart';
import 'package:success_stations/controller/country_controller.dart';
import 'package:success_stations/controller/region_controller.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/controller/sign_up_controller.dart';
import 'package:success_stations/controller/university_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';

class StudentSignUp extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}
class _SignPageState extends State<StudentSignUp> {

  var selectedCountry,  selectedCity , selectedRegion, selectedUniversity, selectedCollege;

  late String firstName, emailSaved , mobileSaved, dobSaved;
  var selectCountry;
  var selectCollege;

  final TextEditingController nameController =  TextEditingController();
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController dobController =  TextEditingController();
  final TextEditingController mobileController =  TextEditingController();

  bool rememberMe = true;

  final countryPut = Get.put(ContryController());
  final signUpCont = Get.put(SignUpController());

  @override 
  void initState() {
    countryPut.getCountries();
    super.initState();
  }

  void createUser() {
    var json = {
      "name":nameController.text,
      'email': emailController.text,
      "mobile": mobileController.text, 
      "country_id": 1,
      "city_id": 1,
      "region_id": 1,
      "user_type": 2,
      "date_of_birth": dobController.text,
      "college_id": 1,
      'university_id':1
    };
    print(".........create user.../?@@@@@?///////,,,,,,,,         $json");
    signUpCont.createAccountData(json);

  }
  
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return  Scaffold(
      body: SingleChildScrollView(
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
                return university(val.listUniData);
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
                Checkbox(
                  focusColor: Colors.lightBlue,
                  activeColor: Colors.blue,
                  value: rememberMe,
                  onChanged: (newValue) {
                    // setState(() => rememberMe = newValue);
                  }
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
              bgcolor: AppColors.appBarBackGroundColor,  
              textColor: AppColors.appBarBackGroun,
              buttonText: AppString.signUp,
              callback: createUser
            ),
            space20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppString.existAccount, 
                  style: TextStyle(
                    fontFamily: 'Lato', fontSize: 13, fontWeight: FontWeight.w300
                  ),
                ),
                Text(AppString.signIn, style: TextStyle(fontFamily: 'Lato', fontSize: 13,  color: AppColors.appBarBackGroundColor, fontWeight: FontWeight.bold),),
              ],
            ),
            space20,
          ],
        ),
      )
    );
  }

  Widget fullNameStudent() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.fullName,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: nameController,
        onSaved: (newValue) { 
          // fullName.text = newValue!;
        }, 
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

   Widget eMail() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText:AppString.email,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (newValue) { 
          // emailController.text = newValue! ;
        }, 
        onFieldSubmitted: (value) {  }, 
        // isObscure: false,
        textController: emailController,
        validator: (value) {}, 
        errorText: '',
      ),
    );
  }
  
  Widget mobile() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.mobile,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
          
          onFieldSubmitted: (value) {}, 
          // isObscure: false,
          textController: mobileController,
          onSaved: (String? newValue) {
            // mobileController.text = newValue!; 
          }, 
          validator: (value) {  }, 
          errorText: '',
      ),
    );
  }
  Widget studentdob() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.dob,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textInput),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
       
        onFieldSubmitted: (value) {  }, 
        // isObscure: true,
        textController: dobController,
        onSaved: (String? newValue) { 
          // dobController.text= newValue!; 
        }, 
        validator: (value) {  }, 
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
            hint: Text("Country", style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            value: selectedCountry, 
            items: data.map((coun) {
              return DropdownMenuItem(
                value: coun,
                child:Text(coun['name'])
              );
            }).toList(),
            onChanged: (value) {
              print("...////////......value... of the countryyyyy..........>>>$value ");
              setState(() {
                selectCountry = value;
                // selectedCountry =  value['id'];
                print("..!!!>...!!!!!!!${selectedCountry = value}");
              
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
            hint:Text("Region", style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            value: selectedRegion, 
            items: dataRegion.map((reg) {
              return DropdownMenuItem(
                value: reg,
                child:Text(
                  reg['region']
                )
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedRegion = value;
              });
            },
          )
        )
      )
    );
  }

  Widget city( List citydata) {
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
            hint:Text("City",style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inputColor,
            icon: Icon(Icons.arrow_drop_down),
            value: selectedCity, 
            items: citydata.map((citt) {
              return DropdownMenuItem(
                value: citt,
                child:Text(citt['city'])
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          )
        )
      )
    );
  }
  
  Widget university(List universityData) {
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
            hint:Text("University",style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            value: selectedUniversity, 
            items: universityData.map((uni) {
              return DropdownMenuItem(
                value: uni,
                child:Text(uni['name'])
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedUniversity = value;
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
            hint: Text("College", style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)),
            dropdownColor: AppColors.inPutFieldColor,
            icon: Icon(Icons.arrow_drop_down),
            value: selectedCollege, 
            items: collegeData.map((coll) {
              return DropdownMenuItem(
                value: coll,
                child:Text(coll['college'])
              );
            }).toList(),
            onChanged: (value) {
              print("val;ue.............vsalue of the college ....>$value");
              setState(() {
                // selectedCollege =  value!['id'].toString() ;
              }
              );
            },
          )
        )
      )
    );
  }

  Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor,image}) {
     print("../././/......$image");
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,    
      // borderColor: borderColor,
      image: image,
      // height: height,
      width: width,  
    );
  }

  // void navigateToHomeScreen() {
  //   PageUtils.pushPage(SignupOption());
  // }
}

