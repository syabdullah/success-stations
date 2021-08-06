
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/categories_action.dart';

class CategoryController extends GetxController {
  bool isLoading = false; 
  var cateList;

  @override
  void onInit(){
    isLoading = true;
    getCategoryListing();
    super.onInit();
  }

  getCategoryListing() async{
    isLoading = true;
    await category().then((res){
      cateList= jsonDecode(res.body);
      print("....!!!!!!! categoryListing............$cateList");
      isLoading = false;
      
    });
    update();

    
  }
}