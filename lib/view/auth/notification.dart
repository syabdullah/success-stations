import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/notification_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/UseProfile/notifier_user.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/drawer_screen.dart';

class NotificationPage extends StatefulWidget {
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(NotificationController());
  var id;
  @override
  void initState() {
    super.initState();
    controller.allNoti();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch,1)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child: AppDrawer(),
      ),

      body:SafeArea(
        child: ListView(
          children:[
          //  GetBuilder<NotificationController>( // specify type as Controller
          //         init: NotificationController(), // intialize with the Controller
          //         builder: (value){ 
          //           print(value.recentNotifications);
          //           return 
          //           value.recentNotifications != null ?
          //           recentNotifications(value.recentNotifications['data']):Center(child: CircularProgressIndicator());// value is an instance of Controller.
          //         }
          //           ),
          //           SizedBox(height: 10,),
                   
                  GetBuilder<NotificationController>( // specify type as Controller
                  init: NotificationController(), // intialize with the Controller
                  builder: (value){ 
                    print(value.allNotifications);
                    
                    return 
                    value.allNotifications != null ?
                    fullNotifications(value.allNotifications['data']):Center(child: CircularProgressIndicator());// value is an instance of Controller.
                  }
                    ),
          ],
      
        ),
      ),
    );
  }
// var imageGived;
var idd;
  Widget fullNotifications(data) {
   
     return  Container(
       
       height: Get.height,
       child: ListView.builder(
         physics: const NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, index) {
                 
                String convertToAgo(DateTime input){
                  Duration diff = DateTime.now().difference(input);

                  if(diff.inDays >= 1){
                  return '${diff.inDays}d';
                  } else if(diff.inHours >= 1){
                  return '${diff.inHours}h';
                  } else if(diff.inMinutes >= 1){
                  return '${diff.inMinutes}m';
                  } else if (diff.inSeconds >= 1){
                  return '${diff.inSeconds}s';
                  } else {
                  return 'just now';
                  }
                  }
           
        var inputDate = DateTime.parse(data[index]['created_at']).toLocal();
         return   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                index == 0 ? 
                Container(
                  margin: EdgeInsets.only(left: 20,top:10, right: 12),
                  child:Text("recent_notification".tr,  
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ):
                index == 2 ?
                Container(
                  margin: EdgeInsets.only(left: 20,top:10, right: 12,bottom: 10),
                  child:Text("old_notification".tr,  
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ):Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            Container(
                               margin: EdgeInsets.only(top:14),
                              child: ListTile(
                                 onTap: (){
                                  Get.to(AdViewScreen(),arguments:data[index]['notifiable']['id'],);
                                },
                                title:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    SizedBox(height: 3,),
                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Get.width/2,
                                          child: Text(
                                            data[index]['message'],textAlign: TextAlign.left, 
                                            style: TextStyle(
                                              fontSize: 14, fontStyle:FontStyle.normal,
                                            )
                                          ),
                                        ),
                                          GestureDetector(
                                        onTap: () {
                                          controller.deleteNotificationController(data[index]['id']);
                                          print(data[index]['id']);
                                        },
                                          child: Icon(Icons.cancel, color: Colors.grey,))
                                      ],
                                    ),
                                  ],
                                ),
                                 leading:
                                 data[index]['notifier']['image']
                                 != null ?
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(NotifierUser(),arguments:data[index]['notifier']['id'] );
                                      print(data[index]['notifier']['id']);
                                    },
                                    child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(data[index]['notifier']['image']['url'])),
                                  ) : Icon(Icons.image),
                                ),
              
                              ),
                             data[index]['notifiable']  != null ?
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              alignment: Alignment.topRight,
                              child:Text(
                              convertToAgo(inputDate)
                              )
                            ): Container(),
                            // SizedBox(height:10)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            );
        }     
      ),
     );
  }
}