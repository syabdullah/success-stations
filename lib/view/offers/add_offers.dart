import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/images.dart';

class AddOffersPage extends StatefulWidget {
   AddOffersState createState() => AddOffersState();
}

class AddOffersState extends State<AddOffersPage> {
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
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(50, context));
    final space10 = SizedBox(height: getSize(10, context));
    return Scaffold(
       appBar: AppBar(backgroundColor:Colors.blue,title: Text('MY OFFER'),centerTitle: true,),
      body: ListView(
        children: [
          space20,
          addsOffers(),
          space10,
          roundedRectBorderWidget,
          space10,
          submitButton(
            bgcolor: AppColors.appBarBackGroundColor,  
            textColor: AppColors.appBarBackGroun,
            buttonText: "PUBLISH"
          ),
          space20,
        ],
      ),
    );
  }




 Widget addsOffers(){
  return  Form(
    key: _formKey,
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
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
                    hintText: "Offer Title",
                    hintStyle: TextStyle(fontSize: 13, color:Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
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
                          'Offer Category',
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
                        onChanged: (value) {},
                      )
                    ),
                  )
                )
              ),    
              SizedBox(height: 15.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal:15,),
                color: AppColors.inPutFieldColor,
                child: TextFormField(
                  controller: descController,
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
              SizedBox(height: 15.h,),
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
              ),
              SizedBox(height: 15.h,),
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
                          'Link To Listing Ads',
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
                          onChanged: (value) {},
                      )
                    ),
                  )
                )
              ),    
            SizedBox(height: 5.h,),
          ],
        ),
      )
    ],
  ),
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
              onTap: (){},
              child: Center(
                child: Image.asset(AppImages.addOfferImage, height:90
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