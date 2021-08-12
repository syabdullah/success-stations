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
      // data = Map<String, dynamic>.from(jsonDecode(res.body));
      // servicesData = data["data"];
      print("!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@$servicesData");
      for(int ser =0; ser < servicesData['data'].length; ser++){
        servicesListdata.add(servicesData['data'][ser]);
        // print(".. serviocesssssss loop ....SHEHHEEHEHHE.....!!!!!!!!!!!!!!!!!!${servicesData[ser]}");
        // for(int s = 0 ; s < servicesData[ser].length ; s++){
          print(".. servicesssssss loop .........!!!!!!!!!!!!!!!!!!$servicesListdata");
        //   servicesListdata.add(servicesData[ser][s]);

        // }
      }
      isLoading = false;
    });
    update();
  }
}