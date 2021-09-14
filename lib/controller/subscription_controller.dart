
import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/action/subscription_action.dart';

class MemberShipController extends GetxController {
    var result;
  getMemberShip() async{
    await subscriptionAction().then((value) {
       result = jsonDecode(value.body);
      print("Print result....$result");
    });
  }
}