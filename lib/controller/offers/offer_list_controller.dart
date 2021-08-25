import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';

class OfferController extends GetxController {
  bool isLoading = false; 
  var offerDataList, myofferListDrawer;

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
      print("....!!!!!...!!!!...!!!!!.....1111..........$offerDataList");
      isLoading = false;
    });
    update();
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