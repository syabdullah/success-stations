import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/contact_us_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';

class Contact extends StatefulWidget {
  ContactPageState createState() => ContactPageState();
}
class ContactPageState extends State<Contact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController writeController = TextEditingController();
    clearTextInput(){
   nameController.clear();
   phoneController.clear();
   writeController.clear();
 
  }
   FocusNode ? pin2node;
  FocusNode ? pin3node;
  FocusNode ? pin4node;
  FocusNode textSecondFocusNode = new FocusNode();
  final formKey = new GlobalKey<FormState>();
   final contactwithme = Get.put(ContactWithUsController());
   final banner = Get.put(BannerController());
  var json;
  void contactUsData(){
      final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      json = {
        'name' : nameController.text,
        'phone': phoneController.text,
        'description': writeController.text,
      };
      contactwithme.contactWithUs(json);
       print('${nameController.text}',);
  }
  }
  @override
  Widget build(BuildContext context) {
    final space10 = SizedBox(height: getSize(10, context));
    final space20 = SizedBox(height: getSize(20, context));
    final space50 = SizedBox(height: getSize(50, context));
    return Scaffold(
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),    
       child: Container(
        //  padding:EdgeInsets.only(top:8)R,
         child: stringAppbar(context,Icons.arrow_back_ios_new_sharp, 'CONTACT US',AppImages.appBarSearch)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              space50, 
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo, height: Get.height / 4.40
                  ),
                ),
              ),
              space10,
              name(),
              space20,
              phoneNumber(),
              space20,
              textArea(),
              space20,
              submitButton(
                bgcolor: AppColors.appBarBackGroundColor,  
                textColor: AppColors.appBarBackGroun,
                buttonText: AppString.send,
                fontSize: 18.toDouble(),
                callback: (){
                  contactUsData();
                  clearTextInput();
                  // if(contactwithme.responses < 400 ){
                }
                  // }
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget name() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child:  TextFormField(
      
                  focusNode:pin2node,
                  controller: nameController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
                  ),
                  decoration:InputDecoration( 
                    hintText: "name".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                  ),
                ) ,
              ),
    );
  }

 Widget phoneNumber() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child:  TextFormField(
      
                  focusNode:pin3node,
                  controller: phoneController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                      return 'Please enter Phone Number';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
                  ),
                  decoration:InputDecoration( 
                    hintText: "phone".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                  ),
                ) ,
              ),
    );
  }

  Widget textArea() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child:  TextFormField(
          maxLines: 3,
          focusNode:pin4node,
          controller: writeController,
          validator: (value) {
          if (value == null || value.isEmpty) {
              return 'please write somethingr';
            }
            return null;
          },
          style: TextStyle(
            color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
          ),
          decoration:InputDecoration( 
            hintText: "Write here".tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey),
          ),
        ) ,
      ),
    );
  }

  //  }
   Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor,image}) {
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
      width: width,  
    );
  }
}
 