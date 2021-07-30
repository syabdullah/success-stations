

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';

class Inbox extends StatefulWidget {
  _InboxState createState() => _InboxState();
}
class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height/3.0,
            width: Get.width,
            color: AppColors.appBarBackGroundColor,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appBarBackGroundColor,
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget messageList() {
    return SingleChildScrollView(
      child: Container(
        
      ),
    );
  }
}