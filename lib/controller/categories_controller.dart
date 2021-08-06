
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/categories_action.dart';

class CategoryController extends GetxController {
  bool isLoading = false; 
  var cateList;

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  getCityByRegion() async{
    category().then((value) {
      cateList = jsonDecode(value.body);
      print("............$cateList");
    });
  }
}