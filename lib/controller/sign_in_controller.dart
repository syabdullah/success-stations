import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_in_action.dart';
import 'package:success_stations/action/social_register.dart';
import 'package:success_stations/utils/routes.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  var logindata;
  var subDom;
  var result = true;
   var resultInvalid = false.obs;
   RxBool isLoading = false.obs;
  loginUserdata(data) async {
     print("........//////=======-------------");
    isLoading(true);
    await simplelogin(data).then((res) {    
      logindata = jsonDecode(res.body);
      print("..././///////////.................${res.body}");
      if(res.statusCode == 200 || res.statusCode < 400 ) {
         box.write('access_token',logindata['data']['token']);
         print("..././///////////${logindata['data']['token']}.................${res.body}");
        box.write('email',logindata['data']['email']);
        box.write('name',logindata['data']['nam']);
        box.write('user_id',logindata['data']['id']);

        isLoading(false);
        Get.toNamed('/tabs');
      } else if(logindata['success'] == false) {
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }

  loginSocial(data) async {
    isLoading(true);
    await socialLogin(data).then((res) {    
      logindata = jsonDecode(res.body);
       print("...............${logindata['data']['token']}");
      print(res.statusCode);
      if(res.statusCode == 200 || res.statusCode < 400) {
        box.write('access_token',logindata['data']['token']);
        box.write('email',logindata['data']['email']);
        box.write('user_id',logindata['data']['id']);
        isLoading(false);
      } else if(logindata['message'] == 'The given data was invalid.') {
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }
}