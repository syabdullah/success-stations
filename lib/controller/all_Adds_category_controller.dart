import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/ads_filtering_action.dart';
import 'package:success_stations/action/all_add_action.dart';
import 'package:success_stations/action/all_adds_category_action.dart';
import 'package:success_stations/styling/colors.dart';

class AddBasedController extends GetxController {
  bool isLoading = false; 
  var cData;
  var allAdsData;
  List catBaslistData = [];
  var adsFilterCreate;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  addedByIdAddes(id,userId) async{
    isLoading = true ;
    await basedAddById(id,userId).then((res) {
      cData = jsonDecode(res.body);
      isLoading = false;
    });
    update();
  }
  

  addedAllAds() async{
    isLoading = true ;
    await adsAll().then((res) {
      allAdsData = jsonDecode(res.body);
      isLoading = false;
    });
    update();
  }

  createFilterAds(data) async {
    isLoading = true;
    await createAdsFilteringAction(data).then((res) {
      adsFilterCreate = jsonDecode(res.body);
      print("................>>>#........................fikl................$adsFilterCreate");
      if(res.statusCode ==200||res.statusCode<  400){
      } if(res.statusCode > 400){
          Get.snackbar(adsFilterCreate['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
      }
      isLoading=false;
    });
    update();
  }
}