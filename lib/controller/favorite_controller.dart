import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/favorite_action.dart';

class FavoriteController extends GetxController {
  bool isLoading = false;
  var  fvr8DataList ;
  List dataFvr8z =[];
  var resultInvalid = false.obs;
  favoriteList() async{
   isLoading = true;
  await favorite().then((res) {
      fvr8DataList = jsonDecode(res.body);
      print("data list ......>>$fvr8DataList");
      if (res.statusCode == 200 ||res.statusCode < 400) {
        resultInvalid(false);
        isLoading = false;
      }
      else if (fvr8DataList['success'] == false) {
        resultInvalid(true);
       isLoading = false;
      }
    });
    update();
  }
}
