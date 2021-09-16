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
  final formKey = GlobalKey<FormState>();
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
  final con = Get.put(AdPostingController());
    // Pick an image
    XFile? pickedFile;
  late String image;
  var editImage;
  var fileName;
var id,cid,rid,crid , adID;
var uploadedImage;
var lang;
var editData;
var imageName;
var typeId;
  @override
  void initState() {
    super.initState();
    id = box.read('user_id');
    cid = box.read('city_id');
    rid = box.read('region_id');
    crid = box.read('country_id');
    lang = box.read('lang_code');
    editData = Get.arguments;
    
    if(editData != null ) {
      adID = editData['id'];
      print("......a......${editData['type']}");
      titleController = TextEditingController(text: editData['title'][lang]);
      selectedStatus =  editData['status'];
      descController =  TextEditingController(text: editData['description'][lang]);
      editImage = editData['image'].length != 0 ? editData['image'][0]['url']: null;     
      imageName =  editData['image'].length != 0 ?  editData['image'][0]['file_name']: null;
      priceController = TextEditingController(text: editData['price']);
      fullNameController = TextEditingController(text: editData['contact_name']);
      selectedCategory = editData['category']['category'][lang];
      subtypeId = editData['category_id'];
      typeId = editData['type_id'];
      selectedtype = editData['type'] == null ? 'Select Type' : editData['type']['type'][lang];
      emailController = TextEditingController(text: editData['contact_email']);
      telePhoneController = TextEditingController(text: editData['telephone']);
      mobileNoController = TextEditingController(text: editData['phone']);
    
    }
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
        // print('No image selected.');
      }
    });
    try {
      dio.FormData formData = dio.FormData.fromMap({          
        "file": await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
      });
      Get.find<AdPostingController>().uploadAdImage(formData);      
       uploadedImage  = Get.find<AdPostingController>().adUpload['name'];
    } catch (e) {
    }
     
  }
   adpost() async{ 
     var json = {
       'category_id' : subtypeId,
              'status': selectedStatus,
              'description': descController.text,
              'price': priceController.text,
              'contact_name': fullNameController.text,
              'phone': mobileNoController.text,
              'telephone': telePhoneController.text,
              'title':titleController.text,
              'created_by': id.toString(),
              'contact_email': emailController.text,
              'country_id': crid.toString(),
              'city_id':cid.toString(),
              'region_id': rid.toString(),
              'is_active' : 1,
              'type_id': typeId,
              'is_published':1,
              "image": imageName != null ? imageName : Get.find<AdPostingController>().adUpload['name'],
     };
     Get.find<AdPostingController>().finalAdPosting(json);
    //  if(pickedFile != null) {
    //     try {
    //       dio.FormData formData = dio.FormData.fromMap({            
    //          'category_id' : subtypeId,
    //           'status': selectedStatus,
    //           'description': descController.text,
    //           'price': priceController.text,
    //           'contact_name': fullNameController.text,
    //           'mobile_no': mobileNoController.text,
    //           'tel_no': telePhoneController.text,
    //           'title':titleController.text,
    //           'created_by': id.toString(),
    //           'email': emailController.text,
    //           'country_id': crid.toString(),
    //           'city_id':cid.toString(),
    //           'region_id': rid.toString(),
    //           "image": Get.find<AdPostingController>().adUpload['name'],            
    //       }); 
    //       print("add posting screen ...........>${ Get.find<AdPostingController>().adUpload['name']}");
    //       Get.find<AdPostingController>().finalAdPosting(formData); 
    //     } catch (e) {
    //         print("...............$e");
    //     }
    //   }
  
  }
  editpost() async{ 
     var json = {
       'category_id' : subtypeId,
              'status': selectedStatus,
              'description': descController.text,
              'price': priceController.text,
              'contact_name': fullNameController.text,
              'phone': mobileNoController.text,
              'telephone': telePhoneController.text,
              'title':titleController.text,
              // 'created_by': id.toString(),
              'email': emailController.text,
              'country_id': crid.toString(),
              'city_id':cid.toString(),
              'region_id': rid.toString(),
              'is_active' : 1,
              'type_id': typeId,
              'is_published':1,
              "image": imageName != null ? imageName : Get.find<AdPostingController>().adUpload['name'],
     };
     print("...............$json");
     Get.find<AdPostingController>().finalAdEditing(json,adID);
    //  if(pickedFile != null) {
    //     try {
    //       dio.FormData formData = dio.FormData.fromMap({            
    //          'category_id' : subtypeId,
    //           'status': selectedStatus,
    //           'description': descController.text,
    //           'price': priceController.text,
    //           'contact_name': fullNameController.text,
    //           'mobile_no': mobileNoController.text,
    //           'tel_no': telePhoneController.text,
    //           'title':titleController.text,
    //           'created_by': id.toString(),
    //           'email': emailController.text,
    //           'country_id': crid.toString(),
    //           'city_id':cid.toString(),
    //           'region_id': rid.toString(),
    //           "image": Get.find<AdPostingController>().adUpload['name'],            
    //       }); 
    //       print("add posting screen ...........>${ Get.find<AdPostingController>().adUpload['name']}");
    //       Get.find<AdPostingController>().finalAdPosting(formData); 
    //     } catch (e) {
    //         print("...............$e");
    //     }
    //   }
  
  }
   addraft() async{
     print(",.,.,.,.RRRR${fullNameController.text}");
     print(",.,.,.,.RRRR----${mobileNoController.text}");
     if(pickedFile != null) {
        try {
          dio.FormData formData = dio.FormData.fromMap({            
             'category_id' : subtypeId,
              'status': selectedStatus,
              'description': descController.text,
              'price': priceController.text,
              'contact_name': fullNameController.text,
              'phone': mobileNoController.text,
              'telephone': telePhoneController.text,
              'title':titleController.text,
              'created_by': id.toString(),
              'email': emailController.text,
              'country_id': crid.toString(),
              'city_id':cid.toString(),
              'region_id': rid.toString(),
              'is_published':0,
              "image":  Get.find<AdPostingController>().adUpload['name'],           
          }); 
          Get.find<AdPostingController>().finalAdDrafting(formData); 
        } catch (e) {
            print("...............$e");
        }
      }
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch,1)),
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
            // print("...................JJ ${val.datacateg}");
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
        style: ElevatedButton.styleFrom(
          primary: AppColors.appBarBackGroundColor
        ),
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
        child: Text('previousb'.tr),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Row(
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
      ),
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
  print("......,,,,,..-----$types");
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
                padding: const EdgeInsets.all(2.0),
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
                        hint: Container(
                            
                          child: Text(
                            selectedCategory != null ? selectedCategory : "categories".tr, 
                            style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                          ),
                        ),
                        dropdownColor: AppColors.inPutFieldColor,
                        icon: Icon(Icons.arrow_drop_down),
                        items: types.map((coun) {
                          return DropdownMenuItem(
                            value: coun,
                            child: 
                            Text(
                              coun['category']['en'] != null ?
                              coun['category']['en']:" ")
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
                            print(subtypeId);
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
                padding: const EdgeInsets.all(1.0),
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
                            selectedtype = adsubCategory['type']['en'];
                            print(selectedtype);
                             typeId =adsubCategory['id'];
                             print(typeId);
                            
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
                maxLength:20,
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
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "title".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
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

                            value == 'New'.tr ? selectedStatus = '1' : selectedStatus = '0' ;
                           
                            
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
              style: TextStyle(color:Colors.grey[400],fontSize: 18,fontWeight: FontWeight.bold),
              decoration:InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 100.0),
                hintText: "description".tr,
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey[400]),
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
                maxLength: 5,
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
                  contentPadding: EdgeInsets.only(left:15,right: 10,top:15),
                  hintText: "price".tr,
                  hintStyle: TextStyle(fontSize: 14,color: Colors.grey[400]),
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
                      child: fileName != null ? Image.file(File(image),fit: BoxFit.fitWidth,width: Get.width/1.1,height: Get.height/4.7,):  editImage != null ? Image.network(editImage,fit: BoxFit.fill,width: Get.width/1.1,height: Get.height/4.7,) : Image.asset(AppImages.uploadImage,height: 90,)),
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
      SizedBox(height: 5.h,),
           Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                controller: fullNameController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'enterSomeText'.tr;
                }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 13,
                ),
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "full_name".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
      SizedBox(height: 5.h,),
           Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                controller: mobileNoController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'enterSomeText'.tr;
                }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 13,
                ),
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "mobile_number".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
           Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                controller:  telePhoneController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'enterSomeText'.tr;
                }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 13,
                ),
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "telephone_numbers".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
           SizedBox(height: 5.h,),
           Container(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'enterSomeText'.tr;
                }
                  return null;
                },
                style: TextStyle(
                  color:AppColors.inputTextColor,fontSize: 13,
                ),
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
                  hintText: "emails".tr,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
           ),
           SizedBox(height: 5.h,),
      ],
    ) ,
    );
  } 
  
  Widget thirdStep(){
    print("IN THIRD STEP FILE NAME ---- $editImage");
    return Column(
      children: [
        fileName != null ?
        Image.file(File(image),fit: BoxFit.fill,width: Get.width/1.1,height: Get.height/4.7,): editImage != null ? Image.network(editImage,fit: BoxFit.fill,width: Get.width/1.1,height: Get.height/4.7,) : Container(),     
        Card(
          child: Column(
            children: [
              Padding(
                 padding: const EdgeInsets.only(top:10,left: 30,right: 30),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titleController.text,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                      Text("SAR ${priceController.text}",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // flex:1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 15.h,),
                          SizedBox(height: 15.h,),
                          Text('Tilte'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                          SizedBox(height: 7.h),
                          Text(titleController.text ,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                          // SizedBox(height: 10.h),
                          // Text(AppString.citystep,style: TextStyle(fontSize: 15,fontWeight:FontW
                          // SizedBox(height: 15.h,),
                          // Text("Ad Number:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                          // SizedBox(height: 7.h),
                          // Text(mobileNoController.text,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                          SizedBox(height: 15.h,),
                          Text("Category",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                          SizedBox(height: 7.h),
                          Text(selectedCategory != null ? selectedCategory : '',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                          SizedBox(height: 15.h,),
                          
                        ],
                      ),
                    ),
                     Container(
                      //  margin: EdgeInsets.only(right: 20),
                       child: Container(
                        //  flex: 1,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25.h,),
                            // Text('type'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                            // SizedBox(height: 7.h),
                            // Text(selectedtype == null ? '': selectedtype,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            // SizedBox(height: 15.h,),
                            Text("Name",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                             SizedBox(height: 5.h),
                           Text(fullNameController.text,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            SizedBox(height: 15.h),
                             Text('status'.tr,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                            SizedBox(height: 7.h),
                             Text(selectedStatus == '0'  ? uiStatus = 'Old':selectedStatus == '1'  ?'new': ' ' ,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            SizedBox(height: 15.h),
                            
                          ],
                          ),
                       ),
                     ),
                  ],
                ),
              )
            ],
          ),
        ),
      Container(
        width: Get.width,
        child: Card(
          child:Padding(
          padding: const EdgeInsets.only(top:15,left:50),
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
        primary: AppColors.appBarBackGroundColor,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          print("..........");
          editData == null ?
        adpost():editpost();
        // Get.off(MyAdds());
        },
        child: Text("publishb".tr),
      ),
    );
  }
   Widget saveAsDraftButton() {
    return Container(
       height: 40.h,
      width: 145.w,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        textStyle: TextStyle(
        fontSize: 13.w,
        fontWeight: FontWeight.bold)),
        onPressed: () {
         addraft();
        },
        child: Text("save_as_draft".tr,textAlign: TextAlign.left,),
      ),
    );
  }
}
