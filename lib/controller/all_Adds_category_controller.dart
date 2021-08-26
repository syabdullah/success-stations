import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/all_add_action.dart';
import 'package:success_stations/action/all_adds_category_action.dart';

class AddBasedController extends GetxController {
  bool isLoading = false; 
  var cData;
  var allAdsData;
  List catBaslistData = [];

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  addedByIdAddes(id,userId) async{
    isLoading = true ;
    await basedAddById(id,userId).then((res) {
      cData = jsonDecode(res.body);
       print("/////////junaid////////// json response .........................>>>>$cData");
      isLoading = false;
    });
    update();
  }
  

  addedAllAds() async{
    isLoading = true ;
    await adsAll().then((res) {
      allAdsData = jsonDecode(res.body);
      print("?//////////////////???????????");
      isLoading = false;
    });
    update();
  }
}