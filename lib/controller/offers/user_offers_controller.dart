import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/user_offer_action.dart';

class UserOfferController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var offerDattaTypeCategory;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  userOfferList(id) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await userOffers(id).then((value) {
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