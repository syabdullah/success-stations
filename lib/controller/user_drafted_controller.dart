import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/drafted_action.dart';

class DraftAdsController extends GetxController {

  bool isLoading = false; 
  var userData;
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
}
