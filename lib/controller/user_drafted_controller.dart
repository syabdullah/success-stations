import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/drafted_action.dart';
import 'package:success_stations/styling/colors.dart';

class DraftAdsController extends GetxController {

  bool isLoading = false; 
  var userData;
    var userDataP;
    @override
  void onInit(){
    isLoading = true;
    super.onInit();
    getDraftedAds();
  }
  getDraftedAds() async{
    isLoading = true ;
    await draftAdsAction().then((res) {
      print(">>>>>>>>>>>>>!!!!!!!!!!!!!!!!$res");
      userData = jsonDecode(res.body);
      isLoading = false;
      print("////////////////////////////////    $userData");
    });
    update();
  }

   getDraftedAdsOublished(id) async{
    isLoading = true ;
    await draftAdsPublished(id).then((res) {
      print(">>>>>>>>>>>>>!!!!!!!!!!!!!!!!$res");
      userDataP = jsonDecode(res.body);
      if(res.statusCode == 200 || res.statusCode < 400) {
      getDraftedAds();
      isLoading = false;
        Get.snackbar(userDataP['message'],'',backgroundColor: AppColors.appBarBackGroundColor);
      print("////////////////////////////////    $userDataP");
      }
    });
    update();
  }
}
