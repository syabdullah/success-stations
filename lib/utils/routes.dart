import 'package:flutter/material.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/dashboard.dart';

const String login = '/login';
const String home = '/home';
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
        case home:
        return MaterialPageRoute(builder: (_) => Dashboard());
      default:
        return MaterialPageRoute(builder: (_) => SignIn());
    }
  }
}