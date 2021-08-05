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
      print("........////....${res.body}");
       if(res.statusCode == 200 || res.statusCode < 400){

        signup = jsonDecode(res.body);
        isLoading = false;
        Get.to(SignIn());
        if(signup['success'] == true){
          SnackBarWidget().showToast("",signup['message'] );  
        }
        
      }
    });
     update();

  }
  individualAccountData(data) async{
    isLoading = true;
    await individualUser(data).then((res){
       if(res.statusCode == 200 || res.statusCode < 400){
        indiviualSignup = jsonDecode(res.body);
        isLoading = false;
        Get.to(SignIn());
        if(indiviualSignup['success'] == true){
          SnackBarWidget().showToast("", indiviualSignup['message']);  
        }
        
      }
    });
    update();
  }

  companyAccountData(data) async{
     print("........////....;;;;;;;;;;;;");
    isLoading = true;
    await companyUser(data).then((res){
       if(res.statusCode == 200 ||res.statusCode < 400 ){
        companySignUp = jsonDecode(res.body);
        print("........////....${res.body}");
        isLoading = false;
        Get.to(SignIn());
        if(companySignUp['success'] == true){
          SnackBarWidget().showToast("", companySignUp['message']);  
        }
      }
    });
    update();
  }
}