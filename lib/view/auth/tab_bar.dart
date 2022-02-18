import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/auth/sign_up/company_sign_up.dart';
import 'package:success_stations/view/auth/sign_up/student_sign_up.dart';

class TabBarPage extends StatefulWidget {
  _TabBarState createState() => _TabBarState();
}
class _TabBarState extends State<TabBarPage>with SingleTickerProviderStateMixin{
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var tabIndex = 0;

  late TabController controller1;
 // var countrydata = countryListData;
  bool rememberMe = true;

  @override
  void initState() {
    super.initState();
    controller1 = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  TextEditingController fulNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: AppColors.appBarBackGroundColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leadingWidth: 500,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        AppImages.roundedBack,
                        height: Get.height * 0.05,
                      )),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    "prev".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "andada",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.09),
                child: Center(
                  child: Text(  "new_account".tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "andada",
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ]),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left:Get.width*0.023,right:Get.width*0.023),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),),
                        child:TabBar(
                            indicator: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: AppColors.darkblue),
                            controller: controller1,
                            indicatorColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.white,
                            tabs: <Tab>[
                              Tab(
                                  child: Text(
                                    'student'.tr,
                                  )
                              ),
                              Tab(
                                  child: Text(
                                    'company'.tr,
                                  )
                              ),
                            ]
                        )
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: controller1,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            StudentSignUp(),
                            CompanySignUp()
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}