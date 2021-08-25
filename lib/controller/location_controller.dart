import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/location_action/save_location.dart';
import 'package:success_stations/styling/colors.dart';

class LocationController extends GetxController {
  bool isLoading = false;
  var res;
  var locData;
   @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  saveLocationToDB(data) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await saveLocation(data).then((value) {
       
      if(value.statusCode == 200 || value.statusCode < 400){
        res = jsonDecode(value.body);
         getMyLocationToDB();
        isLoading = false;
         Get.snackbar("Location saved Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);
       
        
      }
    });
    update();
  }
  getMyLocationToDB() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await getMyLocation().then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      locData = jsonDecode(value.body);
      print("json decode response of offer.......>$res");
      isLoading = false;
    });
    update();
  }
}