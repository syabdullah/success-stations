import 'package:flutter/material.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/add_posting_screen.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/dashboard.dart';

const String login = '/login';
const String home = '/home';
const String adViewScreen = '/adviewScreen';
const String adPostingScreen = '/adPostingScreen';
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
        case home:
        return MaterialPageRoute(builder: (_) => Dashboard());
        case adViewScreen:
        return MaterialPageRoute(builder: (_) => AdViewScreen());
        case adPostingScreen:
        return MaterialPageRoute(builder: (_) => AddPostingScreen());
      default:
        return MaterialPageRoute(builder: (_) => SignIn());
    }
  }
}