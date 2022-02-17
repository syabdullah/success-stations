import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/contact_us_action.dart';

class ContactWithUsController extends GetxController {
var isLoading = false;
var ad;
var responses;
var phoneEr;
  contactWithUs(data) async {
    isLoading = true;
    await contactAction(data).then((response){
      ad = jsonDecode(response.body);
      responses= response.statusCode;
      if(response.statusCode < 400){
        Get.snackbar("","Request Successfully Sent",backgroundColor: Colors.white);
        // Get.off(AdsView());
        Get.snackbar("","${ad['message']}",backgroundColor: Colors.white);
      }
      if(response.statusCode > 400){
        phoneEr = ad['errors']['phone'].toString();
        phoneEr = phoneEr.split("[")[1].split("]")[0];
        Get.snackbar("","${ad['message']} $phoneEr",backgroundColor: Colors.white);
      }
      
  }
    );
    update();
  }

}