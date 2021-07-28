import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/college_action.dart';

class CollegeController extends GetxController {
  bool isLoading = false; 
  var collegeData;
  List listCollegeData = [];

  @override
  void onInit(){
    isLoading = true;
    getCollegeByUniversities();
    super.onInit();
  }

  getCollegeByUniversities() async{
    print("getCountry.......!!!!!!");
    isLoading = true ;
    await college().then((res) {
      collegeData = jsonDecode(res.body);
      for(int col = 0; col < collegeData.length;col++ ){
        listCollegeData.add(collegeData['data'][col]);
      }
      isLoading = false;
    });
    update();
  }
}