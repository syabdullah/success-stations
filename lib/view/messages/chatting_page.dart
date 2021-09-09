import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:success_stations/view/messages/inbox.dart';

var loginUser, conversationID, loginToken;
class ChattinPagePersonal extends StatefulWidget {
  _ChattinPageState createState() => _ChattinPageState();
}

class _ChattinPageState extends State<ChattinPagePersonal> {
  GetStorage box = GetStorage();
  List<ChatMessage> me = [];
  ScrollController controller = new ScrollController();
  final chatCont = Get.put(ChatController());
  TextEditingController msg = TextEditingController();
  var userId, userData,  image, page = 1;
  List dataArray = [];
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    userData = Get.arguments;
    userId = box.read('user_id');
    conversationID = userData[0];
    image = box.read('chat_image');
    connect(conversationID, userId);
  }

  void connect(conversationID, userId) { 
    loginToken=  box.read('access_token');

    socket = IO.io('https://ssnode.codility.co',
      IO.OptionBuilder()
      .setTransports(['websocket'])
      .build()
    );
    socket.connect();
    socket.on('connect', (_) => print('connect with token: $loginToken  conversationID: $conversationID userId: $userId'));
    socket.on('message', handleMessage);
    socket.emit('joinRoom', { "token": loginToken, "room": "convo-$conversationID" , "username": "user-$userId" });
    socket.onDisconnect((_) => print('disconnect'));
  }

  sendMessage(String chatMessage) {
    print("On sedn message.... Function$chatMessage");
    socket.emit("chatMessage", chatMessage);
  }

  handleMessage(data) {
    print("Hnalder Message function..........>$data");
    // dataArray.add(data);
    chatCont.loadMessage(data);
    print("Hnalder Message function..........>$dataArray");
  }
 //reviewd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: textFieldDataSender(),
      body: Stack(
        children: [
          Column(
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
                        onTap: (){
                          Get.off(Inbox());
                        },
                        child: Image.asset(AppImages.arrowBack)
                      ),
                      elevation: 0,
                      backgroundColor: AppColors.appBarBackGroundColor,
                      centerTitle: true,
                      title:Text(userData[1].toString(),
                        style: AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
                      )
                    ),
                        
                  ],
                )
              ),
            ],
          ),
          chattingList(),
          // showMessage(dataArray),
          FractionalTranslation(
            translation: Get.height > 700 ? const Offset(1.4, 1.4): const Offset(0.2, 0.9),
            child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: image != null ? Image.network(image,fit: BoxFit.fill,height: 80,): Icon(Icons.person, color: Colors.blue[100],)
              ),
            )
          ),
          textFieldDataSender()
        ],
      ),
    );
  }

  bool isLoading = false;
  //reviewed
  Future _loadData(data) async {
    print("load data calling .......$data");
    await Future.delayed(new Duration(seconds: 1));
    if (data != null) {
      ++page;
      await chatCont.getChatConvo(conversationID, page);
    }
    setState(() {
      isLoading = false;
    });
  }
  //reviewed
  Widget messageList(messages, nextPageUrl) {
    print("dataArray handlerMessage......$dataArray");
    print("data list of get Api.......$nextPageUrl");
    return Container(       
      height: Get.height/1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: Get.height/5.0, bottom: 25),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            isLoading = true;
            _loadData(nextPageUrl);
          }
          return false;
          },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          reverse: true,
          controller: controller,
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          // physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(left: 14,right: 14,top: 14,bottom: 30),
              child: Align(
                alignment: (userId != messages[index]["created_by"]? Alignment.topLeft: Alignment.topRight ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)
                    ),
                    color: (userId != messages[index]["created_by"]? Colors.grey.shade200 : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(messages[index]['message'], style: TextStyle(fontSize: 15),),
                ),
              ),
            );
           
          },
        ),
      ),
    );
  }
  //reviewed
  Widget textFieldDataSender() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(78)
        ),
        margin: EdgeInsets.symmetric(horizontal:15),
        child: Row(
          children: <Widget>[
            SizedBox(width: 15,),
            Expanded(
              child: TextField(
                controller: msg,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Type your message here",
                  hintStyle: TextStyle(color: Colors.grey),
                  
                ),
              ),
            ),
            SizedBox(width: 15,),
            Container(
              padding: EdgeInsetsDirectional.all(8),
              child: FloatingActionButton(
                onPressed: (){
                  sendMessage(msg.text);
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
            ),
          ],
        ),
      ),
    );
  }

  //reviewed
  Widget chattingList() {
    return Container(
      margin: EdgeInsets.only(top:Get.height/4.4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(50),topRight:Radius.circular(50)
        ),
        color: Colors.grey[100],
      ),
      child:  Container(
        child: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (val) {
            if(val.isLoading == false && val.chat!=null && val.chat['data'] !=null ) {
              if(val.chat['data']['participants']!=null){
                if(val.chat['data']['participants'][0]['id'] == userId) {
                  if (val.chat['data']['participants'][1]['image'] != null) {
                    image = val.chat['data']['participants'][1]['image']['url'];
                  }
                }
              }
            }
            return val.isLoading == false && val.allChat.length != 0 ? 
            ListView(
              children: [
                messageList(val.allChat, val.chat['data']['messages']['next_page_url']),
              ],
            ): Container();
          },
        )
      ),
    );
  }
}
//reviewed
class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
