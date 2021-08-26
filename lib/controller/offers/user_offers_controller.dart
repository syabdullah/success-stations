import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_category_action.dart';
import 'package:success_stations/action/offers/user_offer_action.dart';

class UserOfferController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var offerDattaTypeCategory;

  @override
  void onInit(){
    isLoading = true;
    userOfferList();
    super.onInit();
  }

  userOfferList() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await userOffers().then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      offerDattaTypeCategory = jsonDecode(value.body);
      print("hehehhehehhehehehheheheheh $offerDattaTypeCategory");
      // for(int c =0; c < offerDattaTypeCategory['data'].length; c++){
      //   offeredList.add(offerDattaTypeCategory['data'][c]);
      // }
      isLoading = false;
    });
    update();
  }
}