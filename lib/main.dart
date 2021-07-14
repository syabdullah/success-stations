import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/utils/routes.dart';

var auth;
var role;
var waiterKey;
void main() async {
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
      initialRoute: '/login',
      onGenerateRoute: SuccessStationRoutes.successStationRoutes,
    );
  }
}
