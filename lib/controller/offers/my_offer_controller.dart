import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';

class MyOffersDrawerController extends GetxController {
  // bool isLoading = false; 
  var myofferListDrawer;
   var result = true;
  var resultInvalid = false.obs;
  bool isLoading = false;

  //  @override
  // void onInit(){
  //   isLoading = true;
  //   drawerMyOffer();
  //   super.onInit();
  // }

  drawerMyOffer() async{
    print("offer list Api ....................... ");
    isLoading = true;
    await myOffers().then((res) {
      myofferListDrawer = jsonDecode(res.body);
        if (res.statusCode == 200 || res.statusCode < 400) {
          resultInvalid(false);
        isLoading = false;
        // Get.offAllNamed('/tabs');
      print("1----------2-------------3---------------------4---------------------$myofferListDrawer");
      } else if (myofferListDrawer['success'] == false) {
        resultInvalid(true);
        isLoading = false;
      }
    });
    update();
  }
}