import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/offers/store_offer_action.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
import 'package:dio/src/response.dart' as response;
import 'package:success_stations/view/offers/my_offers.dart';

class StorePostAddesController extends GetxController {
 bool isLoading = false; 
  var  storedOfferotp , uploadImageOfAdd;
  List dataFvr8z =[];
  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  storefOffersAAll(data) async {
    isLoading = true;
    await storeAddOffer(data).then((response){
      if(response.statusCode == 200 || response.statusCode < 400){
        storedOfferotp = jsonDecode(response.body);
        print("....storedJson printed calling.........$storedOfferotp");
        isLoading = false;
        Get.snackbar(storedOfferotp['message'],'',backgroundColor: AppColors.appBarBackGroundColor);
        Get.to(OffersDetail());
      }
      if(response.statusCode >= 400){
        Get.snackbar("Error Foud",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
    });
    update();
  }

  uploadMyAdd(data) async {
      await ApiHeaders().getData();
      final Config conf = Config();
      print(ApiHeaders().headersWithToken);
      String url =conf.baseUrl + "offers/media";
      Dio dio = Dio();
        response.Response result =
        await dio.post(url, data: data,options:Options(headers: ApiHeaders().headersWithToken));
      uploadImageOfAdd = result.data;
       print("object...........${result.data}"); 
    update();
  }

}