import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/about_us_action.dart';

class AboutController extends GetxController {
   var isLoading = false;
   var aboutData; 
     @override
  void onInit(){
    isLoading = true;
     aboutController();
    super.onInit();
  }

  aboutController() async {
    isLoading = true;
    await aboutAction().then((value){
    aboutData = jsonDecode(value.body);
    isLoading = false;
    });
    update();
  }
}