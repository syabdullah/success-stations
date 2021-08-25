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
       adsFilterCreate = jsonDecode(res.body);
       print(adsFilterCreate);
        print(res.statusCode);
      if(res.statusCode < 200){
        isLoading=false;
      } if(res.statusCode > 400){
          Get.snackbar(adsFilterCreate['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }
}
