import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/messages/inbox.dart';

class ChattingPage extends StatefulWidget {
  _ChattingState createState() => _ChattingState();
}
class _ChattingState extends State<ChattingPage> {
var uId;
  List<ChatMessage> me = [
    // ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    // ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    // ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    // ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    //  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    //  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    // ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    // ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    // ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  final chatCont = Get.put(ChatController());
  TextEditingController msg = TextEditingController();
  var id;
  GetStorage box = GetStorage();
   @override
  void initState() {
    super.initState();
     id = Get.arguments;
     uId = box.read('user_id');
     print(id);
    //  chatCont.getChatConvo(id);
    // _controller = TabController(length: 2,vsync: this); 
  }
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
                  leading:GestureDetector(
                    onTap: () {
                      Get.off(Inbox());
                    },
                    child: Image.asset(AppImages.arrowBack)),
                  elevation: 0,
                  backgroundColor: AppColors.appBarBackGroundColor,
                  centerTitle: true,
                  title:Text( "INBOX",
                    style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
                  )
                ),  
              ],
            )
          ),
          GetBuilder<ChatController>(
            init: ChatController(),
            builder: (val) {
              return messageList(val.chat['data']['messages']);
            },
          ),         
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white10,
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      setState(() {
                        me.add(
                        ChatMessage(messageContent: msg.text,messageType: "sender")
                      );
                      msg.clear();
                      });
                      
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget messageList(data) {
    print(".......................>$data");
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(top:Get.height/5.0,bottom: 25),
        // height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: data['data'].length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (uId != data['data'][index]["created_by"]?Alignment.topLeft:Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)
                            ),
                            color: (uId != data['data'][index]["created_by"]?Colors.grey.shade200:Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(data['data'][index]['message'], style: TextStyle(fontSize: 15),),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}





class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}