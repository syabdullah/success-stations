import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/user_profile_action.dart';

class UserProfileController extends GetxController {

  bool isLoading = false; 
  var userData;
  GetStorage box = GetStorage();
    @override
  void onInit(){
    isLoading = true;
    super.onInit();
    getUserProfile();
  }
  getUserProfile() async{
    isLoading = true ;
    await userProfileAction().then((res) {
      print(">>>>>>>>>>>>>!!!!!!!!!!!!!!!!$res");
      userData = jsonDecode(res.body);
      box.write('user_image',userData['data']['image']);
    
      isLoading = false;
      print("////////////////////////////////    $userData");
    });
    update();
  }
}
