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
      isLoading = false;
    });
    update();
  }
}
