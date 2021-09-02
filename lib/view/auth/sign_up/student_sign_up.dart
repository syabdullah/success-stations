import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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

  DateTime  ? dateTime;
   var dateFormate = DateFormat("yyyy-MM-dd").format(
        DateTime.parse(dateTime.toString()
     ));
      // var str = JSON.encode(dt, toEncodable: myEncode);


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
      "date_of_birth":finalDate,
      "college_id": selectedCollege,
      'university_id':selectedUniversity,
      'semester': semesterController.text,
      'address': addressController.text,
      'about': aboutController.text,
      'degree': degreeController.text
    };
    print("hxsahkjkjhsxahgjxhsgaxdiuljhxbkjaxn ksamnckjsabc,mnxsbckhjd,bafiouqrefioewq$json");
    signUpCont.createAccountData(json);

  }
    
 }
  
  @override
  Widget build(BuildContext context) {
    // print("signUpCont.signup['errors']['email']signUpCont.signup['errors']['email']signUpCont.signup['message']['email']${signUpCont.signup['message']}");
    final space20 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return  Scaffold(
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
              semester(),
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
                        print("hbsdbjhsdbjshgdSjhgd on changed......>>>>>>>$value");
                        _isChecked= value!;
                        // _isChecked= true;
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
                callback: _isChecked == true ?  createUser : null
                // callback:  createUser
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
        hintText: 'semester'.tr,
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
        hintText: 'address'.tr,
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
            return "Address field is Required";
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
  
   Widget about() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText: 'about'.tr,
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
        hintText: 'degree'.tr,
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
      
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: InternationalPhoneNumberInput(
              inputDecoration:   InputDecoration(
              fillColor: AppColors.inputColor,
              filled: true,
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.red
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.red
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.outline
                ),
              ),
              hintText: "Mobile",
              
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
              textFieldController: mobileController,
              formatInput: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ));
  }
  var finalDate;
  Widget studentdob() {
    // return  Container(
    //   margin:EdgeInsets.only(left:20, right: 20),
    //   width: Get.width * 0.9,
    //   child: CustomTextFiled(
    //     isObscure: false,
    //     hintText: "yymmdd".tr,
    //     hintStyle: TextStyle(fontSize: 13, color: AppColors.inputTextColor),
    //     hintColor: AppColors.inputTextColor,
    //     onChanged: (value) {  },
    //     onFieldSubmitted: (value) {},  
    //     textController: dobController,
    //     onSaved: (String? newValue) {  
    //     }, 
    //     validator: (value) {
    //     String pattern = (r'^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$');
    //     RegExp regExp = RegExp(pattern);
    //       if (value.length == 0) {
    //         return 'Please enter your birthday';
    //         } else if (!regExp.hasMatch(value)) {
    //         return 'Please enter a valid birthday format is yyyy-mm-dd';
    //         }
    //         return null;
    //       },
           
    //     errorText: '',
    //   ),
    // );
        return Container(
          padding: const EdgeInsets.symmetric(vertical:18.0,horizontal: 10),
          margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.outline)
          ),
          child:   GestureDetector(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(right:100),
              child: Text(dateTime == null ? 'Date Of Birth' : dateFormate ,textAlign: TextAlign.left, style: TextStyle(color: Colors.grey[500]))),
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
            ),
            // CupertinoDatePicker(
            //   mode: ,
            //   onDateTimeChanged: onDateTimeChanged
            //   )
          ],
        ),
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

