// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:success_stations/action/city_action.dart';

// class CityController extends GetxController {
//   bool isLoading = false; 
//   var cityData;
//   List cityListData = [];

//   @override
//   void onInit(){
//     isLoading = true;
//     getCityByRegion();
//     super.onInit();
//   }

//   getCityByRegion() async{
//     isLoading = true ;
//     await cities().then((res) {
//       cityData = jsonDecode(res.body);
//       if(cityData['data'].length !=null){
//         for( int ci =0; ci < cityData['data'].length; ci++){
//           cityListData.add(cityData['data'][ci]);
//         }
//       }
//       isLoading = false;
//     });
//     update();
//   }
// }