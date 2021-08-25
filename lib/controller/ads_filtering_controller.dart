import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_filtering_action.dart';
import 'package:success_stations/styling/colors.dart';

class AdsFilteringController extends GetxController {
  bool isLoading = false;
  var adsFilterCreate;

  @override
  void onInit() {
    isLoading = true;

    super.onInit();
  }

  createFilterAds(data) async {
    isLoading = true;
    await createAdsFilteringAction(data).then((res) {
      print("......!!!!.....res.....$res");
      print("///////,.,.,.,.,.,><><><><><.....${res.statusCode}");
     // adsFilterCreate = jsonDecode(res.body);
      // print(
      //     "......check controller...!!!!!...!!!>...........!!!!!!!!...$adsFilterCreate");
      //isLoading = false;
       print(res);
      print(res.statusCode);
      if(res.statusCode == 200){
        adsFilterCreate = jsonDecode(res.body);
        isLoading=false;
      // Get.to(ForgotCode());
        
      } if(res.statusCode > 200){
          Get.snackbar("Error",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }
}
