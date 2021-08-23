import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/contact_us_action.dart';
import 'package:success_stations/view/auth/contact.dart';

class ContactWithUsController extends GetxController {
var isLoading = false;
var ad;
var responses;
  contactWithUs(data) async {
    isLoading = true;
    await contactAction(data).then((response){
      ad = jsonDecode(response.body);
      print("..........................$ad");
      responses= response.statusCode;
      print(response.statusCode);
      if(response.statusCode < 400){
        Get.snackbar("","Request Successfully Sent",backgroundColor: Colors.blue);
        // Get.off(AdsView());
        Get.off(Contact());
      }
      if(response.statusCode > 400){
        Get.snackbar("","Phone Number must be equal to 13 digits",backgroundColor: Colors.blue);
      }
      
  }
    );
    update();
  }

}