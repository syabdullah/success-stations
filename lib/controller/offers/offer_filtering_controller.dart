import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/offer_filtering_action.dart';
import 'package:success_stations/styling/colors.dart';

class OffersFilteringController extends GetxController {
  bool isLoading = false;
  var offerFilterCreate;
  var result = true;
  var rating;
  var getRate;

  @override
  void onInit() {
    isLoading = true;

    super.onInit();
  }

  offerFilter(data) async {
    isLoading = true;
    await offerFilteringAction(data).then((res) {
      offerFilterCreate = jsonDecode(res.body);
      print("......offer filter......${res.body}");
      print("...status code of offer post....$offerFilterCreate");
      print("......here the result.........$offerFilterCreate");
      if (res.statusCode < 200) {
        isLoading = false;
      }
      if (res.statusCode > 400) {
        //Get.snackbar(offerFilterCreate['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }

  getOfferFiltering(data) async {
    isLoading = true;
    await offerGetFilteringAction(data).then((value) {
      getRate = jsonDecode(value.body);
      print(
          " .......... .... ....yesddddddd ....... .........  ...... $getRate");
      isLoading = false;
    });
    update();
  }
}

 

//offerGetFilteringAction
