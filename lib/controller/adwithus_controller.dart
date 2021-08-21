import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/adwithus_action.dart';
import 'package:success_stations/view/ads.dart';

class AdWithUsController extends GetxController {
var isLoading = false;
var ad;
  sendingAdsWithUs(data) async {
    isLoading = true;
    await adwithusAction(data).then((response){
      ad = jsonDecode(response.body);
      print("..........................$ad");
      print(response.statusCode);
      if(response.statusCode < 400){
        Get.snackbar("","Ad Successfully Sent",backgroundColor: Colors.blue);
        Get.off(AdsView());
      }
      if(response.statusCode > 400){
        Get.snackbar("","Request is not sucessfully sent",backgroundColor: Colors.blue);
      }
  }
    );
 update();
  }

}