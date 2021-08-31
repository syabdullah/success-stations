import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/location_action/save_location.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/google_map/my_locations.dart';

class LocationController extends GetxController {
  bool isLoading = false;
  var res;
  var locData;
  var allLoc;
  var editLoc;
   @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  saveLocationToDB(data) async{
      print("..................>$data");
    print("controller call of the Favorite list");
    isLoading = true;
    await saveLocation(data).then((value) {
      if(value.statusCode == 200 || value.statusCode < 400){
        res = jsonDecode(value.body);
        print("..................>$res");
        //  getMyLocationToDB();
         Get.to(MyLocations());
        isLoading = false;
         Get.snackbar("Location saved Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);
       
        
      }
    });
    update();
  }

editLocationToDB(id,data) async{
    isLoading = true;
    await editLocation(id,data).then((value) {
      print("..................scdsbhjdsvjvhf-------->${value.body}");
      if(value.statusCode == 200 || value.statusCode < 400){
        editLoc = jsonDecode(value.body);
        print("..................scdsbhjdsvjvhf-------->$editLoc");
        //  getMyLocationToDB();
         Get.to(MyLocations());
        isLoading = false;
         Get.snackbar("Location updated Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);        
      }
    });
    update();
  }

deleteLocationToDB(id,userId) async {
    isLoading = true;
    await deleteLocation(id).then((value) {
      if(value.statusCode == 200 || value.statusCode < 400){
        var del = jsonDecode(value.body);
         print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$del");
        isLoading = false;
        getMyLocationToDB(userId);
         Get.snackbar("Location deleted Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);        
      }
    });
    update();
  }

  getMyLocationToDB(id) async{
    print("controller call of the Favorite list");
    isLoading = true;
    await getMyLocation(id).then((value) {
      print(",,,,,,,,,,,,,,,,,,,Offer data lisr.................$value");
      locData = jsonDecode(value.body);
      print("json decode response of offer.......>$res");
      isLoading = false;
      
    });
    update();
  }
  getAllLocationToDB() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await getAllLocation().then((value) {
      allLoc = jsonDecode(value.body);
      print("json decode response of offer.......>$allLoc");
      isLoading = false;
    });
    update();
  }

   getAllLocationNearBy(dis,lat,long) async{
    isLoading = true;
    await getNearByLocation(dis,lat,long).then((value) {
      allLoc = jsonDecode(value.body);
      isLoading = false;
    });
    update();
  }

   getAllLocationByCity(city,id) async {
    isLoading = true;
    await getCityLocation(city,id).then((value) {
      allLoc = jsonDecode(value.body);
      print("json decode response of offer.......>$allLoc");
      isLoading = false;
    });
    update();
  }
}