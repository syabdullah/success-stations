import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';

class ChattingPage extends StatefulWidget {
  _ChattingState createState() => _ChattingState();
}
class _ChattingState extends State<ChattingPage> {

  List<ChatMessage> me = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
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
                  title:Text( "INBOX",
                    style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
                  )
                ),  
              ],
            )
          ),
          messageList(),
          
        ],
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: me.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                    child: Align(
                      alignment: (me[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)
                          ),
                          color: (me[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(me[index].messageContent, style: TextStyle(fontSize: 15),),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Container(
                  width: Get.width/ 2.2,
                  padding: EdgeInsets.only(left:20),
                  decoration: BoxDecoration(  borderRadius: BorderRadius.circular(10),),

                  // child: Row(
                  //   children: [
                     child:  TextFormField(
                       
                        cursorColor: Colors.lightGreen,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                         
                          
                          suffixIcon:Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Image.asset(AppImages.fav, height: 10,),
                          ),
                          hintText: 'Type your message here',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightGreen
                            )
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide()
                          ),
                        )
                      ),
                      //  Icon(Icons.send)
                  //   ],
                  // ),
                ),
               
              ],
            )
          ],
        ),
    );
  }
}





class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}