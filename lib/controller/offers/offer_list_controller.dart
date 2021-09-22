import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';
import 'package:success_stations/view/auth/sign_in.dart';

class OfferController extends GetxController {
  bool isLoading = false; 
  var offerDataList, myofferListDrawer;
  var resultInvalid = false.obs; 

  @override
  void onInit(){
    isLoading = true;
    offerList();
    super.onInit();
  }

  offerList() async{
    isLoading = true;
    await allOffers().then((value) {
      offerDataList = jsonDecode(value.body);
      print("........ offer Datta List...$offerDataList");
      if(value.statusCode == 200 || value.statusCode <400){
        // offerDataList = jsonDecode(value.body);
        resultInvalid(false);
        isLoading = false;
      }
      else if(offerDataList['success'] == false){
      resultInvalid(true);
      isLoading = false;

    }
    // if(offerDataList['message'] == 'Unauthenticated.'){
    //    Get.offAll(SignIn());
    //   }
    //   isLoading = false;
    });
    update();
  }

  drawerMyOffer() async{
    isLoading = true;
    await myOffers().then((value) {
      myofferListDrawer = jsonDecode(value.body);
      isLoading = false;
    });
    update();
  }
}