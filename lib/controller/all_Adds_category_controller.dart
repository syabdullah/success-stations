import 'dart:convert';
import 'package:get/get.dart';
import 'package:success_stations/action/all_adds_category_action.dart';

class AddBasedController extends GetxController {
  bool isLoading = false; 
  var cData;
  List catBaslistData = [];

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  addedByIdAddes(id) async{
    isLoading = true ;
    await basedAddById(id).then((res) {
      cData = jsonDecode(res.body);
      print("/////////////////// json response .........................>>>>$cData");
      if(cData['data'].length !=null){
        for( int ci =0; ci < cData['data'].length; ci++){
          catBaslistData.add(cData['data'][ci]);
        }
      }
      isLoading = false;
    });
    update();
  }
}