

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
            height: Get.height,
            width: Get.width,
            color: AppColors.appBarBackGroundColor,
          ),
          messageList(

          ),
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
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(110)),
      child: Container(
        margin: EdgeInsets.only(top:Get.height/3.0),
        height: Get.height/1.3,
        color: Colors.orange,
      ),
    );
  }
}