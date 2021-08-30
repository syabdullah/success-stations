import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_filtering_action.dart';

class OffersFilteringController extends GetxController {
  bool isLoading = false;
  var offerFilterCreate;
  var result = true;
  var rating;
  var getRate;
  var resultInvalid = false.obs;

  // @override
  // void onInit() {
  //   isLoading = true;
  //   super.onInit();
  // }

  offerFilter(data) async {
    isLoading = true;
    await offerFilteringAction(data).then((res) {
      offerFilterCreate = jsonDecode(res.body);
      print("offer printing.......... Offer create Filter...... $offerFilterCreate");
      if (res.statusCode == 200 || res.statusCode < 400) {
        resultInvalid(false);
        isLoading = false;
      }
      if(offerFilterCreate['success'] == false){
         resultInvalid(true);
        isLoading = false;
      }
    });
    update();
  }

}
