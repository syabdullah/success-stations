import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/aboutController.dart';
import 'package:success_stations/controller/adwithus_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/utils/page_util.dart';
import 'package:success_stations/view/ads.dart';
import 'package:success_stations/view/auth/forgot/forgot_code.dart';

class AdvertisePage extends StatefulWidget {
  AdvertiseStatePage createState() => AdvertiseStatePage();
}
class AdvertiseStatePage extends State<AdvertisePage> {
  
    FocusNode textSecondFocusNode = new FocusNode();
   final adwithme = Get.put(AdWithUsController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController writeController = TextEditingController();
   FocusNode ? pin2node;
  FocusNode ? pin3node;
  FocusNode ? pin4node;
  clearTextInput(){
   nameController.clear();
   phoneController.clear();
   writeController.clear();
 
  }
   void dispose() {
    pin2node!.dispose();
    pin3node!.dispose();
    pin4node!.dispose();
    super.dispose();
  }
  final formKey = new GlobalKey<FormState>();
  var json;
  mydata(){
     final form = formKey.currentState;
    if(form!.validate()){
      form.save();
    json = {
      'name':nameController.text,
      'phone':phoneController.text,
      'description':writeController.text

    };
    adwithme.sendingAdsWithUs(json);
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
        //  padding:EdgeInsets.only(top:8)R,
         child: stringAppbar(context,Icons.arrow_back_ios_new_sharp, 'ADVERTISE WITH US',AppImages.appBarSearch)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GetBuilder<ContentManagmentController>( 
          init: ContentManagmentController(),
          builder:(val) {
            return val.aboutData != null  ? text(val.aboutData['data']) : Center(child: CircularProgressIndicator());
    
          }   
     ),
              space50, 
              // Container(
              //   margin: EdgeInsets.only(top: 60),
              //   child: Center(
              //     child: Image.asset(
              //       AppImages.appLogo, height: Get.height / 4.40
              //     ),
              //   ),
              // ),
              // space10,
              // text(),
              // space50,
              name(),
              space20,
              phoneNumber(),
              space20,
              textArea(),
              space20,
              Container(
                height: 50,
                width: 300,
                child: RaisedButton(
                  onPressed: (){
                    mydata();
                    clearTextInput();
                  },
                  color: AppColors.appBarBackGroundColor,
                  textColor: Colors.white,
                  child: Text('send'.tr),
                ),
              ),
              // submitButton(
              //   bgcolor: AppColors.appBarBackGroundColor,  
              //   textColor: AppColors.appBarBackGroun,
              //   buttonText: "send".tr,
              //   fontSize: 18.toDouble(),
              //   callback: mydata()
              // ),
            ],
          ),
        ),
      ),
    );
  }
  Widget name (){
    return Container(
       margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: TextFormField(
                focusNode:pin2node,
                controller: nameController,
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
                  hintText: "name".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ) ,
            ),
    );
  }
  // Widget name() {
  //   return Container(
  //     margin:EdgeInsets.only(left:20, right: 20),
  //     width: Get.width * 0.9,
  //     child: CustomTextFiled(
  //       isObscure: false,
  //       hintText:"name".tr,
  //       hintStyle: TextStyle(fontSize: 13, color: AppColors.forgotPassText),
  //       hintColor: AppColors.textInput,
  //       onChanged: (value) {  },
  //       onSaved: (String? newValue) {}, 
  //       onFieldSubmitted: (value) { },
  //       textController: nameController,
  //       validator: (value) => value.isEmpty ? 'Enter The Name':null,
  //       errorText: '',
  //     ),
  //   );
  // }
  Widget text(data) {
    return
  Container(
    height:Get.height/2.5,
    child: ListView.builder(
    itemCount:  data.length!= null ? data.length : Container(),
    // ignore: non_constant_identifier_names
    itemBuilder: (BuildContext,index) {
      
      return 
      index == 1 ?
       Padding(
         padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
         
         child:Html(data: data[index]['page_text']),
        //     child: Text(data[index]['page_text'],textAlign: TextAlign.center,
        //     style: AppTextStyles.appTextStyle(
        //     fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
        //  ),),
        )
        :Container();
      }
     ),
  );
 
  }
  Widget phoneNumber() {
    return Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child:  TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 13,
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
    width:Get.width/1.0,
    margin:EdgeInsets.only(left:20, right: 20),
    child:  TextFormField(
        maxLines: 3,
          focusNode:pin4node,
          controller: writeController,
          validator: (value) {
          if (value == null || value.isEmpty) {
              return 'add description';
            }
            return null;
          },
          style: TextStyle(
            color:AppColors.inputTextColor,fontSize: 18,fontWeight: FontWeight.bold
          ),
          decoration:InputDecoration( 
            hintText: "description".tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey),
          ),
        ) ,
      ),
  );
 }
}