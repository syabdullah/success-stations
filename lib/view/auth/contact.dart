import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  FocusNode textSecondFocusNode = new FocusNode();
  final formKey = new GlobalKey<FormState>();
   final contactwithme = Get.put(ContactWithUsController());
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
      appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),    
      child: Container(
      //  padding:EdgeInsets.only(top:8),
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
                callback: (){contactUsData();}
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
      child: CustomTextFiled(
        isObscure: false,
        hintText:AppString.name,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.forgotPassText),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: nameController,
         validator: (value) => value!.isEmpty ? 'Enter some text':null,
        errorText: '',
      ),
    );
  }
  Widget phoneNumber() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        isObscure: false,
        hintText:AppString.phoneNumber,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.forgotPassText),
        hintColor: AppColors.textInput,
        onChanged: (value) {  },
        onSaved: (String? newValue) {}, 
        onFieldSubmitted: (value) { },
        textController: phoneController,
        validator: (value) => value!.isEmpty ? 'Enter some text':null,
        errorText: '',
      ),
    );
  }

  Widget textArea() {
  final maxLines = 5;

  return Container(
    width:Get.width/1.0,
    margin: EdgeInsets.all(12),
    height: maxLines * 24.0,
    child: TextFormField(
      validator: (value) => value!.isEmpty ? 'Enter some text':null,
      controller: writeController,
      maxLines: maxLines,
      decoration: InputDecoration(
        focusColor: Colors.grey,
         border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        hintText: "Write here", hintStyle: TextStyle(color:Colors.grey),
        fillColor:AppColors.inputColor,
        filled: true,
      ),
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
 