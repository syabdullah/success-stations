import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/offers/user_offer_action.dart';
import 'package:success_stations/styling/colors.dart';

class UserOfferController extends GetxController {
  bool isLoading = false; 
  List offeredList = [];
  var offerDattaTypeCategory;
  var deleteOffer;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  userOfferList(id) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await userOffers(id).then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      offerDattaTypeCategory = jsonDecode(value.body);
      print("hehehhehehhehehehheheheheh $offerDattaTypeCategory");
      // for(int c =0; c < offerDattaTypeCategory['data'].length; c++){
      //   offeredList.add(offerDattaTypeCategory['data'][c]);
      // }
      isLoading = false;
    });
    update();
  }
  deleteOfferController(data) async {
    isLoading = true;
    await deleteOfferAction(data).then((res) {
       deleteOffer = jsonDecode(res.body);
       print(deleteOffer);
        print(res.statusCode);
      if(res.statusCode < 400){
        // Get.off(NotificationPage());
    // allNoti();
        isLoading=false;
      } if(res.statusCode > 400){
          Get.snackbar(deleteOffer['errors'],'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }
}
