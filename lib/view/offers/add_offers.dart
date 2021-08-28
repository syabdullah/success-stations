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
import 'package:dio/src/response.dart' as response;

import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:dio/dio.dart' as dio;
// import 'package:validators/validators.dart';

class AddOffersPage extends StatefulWidget {
   AddOffersState createState() => AddOffersState();
}

class AddOffersState extends State<AddOffersPage> {
   final catogoryController = Get.put(CategoryController());
    final adpostingController = Get.put(AdPostingController());
    final addpostedControllerPut = Get.put(StorePostAddesController());

  int activeStep = 0;
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int upperBound = 3;  
  List list= [];
  List type = [];
  var selectedtype;
  var selectedCategory, hintLinkingId;
  var subtypeId;
  var statusSelected;
  final formKey = GlobalKey<FormState>();
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
   TextEditingController statusController = TextEditingController();

  var createdJson;
  GetStorage box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  late String image;
  var fileName, addedOfferImage;
  
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
       addedOfferImage  = Get.find<StorePostAddesController>().uploadImageOfAdd['name'];

        print(".......UPload image$addedOfferImage");

    } catch (e) {
    }
     
  }
  adOffersCreate() async {
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      if(pickedFile !=null) {
        try{
          dio.FormData formData = dio.FormData.fromMap({
            'category_id': idCategory,
            'description': descriptionController.text,
            'text_ads': titleController.text,
            'url': urlContr.text,
            'listing_id': hintLinkingId,
            'status': statusSelected,
            'image':Get.find<StorePostAddesController>().uploadImageOfAdd['name'],
          });
          //  print("add posting screen .....................................>${ Get.find<StorePostAddesController>().uploadImageOfAdd['name']}");
          Get.find<StorePostAddesController>().storefOffersAAll(formData); 
        }catch(e){}
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(50, context));
    final space15 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return Scaffold(
      appBar: AppBar( key: _scaffoldKey,backgroundColor:Colors.blue,title: Text('ADD OFFER'),centerTitle: true,),
      body: SingleChildScrollView(
        child:Form(
          key: formKey,
           child: Column(
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
              space15,
              status(),
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
            ]
          )
        )
      )
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
            return 'Title field required';
          }
          return null;
        },
        style: TextStyle(
          color:AppColors.inputTextColor,fontSize: 13,
        ),
        decoration:InputDecoration( 
          hintText: "Offer Title",
          hintStyle: TextStyle(fontSize: 13, color:Colors.grey[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );    
  }

  Widget status(){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal:15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0)
          ),
      ),
      child:  ButtonTheme(
        alignedDropdown: true,
        child: Container(
          width: Get.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  statusSelected == null ? 'status'.tr : statusSelected == '1' ? 'New': 'Old',
                  style: TextStyle(fontSize: 13, color: Colors.grey[800])
                ),
                dropdownColor: AppColors.inPutFieldColor,
                icon: Icon(Icons.arrow_drop_down),
                items: <String>['New','Old'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child:Text(
                      value, style: TextStyle(color: Colors.grey[800]),
                    )
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    statusSelected = value;
                    value == 'New' ? statusSelected = '1' : statusSelected = '0' ;
                  });
                },
              )
            ),
       
        )
      )
    );
  }
  

  Widget url() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15),
      child: TextFormField(
        // focusNode: FocusNode(),
        controller: urlContr,
        validator: (val) {
          String pattern = r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)'

;
          RegExp regExp = RegExp(pattern);
          if ( val == null || val.isEmpty ){
            return 'URL field is Required';
          }
          else if (!regExp.hasMatch(val)) {
            return "Enter Valid URL";
          }
          return null;
        },
        decoration:InputDecoration( 
          hintText: "URL",hintStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
          maxLines: 4,
          textAlignVertical: TextAlignVertical.top,
          focusNode: FocusNode(),   
          controller: descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description field required';
            }
            return null;
          },
          decoration:InputDecoration(
            contentPadding: EdgeInsets.only( left:10,top: 10, bottom :100),
            hintText: "Offer Description",
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
          Radius.circular(5.0)
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
                style: TextStyle(fontSize: 13, color: Colors.grey[700])
              ),
              dropdownColor: AppColors.inPutFieldColor,
              icon: Icon(Icons.arrow_drop_down),
              items: addedAddMine.map((adds) {
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
          Radius.circular(5.0)
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
                style: TextStyle(fontSize: 13, color: Colors.grey[700])
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
    padding: EdgeInsets.all(20),
    child: DottedBorder(
      color: AppColors.appBarBackGroundColor,
      strokeWidth: 1,
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