import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/all_category_action.dart';

class AllCategController extends GetxController {
  bool isLoading = false; 
  var cateAllListing;
  List myAddsCategory = [];

  @override
  void onInit(){
    isLoading = true;
    cateogryListing();
    super.onInit();
  }

  cateogryListing() async{
    isLoading = true;
    allMyAddscategory().then((value) {
      cateAllListing = jsonDecode(value.body);
      print("............$cateAllListing");
      for( int i =0; i < cateAllListing.length; i++){
        print(".....................!!!!!!!!!!!..>>$cateAllListing");
        myAddsCategory.add(cateAllListing['data'][i]);
        print("......33333.................$myAddsCategory");


      }
      isLoading = false;
    });
    update();
  }
}