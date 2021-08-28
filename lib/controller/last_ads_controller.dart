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
    print("controller call of the Favorite list");
    isLoading = true;
    await lastAds(id).then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      lastuserads = jsonDecode(value.body);
      print("hehehhehehhehehehheheheheh $lastuserads");
      isLoading = false;
    });
    update();
  }
}