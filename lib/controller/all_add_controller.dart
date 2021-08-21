
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/all_Add_action.dart';

class MyAddsController extends GetxController {
  bool isLoading = false; 
  var addsListCategory;
  List addsCategoryArray= [];

  @override
  void onInit(){
    isLoading = true;
    myAddsCategory();
    super.onInit();
  }

  myAddsCategory() async{
    isLoading = true;
    await addsAll().then((res){
      addsListCategory= jsonDecode(res.body);
      addsCategoryArray = addsListCategory['data'];
      isLoading = false;
    });
    update();
  }
}