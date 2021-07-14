import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/sign_in.dart';
import 'package:success_stations/view/sign_up.dart';

var auth;
var role;
var waiterKey;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    SuccessApp(),
  );
}
class SuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(      
      debugShowCheckedModeBanner: false,
      title: 'SuccessStation Codility',
      theme: ThemeData(primaryColor: Color(0xFF1C1719), accentColor: Colors.black),
        home: SignUp(),
      // initialRoute: '/login',
      onGenerateRoute: SuccessStationRoutes.successStationRoutes,
      // home: SignUp(),
    );
  }
}
