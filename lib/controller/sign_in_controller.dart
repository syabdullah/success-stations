import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_in_action.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  var logindata = [].obs;
  var subDom;
  var result = true;
   var resultInvalid = false.obs;
   RxBool isLoading = false.obs;
  loginUserdata(data) async {
    isLoading(true);
    await login(data).then((res) {    
      logindata = jsonDecode(res.body);
      print(logindata);
      if(res.statusCode == 200) {
        isLoading(false);
      } else {
        isLoading(false);
      }
    });
    update();
  }
}