

import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';
import 'package:success_stations/controller/favorite_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/snack_bar.dart';

class RemoveController extends GetxController{
    // final remoControllerFinal = Get.put(RemoveController());
   final fContr = Get.put (FavoriteController());
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
      if(res.statusCode == 200 ||res.statusCode < 400 ){
        print("!!!!!!!!!!!!!!!!!!!!!!>>>>>>>>>>!!!!!!!!!!!!!!!!$id .............>>>>${res.body}");
        removingList = jsonDecode(res.body);
        print("remove adds ..........remove adds......$removingList");
        if(removingList['success']== true){
          Get.snackbar(removingList['message'],'',backgroundColor: AppColors.appBarBackGroundColor);
          fContr.favoriteList();
          isLoading = false;

        }

      }
      
      
      
    });
    update();
  } 

}
  