import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/sign_in_action.dart';
import 'package:success_stations/action/social_register.dart';

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
      print("..........@@@@@@@@@.....@@@>>>>>>.......$logindata");
      print("..././///////////.................${res.body}");
      if (res.statusCode == 200 || res.statusCode < 400) {
        box.write('access_token', logindata['data']['token']);
        print(
            "..././///////////${logindata['data']['token']}.................${res.body}");
        box.write('email', logindata['data']['user']['email']);
        box.write('address', logindata['data']['user']['address']);
        box.write('name', logindata['data']['user']['name']);
        box.write('user_image', logindata['data']['user']['image']);
        box.write('user_id', logindata['data']['user_id']);
        box.write('country_id', logindata['data']['user']['country_id']);
        box.write('city_id', logindata['data']['user']['city_id']);
        box.write('region_id', logindata['data']['user']['region_id']);

        // print('.........................................................${Box.read(city_id);}');
        resultInvalid(false);
        isLoading(false);
        Get.offAllNamed('/tabs');
      } else if (logindata['success'] == false) {
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

      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode < 400) {
        box.write('access_token', logindata['data']['token']);
        box.write('email', logindata['data']['user']['email']);
        box.write('name', logindata['data']['user']['name']);
        print("......TTTTTTTTTT____----------TTTTTT.........${logindata['data']}");
        box.write('user_id', logindata['data']['user']['id']);
        resultInvalid(false);
        isLoading(false);
        Get.offAllNamed('/tabs');
      } else if (logindata['message'] == 'The given data was invalid.') {
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }

  userLogout() async {
    isLoading(true);
    await logout().then((res) {
      logindata = jsonDecode(res.body);
      //  Get.offAllNamed('/login');
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode < 400) {
        box.remove("access_token");
        box.remove("name");
        box.remove("user_id");
        box.remove("email");
        Get.offAllNamed('/login');
        print("...............$logindata");
        resultInvalid(false);
        isLoading(false);
      } else if (logindata['message'] == 'The given data was invalid.') {
        resultInvalid(true);
        isLoading(false);
      }
    });
    update();
  }
}
