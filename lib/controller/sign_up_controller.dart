import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_up_action.dart';
import 'package:success_stations/view/auth/sign_in.dart';

class SignUpController extends GetxController{
  bool isLoading = false;
  var signup;
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
        print("res.statuscode.............${res.statusCode}");
        signup = jsonDecode(res.body);
        print("sign up ..............$signup");
        isLoading = false;
        Get.to(SignIn());
      }
    });
     update();

  }
}