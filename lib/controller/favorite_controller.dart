import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/favorite_action.dart';

class FavoriteController extends GetxController {
  bool isLoading = false; 
  var  fvr8DataList ;
  List dataFvr8z =[];
  var resultInvalid = false.obs;
  // @override
  // void onInit(){
  //   isLoading = true;
  //   favoriteList();
  //   super.onInit();
  // }

  favoriteList() async{
    print("controller call of the Favorite list");
    isLoading = true;
    await favorite().then((res) {
      
      print(".....!!!!!!!!!!!!.......>>>$fvr8DataList");
      if (res.statusCode == 200 || res.statusCode < 400) {
        fvr8DataList = jsonDecode(res.body);
        // resultInvalid(false);
        isLoading = false;
      }
      // else if (fvr8DataList['success'] == false) {
      //   resultInvalid(true);
      //   isLoading = false;
      // }
    });
    update();
  }
}