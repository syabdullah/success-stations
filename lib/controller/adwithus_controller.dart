import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/adwithus_action.dart';
class AdWithUsController extends GetxController {
var isLoading = false;
var ad;
var responses;
  sendingAdsWithUs(data) async {
    isLoading = true;
    await adwithusAction(data).then((response){
      ad = jsonDecode(response.body);
       responses= response.statusCode;
      print(response.statusCode);
      if(response.statusCode < 400){
        Get.snackbar("","Ad Successfully Sent",backgroundColor: Colors.blue);
       
      }
      if(response.statusCode > 400){
        Get.snackbar("","Phone Number must be greater then 12 and less then 14",backgroundColor: Colors.blue);
      }
  }
    );
 update();
  }

}