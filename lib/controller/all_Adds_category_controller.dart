import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/ad_post_action.dart';
import 'package:success_stations/action/ads_filtering_action.dart';
import 'package:success_stations/action/all_add_action.dart';
import 'package:success_stations/action/all_adds_category_action.dart';
import 'package:success_stations/action/my_adds/my_add_action.dart';

class AddBasedController extends GetxController {
  bool isLoading = false; 
  var cData;
  var allAdsData;
  var resultInvalid = false.obs;
  List catBaslistData = [];
  var adsFilterCreate;
  var myALLAdd;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  addedByIdAddes(id,userId) async{
    isLoading = true ;
    await basedAddById(id,userId).then((res) {
      cData = jsonDecode(res.body);   
      print("c data Response.......$cData");
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
   

    addesMyListAll() async{
      isLoading = true;
      await addsFvrtMyAdds().then((value) {
        myALLAdd= jsonDecode(value.body);
        print("................>>>#........................fikl................$myALLAdd");
        if(value.statusCode == 200 || value.statusCode < 400){
          resultInvalid(false);
          isLoading = false;
        }
        else if(myALLAdd['success'] == false){
          resultInvalid(true);
          isLoading = false;

        }
        isLoading = false;
      });
      update();
  }


  createFilterAds(data) async {
    isLoading = true;
    await createAdsFilteringAction(data).then((res) {
      adsFilterCreate = jsonDecode(res.body);
      isLoading = false;
     
      if(res.statusCode ==200||res.statusCode <  400){
        resultInvalid(false);
         isLoading = false;
      } if(adsFilterCreate['success'] == false){
          resultInvalid(true);
          isLoading = false;
      }
      // isLoading=false;
    });
    update();
  }

   activeAd(dataa) async {
     print("..........'''''$dataa");
     isLoading = true;
     await adActive(dataa).then((res) {    
      var adact = jsonDecode(res.body);
    
      print(res.statusCode);
        print(adact);
     });
     update();
   }
    deactiveAd(dataa) async {
     print("..........'''''$dataa");
     isLoading = true;
     await adDeActive(dataa).then((res) {    
      var addct = jsonDecode(res.body);
      print(res.statusCode);
        print(addct);
     });
     update();
   }
}