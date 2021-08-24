import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_filtering_action.dart';

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
      print(".........!!!!!...!!!>...........!!!!!!!!...$adsFilterCreate");
      isLoading = false;
    });
    update();
  }
}
