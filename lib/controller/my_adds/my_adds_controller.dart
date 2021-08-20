import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/my_adds/my_add_action.dart';

class MyAddsAdedController extends GetxController {
  bool isLoading = false; 
  List myMyAdd = [];
  var addsGet, uploadImageOfAdd;

  @override
  void onInit(){
    isLoading = true;
    addesMyListFv();
    myMyAdd = [];
    super.onInit();
  }

  addesMyListFv() async{
    myMyAdd = [];
    isLoading = true;
    await addsFvrtMyAdds().then((value) {
       addsGet= jsonDecode(value.body);
      print("json decode response of offer.......>$addsGet");
      for(int c =0; c < addsGet['data'].length; c++){
        myMyAdd.add(addsGet['data'][c]);
      }
      isLoading = false;
    });
    update();
  }

  
}