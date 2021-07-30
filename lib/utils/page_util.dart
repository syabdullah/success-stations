import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageUtils {

  static void pushPage(Widget pageName, {animationType}) {
    Get.to(pageName,transition: animationType??Transition.rightToLeft,duration: Duration(milliseconds: 300),);
  }


  static void pushPageAndRemoveAllRoutes(
      BuildContext context, Widget pageName) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => pageName),
        (Route<dynamic> route) => false);
  }
}
