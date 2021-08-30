import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/fav_user_action.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/utils/snack_bar.dart';

class UserFavController extends GetxController{
  final loc = Get.put(LocationController());
 var addtofav;
 var remToFav;
 var isLoading;
 profileAdsToFav(id) async {
    isLoading = true;
    await  userfav(id).then((res) {
      addtofav = jsonDecode(res.body);
     
      print(res.statusCode);
      if(res.statusCode < 400){
        Get.snackbar('', 'user add to fav sucessfully');
        loc.getAllLocationToDB();
      }
      if(res.statusCode > 400){
        Get.snackbar("","unSucessfully ");
      }
      isLoading = false;
    });
    update();
  }
  profileRemToFav(id) async {
    isLoading = true;
    await  remuserfav(id).then((res) {
      remToFav = jsonDecode(res.body);
     
      print(res.statusCode);
      if(res.statusCode < 400){
        Get.snackbar('', 'user add to fav sucessfully');
        loc.getAllLocationToDB();
      }
      if(res.statusCode > 400){
        Get.snackbar("","unSucessfully ");
      }
      isLoading = false;
    });
    update();
  }
}