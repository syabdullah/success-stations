import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/google_map/mapview.dart';
import 'package:success_stations/view/i18n/app_language.dart';
import 'view/auth/forgot/forgot_password.dart';
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
  print("...........$auth");
}

class SuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:() => GetMaterialApp(      
        debugShowCheckedModeBanner: false,
        title: 'SuccessStation Codility',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: LocalizationServices.locale,
        fallbackLocale: LocalizationServices.fallbackLocale,
        translations: LocalizationServices(),
        theme: ThemeData(primaryColor: Color(0xFF1C1719), accentColor: Colors.black,),
          //  home: ForgotPassword(),
        initialRoute: auth == null ?  '/langua' : '/tabs',
        onGenerateRoute: SuccessStationRoutes.successStationRoutes,
        // home: NotificationPage(),
      ),
       designSize: const Size(360, 640),
    );
  }
}
