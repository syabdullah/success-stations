import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/favorite_action.dart';

class FavoriteController extends GetxController {
  bool isLoading = false; 
  var  fvr8DataList ;
List dataFvr8z =[];
  @override
  void onInit(){
    isLoading = true;
    favoriteList();
    super.onInit();
  }

  favoriteList() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await favorite().then((value) {
      print(",,,,,,,,,,,,,,,,,,,Value of the Printed.................$value");
      fvr8DataList = jsonDecode(value.body);
      print("favorite List of the action in the data .......>$fvr8DataList");
      // for(int i =0; i<fvr8DataList['data'].length; i++ ){
      //   dataFvr8z.add(fvr8DataList['data'][i]);

      // }
      isLoading = false;
    });
    update();
  }
}