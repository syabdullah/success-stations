import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/action/notification_action.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/auth/notification.dart';

class NotificationController extends GetxController {
 
  bool isLoading = false; 
  List offeredList = [];
  var recentNotifications;
  var allNotifications;
  var deleteNotification;
  @override
  void onInit(){
    isLoading = true;
    super.onInit();
    allNoti();
  }

  allNoti() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await allNotification().then((value) {
      print("all notifications $value");
      allNotifications = jsonDecode(value.body);
      print("hehehhehehhehehehheheheheh $allNotifications");
      isLoading = false;
    });
    update();
  }
   deleteNotificationController(data) async {
    isLoading = true;
    await deleteNotificationAction(data).then((res) {
       deleteNotification = jsonDecode(res.body);
       print(deleteNotification);
        print(res.statusCode);
      if(res.statusCode < 400){
        // Get.off(NotificationPage());
    allNoti();
        isLoading=false;
      } if(res.statusCode > 400){
          Get.snackbar(deleteNotification['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }
}