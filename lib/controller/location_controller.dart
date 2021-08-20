import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/location_action/save_location.dart';

class LocationController extends GetxController {
  bool isLoading = false;
  var res;
   @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  saveLocationToDB(data) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await saveLocation(data).then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      res = jsonDecode(value.body);
      print("json decode response of offer.......>$res");
      isLoading = false;
    });
    update();
  }
}