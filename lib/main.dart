import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/ad_views/ad_viewmain.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';
import 'package:success_stations/view/messages/inbox.dart';
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
}

class SuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:() => GetMaterialApp(      
        debugShowCheckedModeBanner: false,
        title: 'SuccessStation Codility',
        theme: ThemeData(primaryColor: Color(0xFF1C1719), accentColor: Colors.black,),
          home: Inbox(),
        // initialRoute: auth == null ?  '/langua' : '/tabs',
        onGenerateRoute: SuccessStationRoutes.successStationRoutes,
        // home: OfferList(),
      ),
       designSize: const Size(360, 640),
    );
  }
}
