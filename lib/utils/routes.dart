import 'package:flutter/material.dart';
import 'package:success_stations/view/auth/country.dart';
import 'package:success_stations/view/auth/forgot/forgot_password.dart';
import 'package:success_stations/view/auth/language.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/bottom_bar.dart';
import 'package:success_stations/view/dashboard.dart';
import 'package:success_stations/view/friends/friends_profile.dart';

const String login = '/login';
const String home = '/home';
const String tabs = '/tabs';
const String friendPro = '/friendProfile';
const String forgot = '/forgotPass';
const String language = '/langua';
const String country = '/Country';
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
        case home:
        return MaterialPageRoute(builder: (_) => Dashboard());
        case tabs:
        return MaterialPageRoute(builder: (_) => BottomTabs());
        case friendPro:
        return MaterialPageRoute(builder: (_) =>  FriendProfile());
        case language:
        return MaterialPageRoute(builder: (_) => Language());
        case country:
        return MaterialPageRoute(builder: (_) => Ccountry());
        case forgot:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      default:
        return MaterialPageRoute(builder: (_) => SignIn());
    }
  }
}