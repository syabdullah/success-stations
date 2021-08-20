import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offer_list_action.dart';

class OfferController extends GetxController {
  bool isLoading = false; 
  var offerDataList;

  @override
  void onInit(){
    isLoading = true;
    offerList();
    super.onInit();
  }

  offerList() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await allOffers().then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      offerDataList = jsonDecode(value.body);
      print("json decode response of offer.......>$offerDataList");
      isLoading = false;
    });
    update();
  }
}