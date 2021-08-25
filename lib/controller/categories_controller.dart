
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/categories_action.dart';

class CategoryController extends GetxController {
  bool isLoading = false; 
  var cateList;
  var subCat ;
  var subCatt;
  List datacateg = [];
  List datacategTypes = [];
  @override
  void onInit(){
    isLoading = true;
    // datacateg = [];
    super.onInit();
    getCategoryNames();
  }

  getCategoryNames() async {
    // datacateg = [];
    await  subCategory().then((value) {
      isLoading = true ;
      subCat =  jsonDecode(value.body);
      print("................................cccccccccc.......$subCat");
      datacateg = subCat['data'];
      
     isLoading = false;
    });
    
  update();
  }
  getCategoryTypes() async {
    // datacateg = [];
    await  categoryTypes().then((value) {
      isLoading = true ;
      subCatt =  jsonDecode(value.body);
      print(",,,,,,,,,,,,,,, ${subCatt['data']}");
      datacategTypes = subCatt['data'];
     isLoading = false;
    });
    
  update();
  }
}

