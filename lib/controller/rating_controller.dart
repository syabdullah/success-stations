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
      rating = jsonDecode(res.body);
      print("R....A......T..............I....N............G.........P......R.....I........N.....T.......E.............D........ $rating");
      if(rating['success']== true){
        print('rating I.............F................C.............O..........N.................D...ITION');
        
       Get.snackbar(rating['message'],'',backgroundColor: AppColors.appBarBackGroundColor);
       isLoading(false);
      }
      else if(rating['success'] == false){
        print("Rating Else condition....>>>");
        Get.snackbar(rating['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
        isLoading(false);
      }
      
     });
     update();
   }


  //  getratings(data) async {
  //   isLoading(true);
  //   await getRating(data).then((value){
  //   getRate = jsonDecode(value.body);
  //   print(" .......... .... .... .....GET API OF rating.. .........  ...... $getRate");
  //   isLoading(false);
  //   });
  //   update();
  // }
}