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
    isLoading = true;
    await lastLocatin(id).then((value) {
      lastLocation = jsonDecode(value.body);
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