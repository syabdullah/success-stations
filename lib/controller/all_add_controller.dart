
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/all_add_action.dart';

class MyAddsController extends GetxController {
  bool isLoading = false; 
  var addsListCategory, allAddCategory;
  var isInvalid = false.obs;
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
      if(res.statusCode == 200 || res.statusCode< 400){
        isInvalid(false);
        isLoading = false;

      }
      else if(addsListCategory['success'] == false){
        isInvalid(true);
        isLoading = true;

      }
      // addsCategoryArray = addsListCategory['data'];
      // isLoading = false;
    });
    update();
  }

  adsDetail(id) async{
    isLoading = true;
    await addsDetailbyId(id).then((res){
      adsD= jsonDecode(res.body);
      isLoading = false;
    });
    update();
  }

  
  
  
}