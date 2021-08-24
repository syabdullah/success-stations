import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';

class MyOffersDrawerController extends GetxController {
  bool isLoading = false; 
  var myofferListDrawer;

   @override
  void onInit(){
    isLoading = true;
    drawerMyOffer();
    super.onInit();
  }

  drawerMyOffer() async{
    print("offer list Api ....................... ");
    isLoading = true;
    await myOffers().then((value) {
      myofferListDrawer = jsonDecode(value.body);
      print("1----------2-------------3---------------------4---------------------$myofferListDrawer");
      isLoading = false;
    });
    update();
  }
}