import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dio/dio.dart' as dio;

class AddPostingScreen extends StatefulWidget {
  const AddPostingScreen({ Key? key }) : super(key: key);

  @override
  _AddPostingScreenState createState() => _AddPostingScreenState();
}

class _AddPostingScreenState extends State<AddPostingScreen> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final catogoryController = Get.put(CategoryController());
    final adpostingController = Get.put(AdPostingController());
  int activeStep = 0;
  int upperBound = 3;  
  final _formKey = GlobalKey<FormState>();
  List list= [];
  List type = [];
  var selectedtype;
  var selectedCategory;
  // var selectedSubCategory;
  var subtypeId;
  var selectedStatus;
  var uiStatus;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController telePhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var json;
  GetStorage box = GetStorage();
  final ImagePicker _picker = ImagePicker();
    // Pick an image
    XFile? pickedFile;
  late String image;
  var fileName;
var id,cid,rid,crid ;
var lang;
  @override
  void initState() {
    super.initState();
    id = box.read('user_id');
    cid = box.read('city_id');
    rid = box.read('region_id');
    crid = box.read('country_id');
    lang = box.read('lang_code');
    catogoryController.getCategoryNames();
    catogoryController.getCategoryTypes();
  }
  Future getImage() async {
    await ApiHeaders().getData();
   pickedFile =   await _picker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;      
        fileName = pickedFile!.path.split('/').last;  
      } else {
        print('No image selected.');
      }
    });
      try {
          dio.FormData formData = dio.FormData.fromMap({          
            "file": await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
          });
          Get.find<AdPostingController>().uploadAdImage(formData); 
        } catch (e) {

        }
      print(".......UPload image");
  }
   adpost() async{
    
     if(pickedFile != null) {
       
        try {
          dio.FormData formData = dio.FormData.fromMap({            
             'category_id' : subtypeId,
              'status': selectedStatus,
              'description': descController.text,
              'price': priceController.text,
              'contact_name': fullNameController.text,
              'mobile_no': mobileNoController.text,
              'tel_no': telePhoneController.text,
              'title':titleController.text,
              'created_by': id.toString(),
              'email': emailController.text,
              'country_id': crid.toString(),
              'city_id':cid.toString(),
              'region_id': rid.toString(),
              "image":  await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
          }); 
          Get.find<AdPostingController>().finalAdPosting(formData); 
        } catch (e) {
            print("...............$e");
        }
      }
  //   json = {
  //   'category_id' : subtypeId,
  //   'status': selectedStatus,
  //   'description': descController.text,
  //   'price': priceController.text,
  //   'contact_name': fullNameController.text,
  //   // 'mobile_no': mobileNoController.text,
  //   // 'tel_no': telePhoneController.text,
  //   'title':titleController.text,
  //   'created_by': id.toString(),
  //   'email': emailController.text,
  //   'country_id': crid.toString(),
  //   'city_id':cid.toString(),
  //   'region_id': rid.toString(),
  // };
  // print("..................$json");
  // adpostingController.finalAdPosting(json);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
        ),
      child: AppDrawer(),
    ),
      body: ListView(
        children: [
          ImageStepper(
            stepColor: Colors.yellow,
            lineDotRadius: 0.1,
            lineColor: Colors.grey,
            activeStepColor: AppColors.appBarBackGroundColor,
            activeStepBorderColor: Colors.grey[700],
            lineLength: 75,
            enableNextPreviousButtons: false,
            images: [
              activeStep == 0 ?
              AssetImage(AppImages.sistStepIcon):
              AssetImage(AppImages.istStepIcon),
              activeStep == 1 ?
              AssetImage(AppImages.ssecStepIcon):
              AssetImage(AppImages.secStepIcon),
              activeStep == 2 ?
              AssetImage(AppImages.strdStepIcon):
              AssetImage(AppImages.trdStepIcon),
            ],
            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,
            // This ensures step-tapping updates the activeStep. 
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              }
            );
            },
          ),
          header(),
          GetBuilder<CategoryController>( 
          init: CategoryController(),
          builder:(val) {
            print("...................JJ ${val.datacateg}");
            return 
             activeStep == 0 ? istStep(val.datacateg,val.datacategTypes) :
             activeStep == 1 ? secondStep() : 
             activeStep ==2 ?  thirdStep() : Container();
            
          }
            ),
            activeStep == 0 ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: nextButton(),
              ),
            ],
            ): activeStep == 1 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              previousButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: nextButton(),
              ),
             ],
            ):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                saveAsDraftButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: publishButton(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return Container(
      height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed:  () {   // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound && _formKey.currentState!.validate()) {
            setState(() {
              activeStep++;
            });
          }
         },
        child: Text('next'.tr),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Container(
      height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
         primary: Colors.grey,
         textStyle: TextStyle(
         fontSize: 15,
         fontWeight: FontWeight.bold)),
         onPressed: () {
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          } 
        },
        child: Text('previous'.tr),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        activeStep == 0 ?
        Text("announce_new".tr,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor
          ) 
         ):
        Text("announce_new".tr,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey
            )
          ),
        activeStep == 1 ?
        Text("contact_information".tr,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)
        ):
        Text("contact_information".tr,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
        activeStep == 2 ?
        Text("review_publish".tr,textAlign: TextAlign.center,
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appBarBackGroundColor)
        ):
        Text("review_publish".tr,textAlign: TextAlign.center, 
          style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
      ],
    );
  }

  // // Returns the header text based on the activeStep.
  // String headerText() {
  //   switch (activeStep) {
  //     case 1:
  //       return 'Preface';

  //     case 2:
  //       return 'Table of Contents';

  //     case 3:
  //       return 'About the Author';

  //     case 4:
  //       return 'Publisher Information';

  //     case 5:
  //       return 'Reviews';

  //     case 6:
  //       return 'Chapters #1';

  //     default:
  //       return 'Introduction';
  //   }

Widget istStep(List list,List types){
  // print("......,,,,,..-----$types");
  return  Form(
    key: _formKey,
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal:15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //                 <--- border radius here
                   ),
                ),
                child:  ButtonTheme(
                  alignedDropdown: true,
                  child: Container(
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          selectedCategory != null ? selectedCategory : "categories".tr, 
                          style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                        ),
                        dropdownColor: AppColors.inPutFieldColor,
                        icon: Icon(Icons.arrow_drop_down),
                        items: types.map((coun) {
                          
                          return DropdownMenuItem(
                            value: coun,
                            child:Text(coun['category']['en'])
                          );
                        }).toList(),
                          onChanged: (val) {
                          var adCategory;
                          setState(() {
                            adCategory = val as Map;
                            selectedCategory = adCategory['category']['en'];
                            subtypeId = adCategory['id'];
                            type = adCategory['category_listing_types'];
                            selectedtype = 'Type';
                          });
                        },
                      )
                    ),
                  )
                )
              ),    
            SizedBox(height: 5.h,),
            Container(
                margin: const EdgeInsets.symmetric(horizontal:15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //                 <--- border radius here
                    ),
                ),
                child:  ButtonTheme(
                  alignedDropdown: true,
                  child: Container(
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          selectedtype != null ? selectedtype : 'type'.tr, 
                          style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                        ),
                        dropdownColor: AppColors.inPutFieldColor,
                        icon: Icon(Icons.arrow_drop_down),
                        items: type.map((coun) {
                          // print(".//./././././.....$coun");
                          return DropdownMenuItem(
                            value: coun,
                            child:Text(coun!['type']['en'])
                          );
                        }).toList(),
                          onChanged: (val) {
                          var adsubCategory;
                          setState(() {
                            adsubCategory = val as Map;
                            selectedtype = adsubCategory['type'][lang];
                            // subtypeId =adsubCategory['id'];
                            // print(subtypeId);
                            
                          });
                        },
                      )
                    ),
                  )
                )
              ),
              
           SizedBox(height: 5.h,),
           Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
               
                controller: titleController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 13,
                ),
                decoration:InputDecoration( 
                  hintText: "title".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
             Container(
                margin: const EdgeInsets.symmetric(horizontal:15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //                 <--- border radius here
                   ),
                ),
                child:  ButtonTheme(
                  alignedDropdown: true,
                  child: Container(
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          selectedStatus == null ? 'status'.tr : selectedStatus == '1' ? 'New': 'Old',
                          style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                        ),
                        dropdownColor: AppColors.inPutFieldColor,
                        icon: Icon(Icons.arrow_drop_down),
                        items: <String>['New','Old'].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child:Text(value)

                           
                          );
                        }).toList(),
                          onChanged: (value) {
                          
                          setState(() {
                           
                            selectedStatus = value;

                            value == 'New' ? selectedStatus = '1' : selectedStatus = '0' ;
                           
                            
                          });
                        },
                      )
                    ),
                  )
                )
              ),    
          SizedBox(height: 5.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,),
            color: AppColors.inPutFieldColor,
            child: TextFormField(
              maxLength: 300,
              maxLines: 2,
              controller: descController,
              textAlignVertical: TextAlignVertical.top,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold),
              decoration:InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 100.0),
                hintText: "description".tr,
                border: OutlineInputBorder( 
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              ) ,
            ),
           ),
            SizedBox(height: 5.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
                ),
                decoration:InputDecoration( 
                  hintText: "price".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 10.h,),
           Container(
            child: DottedBorder(
              dashPattern: [10,6],
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: Get.height/4.7,
                  width: Get.width/1.1,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: fileName != null ? Image.file(File(image),fit: BoxFit.fitWidth,width: Get.width/1.1,height: Get.height/4.7,): Image.asset(AppImages.uploadImage,height: 90,)),
                  ),
                ),
              ),
            ),
           ),
           SizedBox(height: 5.h,),
          ],
        ),
      )
    ],
  ),
);
}

Widget secondStep(){
  return Form(
    key: _formKey,
    child:Column(
      children: [
      SizedBox(height:10.h),
      Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: "full_name".tr,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: fullNameController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          //  TextInputType.number,
          isObscure: false,
          hintText: "mobile_no".tr,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: mobileNoController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: "Telephone_no".tr,
          hintStyle: TextStyle(fontSize: 13,fontWeight:FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: telePhoneController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:10.h),
        Container(
        margin:EdgeInsets.symmetric(horizontal: 20),
        width: Get.width * 0.9,
        child: CustomTextFiled(
          isObscure: false,
          hintText: "email".tr,
          hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          hintColor: AppColors.inputTextColor,
          onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          // isObscure: true,
          textController: emailController ,
          validator: (value) {  
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
          },
          errorText: 'Please Enter Full Name',  
        ),
        ),
        SizedBox(height:15.h),
      ],
    ) ,
    );
  } 
  
  Widget thirdStep(){
    return Column(
      children: [
        Image.file(File(image),fit: BoxFit.fill,width: Get.width/1.1,height: Get.height/4.7,),
        
        Card(
          child: Column(
            children: [
              Padding(
                 padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(titleController.text,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    Text(priceController.text,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                        SizedBox(height: 15.h,),
                         Text('Tilte'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text(titleController.text ,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 10.h),
                      // Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontW
                      SizedBox(height: 15.h,),
                       Text("Ad Number:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text(mobileNoController.text,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h,),
                       Text(selectedCategory != null ? selectedCategory : '',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text("MEDICAL SUPPLY",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h,),
                      
                    ],
                  ),
                   Container(
                     margin: EdgeInsets.only(right: 20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h,),
                        Text('type'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                        Text(selectedtype == null ? '': selectedtype,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        
                        SizedBox(height: 15.h,),
                       Text("Name",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 7.h),
                      Text(fullNameController.text,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                      SizedBox(height: 15.h),
                         Text('status'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 7.h),
                         Text(selectedStatus == '0'  ? uiStatus = 'Old':selectedStatus == '1'  ?'new': ' ' ,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                        SizedBox(height: 10.h),
                        
                      ],
                      ),
                   ),
                ],
              )
            ],
          ),
        ),
      Container(
        width: Get.width,
        child: Card(
          child:Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${"details".tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
              SizedBox(height:5.h),
              Text(descController.text,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
            ],
          ),
         ),
        ),
      ),
    ],
   ); 
  }
   Widget publishButton() {
    return Container(
       height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          print("..........");
        adpost();
        // Get.off(MyAdds());
        },
        child: Text("publish".tr),
      ),
    );
  }
   Widget saveAsDraftButton() {
    return Container(
       height: 40.h,
      width: 130.w,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () {
         adpost();
        },
        child: Text("save_as_draft".tr,textAlign: TextAlign.left,),
      ),
    );
  }
}
