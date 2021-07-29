import 'package:flutter/material.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/sign_up.dart';

class TabBarPage extends StatefulWidget {
  _TabBarState createState() => _TabBarState();
}
class _TabBarState extends State<TabBarPage>with SingleTickerProviderStateMixin{

  var tabIndex = 0;

  late TabController controller1;

  bool rememberMe = true;

  @override
  void initState() {
    super.initState();
    controller1 = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  TextEditingController fulNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final space20 = SizedBox(height: getSize(20, context));
    // final space10 = SizedBox(height: getSize(10, context));
    return  Scaffold(
      appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar('',Icons.arrow_back_ios, AppImages.appBarLogo ,)),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color:Colors.white,
                  child:TabBar(
                    controller: controller1,
                    tabs: <Tab>[
                      Tab(
                        child: Text(
                          'Student', style: TextStyle(color: Colors.blue)
                        )
                      ),
                      Tab(
                        child: Text(
                          'Company', style: TextStyle(color: Colors.grey)
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
                      SignUp(),
                      Text("Hi"),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

}