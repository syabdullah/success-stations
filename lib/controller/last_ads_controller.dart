import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/last_ads_action.dart';

class LastAdsController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var lastuserads;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  userOfferList(id) async{
    isLoading = true;
    await lastAds(id).then((value) {
      lastuserads = jsonDecode(value.body);
      isLoading = false;
    });
    update();
  }
}