import 'package:flutter/material.dart';
import 'package:success_stations/view/sign_in.dart';

const String login = '/login';
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
      default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}')
          ),
        )
      );
    }
  }
}