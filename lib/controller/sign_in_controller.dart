import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_in_action.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  var logindata;
  var subDom;
  var result = true;
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