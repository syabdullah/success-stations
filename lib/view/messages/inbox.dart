

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 AppBar(
                   leading:Image.asset(AppImages.arrowBack),
                  elevation: 0,
                  backgroundColor: AppColors.appBarBackGroundColor,
                    centerTitle: true,
                     title:
                      Text("INBOX",
                      style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
                      )
                    ),
                 Padding(
                   padding: const EdgeInsets.only(top:0.0,left:20),
                   child: Text("Recently Contacted",
                     style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.normal, color:Colors.white,),
                    ),
                 ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top:25.0,),
                    // color: Colors.white,
                    height: Get.height,
                    child: recentlyContacted()
                
                  ),
                )     
              ],
            )
          ),
          messageList(),
          
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
           color: Colors.white,
      ),
      margin: EdgeInsets.only(top:Get.height/3.0),
      height: Get.height/1.2,
      child: ListView.builder(
      itemCount: 16,
      itemBuilder: (context, index) {
      return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: chatListView(),
          )
    );
  },
),
    );
  }
}

Widget chatListView(){
  return ListTile(
    title: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Image.asset(AppImages.profile)),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left:12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Name",
                  style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7,),
                 Text("Really ? that's great We will do it Tommorow",
                  style:TextStyle(color: Colors.grey,fontSize: 13,),
                )
              ],
            ),
          ),
        )
      ],
    ),
    trailing: Column(
      children: [
        Text("2:30pm",
          style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
         ),
      ],
    ),
    );
}
Widget recentlyContacted(){
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 16,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(left:25.0,),
        child: recentChat(),
      );});
}
Widget recentChat(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Image.asset(AppImages.profile)),
        ),
        SizedBox(height: 5,),
        Text("User Name",style: TextStyle(fontSize: 10,color: Colors.white),
        )
    ],
  );
  
}