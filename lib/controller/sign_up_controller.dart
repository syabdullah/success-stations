import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_up_action.dart';
import 'package:success_stations/utils/snack_bar.dart';
import 'package:success_stations/view/auth/sign_in.dart';

class SignUpController extends GetxController{
  bool isLoadingg = false;
  var signup, indiviualSignup, companySignUp;
  var result = false;
  var resultInvalid = false.obs;
   RxBool isLoading = false.obs;
  GetStorage box = GetStorage();

  createAccountData(data) async{
    isLoading(true);
    await createAccount(data).then((res){
      signup = jsonDecode(res.body);
      print("................$signup");
      if(res.statusCode == 200 || res.statusCode < 400){
        resultInvalid(false);
        isLoading(false);
        Get.offAndToNamed('/login');
        SnackBarWidget().showToast("",signup['message'] );
      }
      else if(res.statusCode > 400){
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();

  }

  individualAccountData(data) async{
    isLoading(true);
    await individualUser(data).then((res){
      indiviualSignup = jsonDecode(res.body);
      if(res.statusCode == 200 || res.statusCode < 400){
        resultInvalid(false);
        isLoading(false);
        Get.offAndToNamed('/login');
        SnackBarWidget().showToast("", indiviualSignup['message']);  
      }
      else if(res.statusCode > 400){
         print("......... 400");
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }

  companyAccountData(data) async{
    print("........////....;;;;;;;;;;;;");
    isLoading(true);
    await companyUser(data).then((res){
      companySignUp = jsonDecode(res.body);
      if(res.statusCode == 200 ||res.statusCode < 400 ){
        resultInvalid(false);
        isLoading(false);
        Get.offAndToNamed('/login');
        SnackBarWidget().showToast("", companySignUp['message']);  
      }
      else if(res.statusCode > 400){
        print("......... 400");
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }
}