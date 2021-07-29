import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_up_action.dart';

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
        print("res . of . status.code  422 .....................${res.statusCode}");
      }else if(res.statusCode ==200){
        print("status cose of 20000000000000 ............... ${res.statusCode}");
        result = true;
        update();  
        signup = jsonDecode(res.body);
        print("/.............>ignUp............$signup");
        isLoading = false;
         result = true;
      }
      
    });

  }
}