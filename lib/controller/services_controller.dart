import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/services_action.dart';

class ServicesController extends GetxController {
  List servicesListdata = [];
  bool isLoading = false; 
  late Map<String, dynamic> data ;
  late List<dynamic> servicesData ;
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
      data = Map<String, dynamic>.from(jsonDecode(res.body));
      servicesData = data["data"];
      print("!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@$data");
      for(int ser =0; ser < servicesData.length; ser++){
        print(".. serviocesssssss loop ....SHEHHEEHEHHE.....!!!!!!!!!!!!!!!!!!${servicesData[ser]}");
        for(int s = 0 ; s < servicesData[ser].length ; s++){
          print(".. servicesssssss loop .........!!!!!!!!!!!!!!!!!!${servicesData[ser][s]}");
          servicesListdata.add(servicesData[ser][s]);

        }
      }
      isLoading = false;
    });
    update();
  }
}