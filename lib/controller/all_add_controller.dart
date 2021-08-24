
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/all_add_action.dart';

class MyAddsController extends GetxController {
  bool isLoading = false; 
  var addsListCategory;
  List addsCategoryArray= [];
  var adsD;

  @override
  void onInit(){
    isLoading = true;
    myAddsCategory();
    super.onInit();
  }

  myAddsCategory() async{
    isLoading = true;
    await adsAll().then((res){
      addsListCategory= jsonDecode(res.body);
      addsCategoryArray = addsListCategory['data'];
      isLoading = false;
    });
    update();
  }

   adsDetail(id) async{
    isLoading = true;
    await addsDetailbyId(id).then((res){
      adsD= jsonDecode(res.body);
      print("........AAAAAAA------...$adsD");
      // addsCategoryArray = addsListCategory['data'];
      isLoading = false;
    });
    update();
  }
  
}