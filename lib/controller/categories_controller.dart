
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/categories_action.dart';

class CategoryController extends GetxController {
  bool isLoading = false; 
  var cateList;
  var subCat ;
  List datacateg = [];
  @override
  void onInit(){
    isLoading = true;
    datacateg = [];
    super.onInit();
    // getCategoryNames();
  }

  getCategoryNames() async {
    datacateg = [];
    await  subCategory().then((value) {
      isLoading = true ;
      subCat =  jsonDecode(value.body);
      print(",,,,,,,,,,,,,,, ${subCat['data'].length}");
      if(subCat['data'] !=null || subCat['data'].length !=null  ){
        for(int c =0; c <subCat['data'].length; c++ ){
        datacateg.add(subCat['data'][c]);
      }
    }
     isLoading = false;
    });
    
  update();
  }
}

