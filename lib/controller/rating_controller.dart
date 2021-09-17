import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/rating_action.dart';
import 'package:success_stations/styling/colors.dart';

class RatingController extends GetxController {
  GetStorage box = GetStorage();
  var result = true;
  var rating;
  var getRate;
  RxBool isLoading = false.obs;
  
  ratings(data) async {
    isLoading(true);
    await adRating(data).then((res) {   
      rating = jsonDecode(res.body);
      if(rating['success']== true){
        isLoading(false);
      }
      else if(rating['success'] == false){
        Get.snackbar(rating['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
        isLoading(false);
      }
    });
    update();
  }
}