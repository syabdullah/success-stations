import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/my_adds/my_adds_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/store_offer_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:dio/src/response.dart' as response;
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:dio/dio.dart' as dio;

class AddOffersPage extends StatefulWidget {
   AddOffersState createState() => AddOffersState();
}

class AddOffersState extends State<AddOffersPage> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final catogoryController = Get.put(CategoryController());
    final adpostingController = Get.put(AdPostingController());
    final addpostedControllerPut = Get.put(StorePostAddesController());

  int activeStep = 0;
  int upperBound = 3;  
  final _formKey = GlobalKey<FormState>();
  List list= [];
  List type = [];
  var selectedtype;
  var selectedCategory, hintLinkingId;
  // var selectedSubCategory;
  var subtypeId;
  var selectedStatus;
  var uiStatus,  hintTextCate, hintLinking, idCategory;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController statusCont = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController urlContr = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController telePhoneController = TextEditingController();
  TextEditingController textAddsController = TextEditingController();
  var createdJson;
  GetStorage box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  late String image;
  var fileName;

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
      Get.find<StorePostAddesController>().uploadMyAdd(formData); 
    } catch (e) {}
  }

  adOffersCreate(){
    createdJson = {
    // 'image': fileName,
    'category_id': idCategory,
    'description': descriptionController.text,
    'text_ads': titleController.text,
    'url': urlContr.text,
    'listing_id': hintLinkingId,
    // 'status': 0
  };
  print("..................$createdJson");
  addpostedControllerPut.storefOffersAAll(createdJson);
  }
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(50, context));
    final space15 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blue,title: Text('MY OFFER'),centerTitle: true,),
      body: ListView(
        children: [
          space20,
          offerTitle(),
          space15,
          GetBuilder<OfferCategoryController>(
            init: OfferCategoryController(),
            builder: (val){
              return addsOffers(val.offeredList);
            },
          ),
          space15,
          offerDesc(),
          space15,
          url(),
          space15,
          GetBuilder<MyAddsAdedController>(
            init: MyAddsAdedController(),
            builder: (val){
              return 
              linkAdded(val.myMyAdd);

            },
          ),
          // linkAdded(),
          space15,
          roundedRectBorderWidget,
          space10,
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: "PUBLISH",
            callback: adOffersCreate,
          ),
          space20,
        ],
      ),
    );
  }
  Widget offerTitle(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15),
      child: TextFormField(
        focusNode: FocusNode(),   
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
          hintText: "Offer Title",
          hintStyle: TextStyle(fontSize: 13, color:Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );    
  }

  Widget url() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15),
      child: TextFormField(
        focusNode: FocusNode(),
        // keyboardType: TextInputType.number,
        controller: urlContr,
        validator: (value) {
        if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        // style: TextStyle(
        //   color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
        // ),
        decoration:InputDecoration( 
          hintText: "URL",hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ) ,
      ),
    );
  }

Widget offerDesc(){
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal:15,),
        color: AppColors.inPutFieldColor,
        child: TextFormField(
          focusNode: FocusNode(),   
          controller: descriptionController,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          // style: TextStyle(color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold),
          decoration:InputDecoration(
            contentPadding: EdgeInsets.only( left:10,top: 10, bottom :100),
            hintText: "Offer Description",
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey,),
            border: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ) ,
        ),
      ),

    ],
  );
}
   Widget linkAdded(List addedAddMine){
    return  Container(
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
                hintLinking != null ? hintLinking: 'Link To Listing Adds',
                style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: addedAddMine.map((adds) {
                print(",,,,,,,,,,,addds of dropdown........$adds");
                return DropdownMenuItem(
                  value: adds,
                  child:Text(
                    adds['title']['en'],
                  )
                );
              }).toList(),
              onChanged: (value) {
                var addsMapByMyAdds;
                setState(() {
                  addsMapByMyAdds = value as Map;
                  hintLinking = addsMapByMyAdds['title']['en'];
                  hintLinkingId = addsMapByMyAdds['id'];
                });
              },
            )
          ),
        )
      )
    );
}

  Widget addsOffers(List dataListedCateOffer){
    return  Container(
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
                hintTextCate != null ? hintTextCate: 'Offer Category',
                style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: dataListedCateOffer.map((countee) {
                return DropdownMenuItem(
                  value: countee,
                  child:Text(countee['category_name']['en'])
                );
              }).toList(),
              onChanged: (value) {
                var mappCatrgory;
                setState(() {
                  mappCatrgory = value as Map;
                  hintTextCate = mappCatrgory['category_name']['en'];
                  idCategory =  mappCatrgory['id'];
                });
              },
            )
          ),
        )
      )
    );
}
 Widget get roundedRectBorderWidget {
  return Container(
    padding: EdgeInsets.all(20), //padding of outer Container
    child: DottedBorder(
      color: AppColors.appBarBackGroundColor,
      strokeWidth: 1, //thickness of dash/dots
      dashPattern: [10,6], 
      child: Column(
        children: [
          Container(
            height:180,
            width: double.infinity,
            color:Colors.grey[100] ,
            child: GestureDetector(
              onTap: (){
                getImage();
              },
              child: Center(
                child: fileName !=null ? Image.file(File(image), fit:BoxFit.fitWidth, width:Get.width/1.1, height: Get.height/4.7):
                Image.asset(AppImages.addOfferImage, height:90
                )
              )
            )
          ),
          
        ],
      ),
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