import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/bottom_bar.dart';
import 'package:success_stations/view/messages/chat.dart';

class Inbox extends StatefulWidget {
  _InboxState createState() => _InboxState();
}
class _InboxState extends State<Inbox> {
 final chatCont = Get.put(ChatController());
   @override
  void initState() {
    super.initState();
    chatCont.getAllConvo();
    // _controller = TabController(length: 2,vsync: this); 
  }
 Widget messageList(data) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
           color: Colors.white,
      ),
      margin: EdgeInsets.only(top:Get.height/3.0),
      height: Get.height/1.2,
      child: ListView.builder(
      itemCount: data[0]['participants'].length,
      itemBuilder: (context, index) {
        print("-----====-=-=-=-${data[index]}");
      return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: chatListView(data[0]['participants'][index]),
          )
    );
  },
),
    );
  }


Widget chatListView(data){
  return ListTile(
    onTap: (){
      chatCont.createConversation(data['id']);
      Get.to(ChattingPage(),arguments: data['pivot']['conversation_id']);
    },
    title: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Icon(Icons.person)),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left:12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'],
                  style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7,),
                 Text(data['message'] != null ? data['message'] :'',
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
Widget recentlyContacted(data){
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(left:25.0,),
        child: recentChat(data[index]),
      );});
}
Widget recentChat(data){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap : (){
          Get.to(ChattingPage(),arguments: data['id']);

        },
        child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: Icon(Icons.person)),
          ),
      ),
        SizedBox(height: 5,),
        Text(data['name'],style: TextStyle(fontSize: 10,color: Colors.white),
        )
    ],
  );
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (val) {

       return  Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.appBarBackGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppBar(
                     leading:GestureDetector(
                       onTap: (){Get.off(BottomTabs());},
                       child: Image.asset(AppImages.arrowBack)),
                    elevation: 0,
                    backgroundColor: AppColors.appBarBackGroundColor,
                      centerTitle: true,
                       title:
                        Text("inbox".tr,
                        style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
                        )
                      ),
                   Padding(
                     padding: const EdgeInsets.only(top:0.0,left:20),
                     child: Text("recentelyContact".tr,
                       style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.normal, color:Colors.white,),
                      ),
                   ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top:25.0,),
                      // color: Colors.white,
                      height: Get.height,
                      child: val.isLoading ==false && val.allConvo['success'] == true ? recentlyContacted(val.allConvo['data']['data']) :Container()
                  
                    ),
                  )     
                ],
              )
            ),
            val.isLoading ==false && val.allConvo['success'] == true ? messageList(val.allConvo['data']['data']):Container(
              margin: EdgeInsets.only(top:Get.height/3.0),
              decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
           color: Colors.white,
      ),
            )
            
          ],
        );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appBarBackGroundColor,
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}