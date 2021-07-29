
import 'package:get/get.dart';

class AppMethods {
  

  validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if ( value.length == 0 ){
      return 'email_required'.tr;
    }
    else if (!regExp.hasMatch(value)) {
      return "email_validation".tr;
    }
    return null;
  }

}
