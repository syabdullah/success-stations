import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/city_action.dart';

class CityController extends GetxController {
  bool isLoading = false; 
  var cityData;
  List cityListData = [];

  @override
  void onInit(){
    isLoading = true;
    getCityByRegion();
    super.onInit();
  }

  getCityByRegion() async{
    isLoading = true ;
    await cities().then((res) {
      cityData = jsonDecode(res.body);
      print(".....city data ...!!!>..........CITY...DATA....$cityData");
      for( int ci =0; ci < cityData.length; ci++){
        cityListData.add(cityData['data'][ci]);
        print("city data of the Controller .............${cityData['data'][ci]}");
      }
      isLoading = false;
    });
    update();
  }
}