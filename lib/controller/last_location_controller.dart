import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/location_action/last_location_action.dart';

class LastLocationController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var lastLocation;
   var resultInvalid = false.obs;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  userlocationList(id) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await lastLocatin(id).then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      lastLocation = jsonDecode(value.body);
      print("Last Locations $lastLocation");
      // isLoading = false;
      if (value.statusCode == 200 || value.statusCode < 400) {
        resultInvalid(false);
        isLoading = false;
      }
      else if (lastLocation['success'] == false) {
        resultInvalid(false);
        isLoading = false;
      }
    });
    update();
  }
}