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

  addedByIdAddes(id) async{
    isLoading = true ;
    await basedAddById(id).then((res) {
      cData = jsonDecode(res.body);
      print("/////////////////// json response .........................>>>>$cData");
      // if(cData['data'].length !=null){
      //   for( int ci =0; ci < cData['data'].length; ci++){
      //     catBaslistData.add(cData['data'][ci]);
      //   }
      // }
      isLoading = false;
    });
    update();
  }
  

  addedAllAds() async{
    isLoading = true ;
    await adsAll().then((res) {
      allAdsData = jsonDecode(res.body);
      print("/////////////////// json response .........................>>>>$allAdsData");
      isLoading = false;
    });
    update();
  }
}