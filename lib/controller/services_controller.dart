import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/services_action.dart';

class ServicesController extends GetxController {
  List servicesListdata = [];
  bool isLoading = false; 
 var servicesData ;
  // var servicesData;
  @override
  void onInit() { 
    isLoading = true;
    getServices();
    super.onInit();
  }

  getServices() async{
    isLoading = true ;
    await services().then((res) {
      servicesData = jsonDecode(res.body);
       for(int ser =0; ser < servicesData['data'].length; ser++){
        servicesListdata.add(servicesData['data'][ser]);
      }
      isLoading = false;
    });
    update();
  }
}