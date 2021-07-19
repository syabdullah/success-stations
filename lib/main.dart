import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/add_posting_screen.dart';

var auth;
var role;
var waiterKey;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    SuccessApp(),
  );
}
class SuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:() => GetMaterialApp(      
        debugShowCheckedModeBanner: false,
        title: 'SuccessStation Codility',
        theme: ThemeData(primaryColor: Color(0xFF1C1719), accentColor: Colors.black,),
          home: AddPostingScreen(),
        // initialRoute: '/login',
        onGenerateRoute: SuccessStationRoutes.successStationRoutes,
        // home: SignUp(),
      ),
       designSize: const Size(360, 640),
    );
  }
}
