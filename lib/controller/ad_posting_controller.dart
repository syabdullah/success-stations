import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/ad_post_action.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';
import 'package:dio/src/response.dart' as response;

class AdPostingController extends GetxController {
  var result = true;
  var adpost;
  var adUpload;
  var postComment;
   RxBool isLoading = false.obs;
  //  finalAdPosting(dataa) async {
  //    isLoading(true);
  //    await adPosting(dataa).then((res) {    
  //     var data = jsonDecode(res.body);
    
  //     print(res.statusCode);
  //       print(data);
  //     if(res.statusCode == 200 || res.statusCode < 400){
  //       adpost = jsonDecode(res.body); 
  //       Get.off(MyAdds());
  //       Get.snackbar("Ads successfully created",'',backgroundColor: AppColors.appBarBackGroundColor);
  //       isLoading(false);      
  //     } if(res.statusCode >=  400){
  //         Get.snackbar("You Enter Wrong entries",'',backgroundColor: AppColors.appBarBackGroundColor);
  //     }
  //    });
  //    update();
  //  }
    finalAdPosting(data) async {
      await ApiHeaders().getData();
      final Config conf = Config();
        print("object----------------------${ApiHeaders().headersWithToken}");
      String url =conf.baseUrl + "ads";
      Dio dio = Dio();
        response.Response result =
        await dio.post(url, data: data,options:Options(
          followRedirects: false,
          headers: ApiHeaders().headersWithToken));
    // await updateProfile(data).then((res) {
       print("object----------------------$result");
      adpost = result.data;
      if(result.data['success'] == true){
         isLoading(true);
         Get.snackbar("Ad successfully created",'',backgroundColor: AppColors.appBarBackGroundColor);
      } 
    update();
  }
    finalAdDrafting(data) async {
      await ApiHeaders().getData();
      final Config conf = Config();
        print("object----------------------${ApiHeaders().headersWithToken}");
      String url =conf.baseUrl + "ads";
      Dio dio = Dio();
        response.Response result =
        await dio.post(url, data: data,options:Options(
          followRedirects: false,
          headers: ApiHeaders().headersWithToken));
    // await updateProfile(data).then((res) {
       print("object----------------------$result");
      adpost = result.data;
      if(result.data['success'] == true){
         isLoading(true);
         Get.to(MyAdds());
         Get.snackbar("Ad Drafted Successfully",'',backgroundColor: AppColors.appBarBackGroundColor);
         
      } 
    update();
  }


    uploadAdImage(data) async {
      print("______))))))))))");
      await ApiHeaders().getData();
      final Config conf = Config();
      print(ApiHeaders().headersWithToken);
      String url =conf.baseUrl + "ads/media";
      Dio dio = Dio();
        response.Response result =
        await dio.post(url, data: data,options:Options(headers: ApiHeaders().headersWithToken));
       print("object...........${result.data}");
    // await updateProfile(data).then((res) {
      adUpload = result.data;
       
      // if(result.data['success'] == true){
      //   //  isLoading = true;
      // } 
    update();
  }

  commentPost(data) async {
     isLoading(true);
     await commentPosting(data).then((res) {    
       postComment = jsonDecode(res.body);
      print(postComment);
      print(res.statusCode);
      if(res.statusCode == 200 || res.statusCode < 400){
        adpost = jsonDecode(res.body);
        isLoading(false);
         Get.snackbar("Add Posted Sucessfully",'',backgroundColor: AppColors.appBarBackGroundColor);
       
        
      } if(res.statusCode >=  400){
          Get.snackbar("You Enter Wrong entries",'',backgroundColor: AppColors.appBarBackGroundColor);
      }
     });
     update();
   }
}