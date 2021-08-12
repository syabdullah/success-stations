import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/country_action.dart';

class ContryController extends GetxController {
  List countryListdata = [];
  bool isLoading = false; 
  var countryData;
  @override
  void onInit() { 
    isLoading = true;
    getCountries();
    super.onInit();
  }

  getCountries() async{
    isLoading = true ;
    await countries().then((res) {
      countryData = jsonDecode(res.body);
      for(int c =0; c < countryData['data'].length; c++){
        countryListdata.add(countryData['data'][c]);
      }
      isLoading = false;
    });
    update();
  }
}