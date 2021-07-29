import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';

class SignUp extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}
class _SignPageState extends State<SignUp> {

  TextEditingController fulNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final space20 = SizedBox(height: getSize(20, context));
    final space10 = SizedBox(height: getSize(10, context));
    return  Scaffold(
      appBar:
       PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar('',Icons.arrow_back_ios, AppImages.appBarLogo, )),
      body: Column(
        children: [
          space20,
          fullName(),
          space10,
          eMail(),
          space10,
          mobile(),
          space10,
          country(),
          space10,
          region(),
          space10,
          city(),
          space10,
          university(),
          space10,
          college(),
          space10,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Checkbox(
          //       focusColor: Colors.lightBlue,
          //       activeColor: Colors.blue,
          //       value: rememberMe,
          //       onChanged: (newValue) {
          //         setState(() => rememberMe = newValue);
          //       }
          //     ),
          //     Text('Accept Terms & Conditions', style: TextStyle(fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.w300),),
          //   ],
          // ),

        ],
      )
    );
  }

  Widget fullName() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.fullName,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
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
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
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
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          isObscure: true,
          textController: fulNameController,
          validator: (value) {  }, 
          errorText: '',
      ),
    );
  }

  Widget country() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.country,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
          onSaved: (String? newValue) {  }, 
          onFieldSubmitted: (value) {  }, 
          isObscure: true,
          textController: fulNameController,
          validator: (value) {  }, 
          errorText: '',
      ),
    );
  }

  Widget region() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.region,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

  Widget city() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.city,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }
  
  Widget university() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.university,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }

  Widget college() {
    return  Container(
      margin:EdgeInsets.only(left:20, right: 20),
      width: Get.width * 0.9,
      child: CustomTextFiled(
        hintText: AppString.college,
        hintStyle: TextStyle(fontSize: 13,),
        hintColor: AppColors.inputTextColor,
        onChanged: (value) {  },
        onSaved: (String? newValue) {  }, 
        onFieldSubmitted: (value) {  }, 
        isObscure: true,
        textController: fulNameController,
        validator: (value) {  }, 
        errorText: '',
      ),
    );
  }
}
 

