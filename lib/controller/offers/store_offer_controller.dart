import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/offers/store_offer_action.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
import 'package:dio/src/response.dart' as response;
import 'package:success_stations/view/offers/my_offers.dart';

class StorePostAddesController extends GetxController {
//  final myofferlistin=  Get.put(OfferController());
  final myofferlistin=  Get.put(MyOffersDrawerController());
//  bool isLoading = false; 
  var  storedOfferCreated , uploadImageOfAdd;
  RxBool isLoading = false.obs;
  List dataFvr8z =[];
  @override
  void onInit(){
    // isLoading = true;
    super.onInit();
  }

  // storefOffersAAll(data) async {
  //   isLoading = true;
  //   await storeAddOffer(data).then((response){
  //     if(response.statusCode == 200 || response.statusCode < 400){
  //       storedOfferotp = jsonDecode(response.body);
  //       isLoading = false;
  //       myofferlistin.offerList();
  //       Get.to(OffersDetail());
  //       if(storedOfferotp['success']== true){
  //         Get.snackbar(storedOfferotp['message'],'',backgroundColor: AppColors.appBarBackGroundColor);
  //       }
  //     }
  //     if(response.statusCode >= 400){
  //       Get.snackbar("Offers Entries Wrong",'',backgroundColor: AppColors.appBarBackGroundColor);
  //     }
  //   });
  //   update();
  // }
  storefOffersAAll(data) async {
    isLoading(true);
    await ApiHeaders().getData();
    final Config conf = Config();
      print("store offer createdddd/....${ApiHeaders().headersWithToken}");
        String url =conf.baseUrl + "offers";
        Dio dio = Dio();
        response.Response result = await dio.post(url, data: data,options:Options( followRedirects: false,
        headers: ApiHeaders().headersWithToken));
        storedOfferCreated = result.data;
        myofferlistin.drawerMyOffer();
        Get.off(OffersDetail());
        if(result.data['success'] == true){
       
        Get.snackbar(" Offfer Added successfully created",'',backgroundColor: AppColors.appBarBackGroundColor);
        
         isLoading(false);
    } 
    update();
  }


  uploadMyAdd(data) async {
    print("______))))))))))");
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