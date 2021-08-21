import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_list_action.dart';

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
    isLoading = true;
    await allOffers().then((value) {
      offerDataList = jsonDecode(value.body);
      isLoading = false;
    });
    update();
  }
}