import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/contact_us_action.dart';

class ContactWithUsController extends GetxController {
var isLoading = false;
var ad;
  contactWithUs(data) async {
    isLoading = true;
    await contactAction(data).then((response){
      ad = jsonDecode(response.body);
      print("..........................$ad");
      print(response.statusCode);
      if(response.statusCode < 400){
        Get.snackbar("","Requrest Successfully Sent",backgroundColor: Colors.blue);
        // Get.off(AdsView());
      }
      if(response.statusCode > 400){
        Get.snackbar("","Request is not Sucessfully sent",backgroundColor: Colors.blue);
      }
      
  }
    );
    update();
  }

}