
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
    await addsCateg().then((res){
      addsListCategory= jsonDecode(res.body);
      print("....!!!!!!! categoryListing............$addsListCategory");
      for(int c =0; c < addsListCategory['data'].length; c++){
        print(".. country loop .........!!!!!!!!!!!!!!!!!!${addsListCategory['data']}");
        addsCategoryArray.add(addsListCategory['data'][c]);
      }
      isLoading = false;
    });
    update();
  }
}