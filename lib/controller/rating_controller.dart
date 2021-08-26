import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/forget_password_action.dart';
import 'package:success_stations/action/rating_action.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/auth/forgot/forgot_code.dart';

class RatingController extends GetxController {
  GetStorage box = GetStorage();
  var result = true;
  var rating;
  var getRate;
   RxBool isLoading = false.obs;
   ratings(data) async {
     isLoading(true);
     await adRating(data).then((res) {    
      // email = jsonDecode(res.body);
      rating = jsonDecode(res.body);
      print(res);
      print(res.statusCode);
      if(res.statusCode < 400){
        isLoading(false);
       Get.snackbar("Rated Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
        
       if(res.statusCode >  400){
          Get.snackbar(" You Already Rated this Ad ",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
     });
     update();
   }


   getratings(data) async {
    isLoading(true);
    await getRating(data).then((value){
    getRate = jsonDecode(value.body);
    print(" .......... .... .... ....... .........  ...... $getRate");
    isLoading(false);
    });
    update();
  }
}