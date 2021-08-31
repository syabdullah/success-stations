import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';

class MyOffersDrawerController extends GetxController {
  // bool isLoading = false; 
  var myofferListDrawer;
   var result = true;
  var resultInvalid = false.obs;
  bool isLoading = false;

  drawerMyOffer() async{
    print("offer list Api ....................... ");
    isLoading = true;
    await myOffers().then((res) {
      myofferListDrawer = jsonDecode(res.body);
        if (res.statusCode == 200 || res.statusCode < 400) {
          resultInvalid(false);
          isLoading = false;
        } else if (myofferListDrawer['success'] == false) {
        resultInvalid(true);
        isLoading = false;
      }
    });
    update();
  }
}