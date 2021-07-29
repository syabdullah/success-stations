import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/auth/country.dart';
import 'package:success_stations/view/auth/forgot/reset_password.dart';
import 'package:success_stations/view/auth/language.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';

import 'view/bottom_bar.dart';
var auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  getData();
  runApp(
    SuccessApp(),
  );
}

GetStorage box = GetStorage();
getData() async{
  auth = await box.read('access_token');
}

class SuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return GetMaterialApp(      
      debugShowCheckedModeBanner: false,
      title: 'SuccessStation Codility',
      theme: ThemeData(primaryColor: Color(0xFF1C1719), accentColor: Colors.black),
      
      // initialRoute: auth == null ?  '/langua' : '/home',
      onGenerateRoute: SuccessStationRoutes.successStationRoutes,
      home: BottomTabs(),
    );
  }
}
