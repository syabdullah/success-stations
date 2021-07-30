import 'package:flutter/material.dart';
import 'package:success_stations/view/about_us.dart';
import 'package:success_stations/view/ad_views/ad_viewmain.dart';
import 'package:success_stations/view/auth/advertise.dart';
import 'package:success_stations/view/auth/contact.dart';
import 'package:success_stations/view/auth/country.dart';
import 'package:success_stations/view/auth/forgot/forgot_password.dart';
import 'package:success_stations/view/auth/language.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/add_posting_screen.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';
import 'package:success_stations/view/auth/sign_in.dart';
import 'package:success_stations/view/auth/tab_bar.dart';
import 'package:success_stations/view/dashboard.dart';
import 'package:success_stations/view/bottom_bar.dart';
import 'package:success_stations/view/friends/friends_profile.dart';
import 'package:success_stations/view/member_ship/become_member.dart';
import 'package:success_stations/view/member_ship/member_ship.dart';
import 'package:success_stations/view/messages/inbox.dart';
import 'package:success_stations/view/member_ship/member_ship.dart';

const String login = '/login';
const String home = '/home';
const String adViewScreen = '/adviewScreen';
const String adPostingScreen = '/adPostingScreen';
const String aboutUs = '/aboutUs';
const String tabs = '/tabs';
const String friendPro = '/friendProfile';
const String member = '/membership';
const String forgot = '/forgotPass';
const String language = '/langua';
const String country = '/Country';
const String tabBar = '/signUp';
const String becomeMember = '/beMember';
const String inbox = '/inbox';
const String adverrtise = '/advertisement';
const String myAdd = '/myAddsPage';
const String contact = '/contact';
const String adViewTab = "/adViewTab";
class SuccessStationRoutes {
  static Route<dynamic> successStationRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => SignIn());
        case home:
        return MaterialPageRoute(builder: (_) => Dashboard());
        case tabBar:
        return MaterialPageRoute(builder: (_) => TabBarPage());
        case adViewScreen:
        return MaterialPageRoute(builder: (_) => AdViewScreen());
        case adPostingScreen:
        return MaterialPageRoute(builder: (_) => AddPostingScreen());
        case tabs:
        return MaterialPageRoute(builder: (_) => BottomTabs());
        case friendPro:
        return MaterialPageRoute(builder: (_) =>  FriendProfile());
        case member:
        return MaterialPageRoute(builder: (_) => MemberShip());
        case adverrtise:
        return MaterialPageRoute(builder: (_) => AdvertisePage());
        case myAdd:
        return MaterialPageRoute(builder: (_) => MyAdds());
        case contact:
        return MaterialPageRoute(builder: (_) => Contact());
        case language:
        return MaterialPageRoute(builder: (_) => Language());
        case country:
        return MaterialPageRoute(builder: (_) => Ccountry());
        case becomeMember : 
        return MaterialPageRoute(builder: (_) => BecomeMember());
        case forgot:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
        case aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUs());
        case adViewTab:
        return MaterialPageRoute(builder: (_) => AdViewTab());
         case inbox:
        return MaterialPageRoute(builder: (_) => Inbox());
      default:
        return MaterialPageRoute(builder: (_) => Language());
    }
  }
}