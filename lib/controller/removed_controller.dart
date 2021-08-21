

import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';
import 'package:success_stations/utils/snack_bar.dart';

class RemoveController extends GetxController{
  bool isLoading = false; 
  var regionData;
  var removingList;
  
  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

    removedAddsUnFvr8(id) async{
    print(".........remove.......profileAdsRemove....profileAdsRemove....profileAdsRemove......App.........$id");
    isLoading = true ;
    await removeAdsFav(id).then((res) {
      print("!!!!!!!!!!!!!!!!!!!!!!>>>>>>>>>>!!!!!!!!!!!!!!!!$id .............>>>>${res.body}");
      removingList = jsonDecode(res.body);
      print("remove adds ..........remove adds......$removingList");
      // if(removingList['success'] == true) {
      //   print(".....!!!!!!!!!!!!!!!!!!!!!!if Condition");
      //   // if(userId !=null)
      //   // profileAds(userId);
      //   SnackBarWidget().showToast("", removeAds['message']); 
      // }
      // Get.off(repetedCon);
      //  print("/././././.-----$userAds");
      isLoading = false;
    });
    update();
  } 

}
  