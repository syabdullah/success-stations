import 'package:flutter/material.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/bottom_bar.dart';
import 'package:success_stations/view/dashboard.dart';

const String login = '/login';
const String home = '/home';
const String tabs = '/tabs';
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
        case home:
        return MaterialPageRoute(builder: (_) => Dashboard());
        case tabs:
        return MaterialPageRoute(builder: (_) => BottomTabs());
      default:
        return MaterialPageRoute(builder: (_) => SignIn());
    }
  }
}