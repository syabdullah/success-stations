import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/utils/routes.dart';
<<<<<<< HEAD
import 'package:success_stations/view/ad_views/ad_viewmain.dart';
=======
import 'package:success_stations/view/auth/tab_bar.dart';
>>>>>>> 0c964d42d6ff9420612876fe22aa4813e01c40dd
import 'package:success_stations/view/i18n/app_language.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:success_stations/view/offers/add_offers.dart';
import 'package:success_stations/view/offers/my_offers.dart';
var auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
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
<<<<<<< HEAD
          //  home: AdViewTab(),
=======
          //  home: AddOffersPage(),
>>>>>>> 0c964d42d6ff9420612876fe22aa4813e01c40dd
        initialRoute: auth == null ?  '/langua' : '/tabs' ,
        onGenerateRoute: SuccessStationRoutes.successStationRoutes,
        // home: NotificationPage(),
      ),
       designSize: const Size(360, 640),
    );
  }
}
