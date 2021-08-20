import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/banner_action.dart';

class BannerController extends GetxController {
   var isLoading = false;
   var bannerData; 
   var bannerArray= [];
     @override
  void onInit(){
    isLoading = true;
     bannerController();
    super.onInit();
  }

  bannerController() async {
    isLoading = true;
    await bannerAction().then((value){
    bannerData = jsonDecode(value.body);
    // print(bannerData);
    isLoading = false;
    // if(bannerData['data'] !=null || bannerData['data'].length !=null  ){
    //     for(int c =0; c <bannerData['data'].length; c++ ){
    //     bannerArray.add(bannerData['data'][c]);
    //   }
    // }
    // print(bannerData);

    });
    update();
  }
}