// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:success_stations/action/region_action.dart';

// class RegionController extends GetxController {
//   bool isLoading = false; 
//   List listDataRegion = [];
//   var regionData;
  
//   @override
//   void onInit(){
//     isLoading = true;
//     getRegionByCountry();
//     super.onInit();
//   }
//   getRegionByCountry() async{
//     isLoading = true ;
//     await region().then((res) {
//       regionData = jsonDecode(res.body);
//       if(regionData['data'].length !=null ){
//         for(int r = 0; r < regionData['data'].length; r++){
//           listDataRegion.add(regionData['data'][r]);
//         }
//       }
      
//       isLoading = false;
//     });
//     update();
//   }
// }