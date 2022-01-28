import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:success_stations/styling/colors.dart';
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
      // appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),
      // child: newAppbar(context,'previous'.tr, AppImages.appBarLogo )),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: ColoredBox(
                  color: Color(0XFF2B409E),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(18),
                          child:Text("previous".tr,style: TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.underline,fontFamily: "Source_Sans_Pro"),)
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 18,bottom: 18,left: 130),
                          child:Text("New Account".tr,style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: "Source_Sans_Pro",fontWeight: FontWeight.bold),)
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
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