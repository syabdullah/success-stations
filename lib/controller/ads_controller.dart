

import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';

class AdsController extends GetxController {
  bool isLoading = false; 
  var adsCreate;
  

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  createAds(data) async{
    isLoading = true ;
    await createAdsAction(data).then((res) {
      adsCreate = jsonDecode(res.body);
      isLoading = false;
    });
    update();
  }

 
}