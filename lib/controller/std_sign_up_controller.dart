import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/city_action.dart';
import 'package:success_stations/action/college_action.dart';
import 'package:success_stations/action/std_sign_up_action.dart';

class ContryController extends GetxController {
  List countryListdata  =[];
  List regionListdata = [];
  List cityListData = [];
  List listCollegeData = [];
  List cityAll = [];
  
  bool isLoading = false; 
  var collegeData;
  var regionDataByCountry, countryData, cityData, city;
  @override
  void onInit() { 
    isLoading = true;
    getCountries();
    getCityAll();
    getCollege();
    countryListdata= [];
    regionListdata= [];
    cityListData = [];
    listCollegeData = [];
   
    super.onInit();
  }

  getCountries() async{
    countryListdata= [];
    cityListData =[];
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

  getRegion(id) async{
    regionListdata= [];
    isLoading = true ;
    await regionGetByCountryID(id).then((res) {
      regionDataByCountry = jsonDecode(res.body);
      for(int c =0; c < regionDataByCountry['data'].length; c++){
        regionListdata.add(regionDataByCountry['data'][c]);
        print("get region ....$regionListdata");
      }
      isLoading = false;
    });
    update();
  }

  getCity(id) async{
    cityListData= [];
    isLoading = true ;
    await cityGetByRegionID(id).then((res) {
      cityData = jsonDecode(res.body);
      for(int c =0; c < cityData['data'].length; c++){
        cityListData.add(cityData['data'][c]);
      }
      isLoading = false;
    });
    update();
  }


  getCollege() async{
    listCollegeData =[];
    isLoading = true ;
    await college().then((res) {
      collegeData = jsonDecode(res.body);
      for(int col = 0; col < collegeData['data'].length;col++ ){
        listCollegeData.add(collegeData['data'][col]);
      }
      isLoading = false;
    });
    update();
  }

  getCityAll() async{
    cityAll= [];
    isLoading = true ;
    await cities().then((res) {
      city = jsonDecode(res.body);
      print("city data pf yhre ???...>??$city");
      for(int c =0; c < city['data'].length; c++){
        cityAll.add(city['data'][c]);
      }
      isLoading = false;
    });
    update();
  }
}

