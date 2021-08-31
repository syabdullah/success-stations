import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/ad_delete_action.dart';
import 'package:success_stations/action/ad_post_action.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';

class  AdDeletingController extends GetxController {
  final controller = Get.put(AddBasedController());
  var result = true;
  var adpost;
   RxBool isLoading = false.obs;
   adDelete(dataa) async {
     print("..........'''''$dataa");
     isLoading(true);
     await adDeleting(dataa).then((res) {    
      var data = jsonDecode(res.body);
    
      print(res.statusCode);
        print(data);
      if(res.statusCode == 200 || res.statusCode < 400){
        
        // controller.addedByIdAddes(null,null);
        
        Get.snackbar("Ad successfully deleted",'',backgroundColor: AppColors.appBarBackGroundColor);
        isLoading(false);      
      } if(res.statusCode >=  400){
          Get.snackbar("You Enter Wrong entries",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
     });
     update();
   }
}