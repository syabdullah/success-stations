import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/ad_post_action.dart';
import 'package:success_stations/styling/colors.dart';

class AdPostingController extends GetxController {
  var result = true;
  var adpost;
   RxBool isLoading = false.obs;
   finalAdPosting(data) async {
     isLoading(true);
     await adPosting(data).then((res) {    
      var data = jsonDecode(res.body);
      print(data);
      print(res.statusCode);
      if(res.statusCode == 200 || res.statusCode < 400){
        adpost = jsonDecode(res.body);
        isLoading(false);
         Get.snackbar("Add Posted Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);
      //  Get.to(ForgotCode());
        
      } if(res.statusCode >=  400){
          Get.snackbar("You Enter Wrong entries",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
     });
     update();
   }
}