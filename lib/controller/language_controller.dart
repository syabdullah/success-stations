import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/language_action.dart';

class LanguageController extends GetxController {
  GetStorage box = GetStorage();
  var isLoading , languageList; 
  List lang = [];


  @override 
  void onInit(){
    getLanguas();
    super.onInit();
  }

  getLanguas()async {
    isLoading = true ; 
    await languages().then((res){
      languageList = jsonDecode(res.body);
      if(languageList['data'].length !=null ||languageList['data'] !=null ){
        for(int l = 0; l <languageList['data'].length; l++ ){
          lang.add(languageList['data'][l]['name']);
        }
      }
      isLoading = false;
      
    });
    update();
  }
}