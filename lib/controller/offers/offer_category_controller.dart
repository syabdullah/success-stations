import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_category_action.dart';

class OfferCategoryController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var offerDattaTypeCategory;

  @override
  void onInit(){
    isLoading = true;
    categoryOfferList();
    super.onInit();
  }

  categoryOfferList() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await offersCategory().then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      offerDattaTypeCategory = jsonDecode(value.body);
      for(int c =0; c < offerDattaTypeCategory['data'].length; c++){
        offeredList.add(offerDattaTypeCategory['data'][c]);
      }
      isLoading = false;
    });
    update();
  }
}