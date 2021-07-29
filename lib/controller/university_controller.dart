import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/university_action.dart';

class UniversityController extends GetxController {
  bool isLoading = false; 
  var universityData;
  List listUniData = [];

  @override
  void onInit(){
    isLoading = true;
    getUniversities();
    super.onInit();
  }

  getUniversities() async{
    isLoading = true ;
    await university().then((res) {
      universityData = jsonDecode(res.body);
      for(int uni =0; uni < universityData.length; uni++){
        listUniData.add(universityData['data'][uni]);

      }
      isLoading = false;
    });
    update();
  }
}