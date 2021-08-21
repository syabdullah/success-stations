import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/all_category_action.dart';

class CategController extends GetxController {
  bool isLoading = false; 
  var  dataListing ;
  List myAddsCategory = [];

  @override
  void onInit(){
    isLoading = true;
    listing();
    super.onInit();
  }

  listing() async{
    isLoading = true;
    await myCategory().then((value) {
      dataListing= jsonDecode(value.body);
      myAddsCategory = dataListing['data'];
      // for( int i =0; i < dataListing['data'].length; i++){
      //   myAddsCategory.add(dataListing['data'][i]);
      // }
      isLoading = false;
    });
    update();
  }
}