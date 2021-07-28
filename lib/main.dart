import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/tab_bar.dart';

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
      // home:TabBarPage(),
      initialRoute: auth == null ?  '/login' : '/tabs',
      onGenerateRoute: SuccessStationRoutes.successStationRoutes,
    );
  }
}
