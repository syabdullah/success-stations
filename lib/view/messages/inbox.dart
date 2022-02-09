import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/main.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/friends/friend_filter.dart';
import 'package:success_stations/view/friends/friend_filter_old.dart';
import 'package:success_stations/view/friends/friend_list.dart';
import 'package:success_stations/view/messages/chatting_page.dart';
import 'dart:ui' as ui;

class Inbox extends StatefulWidget {
  _InboxState createState() => _InboxState();
}
class _InboxState extends State<Inbox> {
 final chatCont = Get.put(ChatController());
 GetStorage box = GetStorage();
 var userId;
   @override
  void initState() {
    super.initState();
    chatCont.getAllConvo();
   userId =  box.read('user_id');
  }
  Widget messageList(data,allData) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: conData.length,
      padding: EdgeInsets.only(top: 15),
      itemBuilder: (context, index) {
        return chatListView(conData[index],allData['data'][index]);
      },
    );
  }

  Widget chatListView(data,dataWithMessage) {
    var date = DateTime.parse(dataWithMessage["last_message_at"] ?? DateTime.now().toString());
    var time = DateFormat().add_jm().format(date.toLocal());
   
    return Container(
      // height: Get.height < 700 ? Get.height/10: Get.height > 700 &&
      // Get.height > 800 ?  Get.height/9 : Get.height/8,
      // margin: EdgeInsets.only(left:10,right: 10,bottom:5),
      child: ListTile(
         onTap: (){
           if(data['image'] != null){
             box.write('chat_image', data['image']['url']);
           }else {
             box.remove('chat_image');
           }
           chatCont.getChatConvo(data['pivot']['conversation_id'], 1);
           Get.to(ChattinPagePersonal(),arguments: [data['pivot']['conversation_id'],data['name']]);
         },
         title:
         Row(
           children: [
             CircleAvatar(
               backgroundColor: Colors.grey[300],
               radius: 30,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(50.0),
                 child:  data['image'] != null ? Image.network(data['image']['url'],fit: BoxFit.fill,height: 67,) : Icon(Icons.person)
               ),
             ),
             Container(
               margin: lang == 'ar' ?  EdgeInsets.only(top: Get.width * 0.01,right: Get.width *  0.025):  EdgeInsets.only(top: Get.width * 0.01,left:Get.width * 0.03),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding:  EdgeInsets.only(bottom: Get.width * 0.01),
                     child: Text(
                       data['name'],
                       style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                     ),
                   ),
                   Container(
                     width: Get.width/3.0,

                     child: Text(
                       dataWithMessage['last_message'] != null ? dataWithMessage['last_message'] :'',
                       maxLines: 1,
                       style:TextStyle(color: Colors.grey,fontSize: 13,),
                     ),
                   ),
                 ],
               ),
             )
           ],
         ),
         trailing: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              dataWithMessage['messages_logs_count'] != 0 ?
              Container(
                width: 25,
                decoration: BoxDecoration(
                  color: AppColors.whitedColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Center(
                 child: Text(
                   dataWithMessage['messages_logs_count'].toString(),
                   style:TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,),
                 ),
                ),
              ) : Container(width: 20,),
             Container(
               margin: EdgeInsets.only(top: 10),
               child: Text(
                 time.toString(),
                 textAlign: TextAlign.end,
                 style: TextStyle(fontSize: 12,color: Colors.black),
                 textDirection: ui.TextDirection.ltr
               ),
             ),
           ],
         ),
       ),
    );
  }
  Widget recentlyContacted(data){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: conData.length ,
      itemBuilder: (context, index) {
      return
        Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: recentChat(conData[index]),
      );
    });  
  }
Widget recentChat(data){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap : (){
          chatCont.getChatConvo(data['pivot']['conversation_id'], 1);
          Get.to(ChattinPagePersonal(),arguments:[data['pivot']['conversation_id'], data['name']]);
        },
        child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(67.0),
              child: data['image'] != null ? Image.network(data['image']['url'],fit: BoxFit.fill,height: 60,) : Icon(Icons.person)),
          ),
      ),
        SizedBox(height: 5,),
        Text(data['name'],style: TextStyle(fontSize: 12,color: Colors.white),
        )
    ],
  ); 
}
 final GlobalKey<ScaffoldState> _key = GlobalKey();
 var conData=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: SizedBox(child: FriendFilter(),
      width: Get.width /1.5,),
      appBar:
        AppBar(
            leading:GestureDetector(
                onTap: (){
                  _key.currentState!.openDrawer();
                },
                child: ImageIcon(AssetImage(AppImages.setting),color: Color(0XFF181818),)
            ),
            elevation: 0,
          shape: Border(
              bottom: BorderSide(
                  color: Color(0xFFcccccc),
                  width: 1
              )
          ),
            backgroundColor: AppColors.white,
            centerTitle: true,
            title:Text("inbox".tr,
              style: AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Color(0XFF595959),),
            ),
          actions: [
            Padding(
              padding:  lang == 'ar' ? EdgeInsets.only(left: Get.width * 0.07) :EdgeInsets.only(right: Get.width * 0.07),
              child: InkWell(child: ImageIcon(AssetImage(AppImages.chat),color: Color(0XFF181818),),onTap: (){
                Get.to(FriendList());
              },),
            )
          ],
        ),
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (val) {
          conData=[];
          if(val.allConvo != null && val.allConvo['success'] == true) {
            for(int i = 0; i< val.allConvo['data']['data'].length; i++) {
              for(int j = 0; j< val.allConvo['data']['data'][i]['participants'].length; j++){
                if(val.allConvo['data']['data'][i]['participants'][j]['id'] != userId ) {
                  conData.add(
                    val.allConvo['data']['data'][i]['participants'][j]
                  );
                }
              }
            }
          }
          return  val.isLoading ==false && val.allConvo['success'] == true ? messageList(conData,val.allConvo['data']):Container(
          margin: EdgeInsets.only(top:Get.height/3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(50),topRight:Radius.circular(50)
            ),
            color: Colors.grey[100],
          ),
            );
        }
      ),
    );
  }
}