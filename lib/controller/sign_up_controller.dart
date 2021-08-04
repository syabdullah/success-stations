import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_up_action.dart';
import 'package:success_stations/utils/snack_bar.dart';
import 'package:success_stations/view/auth/sign_in.dart';

class SignUpController extends GetxController{
  bool isLoading = false;
  var signup, indiviualSignup, companySignUp;
  var result = false;
  GetStorage box = GetStorage();

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  createAccountData(data) async{
    isLoading = true;
    await createAccount(data).then((res){
      if(res.statusCode == 422|| res.statusCode == 401) {
      }else if(res.statusCode == 200){
        signup = jsonDecode(res.body);
        // if(signup['success'] == true){

        //   SnackBarWidget().showToast("", "Email has been sent to you successfully");  
        // }
        isLoading = false;
        Get.to(SignIn());
      }
    });
     update();

  }
  individualAccountData(data) async{
    isLoading = true;
    await individualUser(data).then((res){
      if(res.statusCode == 422|| res.statusCode == 401) {
      }else if(res.statusCode == 200){
        indiviualSignup = jsonDecode(res.body);
        if(indiviualSignup['success'] == true){
          SnackBarWidget().showToast("", indiviualSignup['message']);  
        }
        
      }
      isLoading = false;
        Get.to(SignIn());
    });
    update();
  }

  companyAccountData(data) async{
    isLoading = true;
    await companyUser(data).then((res){
      if(res.statusCode == 422|| res.statusCode == 401) {
      }else if(res.statusCode == 200){
        companySignUp = jsonDecode(res.body);
        if(companySignUp['success'] == true){
          SnackBarWidget().showToast("", companySignUp['message']);  
        }
      }
      isLoading = false;
      Get.to(SignIn());
    });
    update();
  }
}