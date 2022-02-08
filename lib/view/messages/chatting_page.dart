import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/main.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:ui' as ui;

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
  var userId, userData, image, page = 1;
  List dataArray = [];
  late IO.Socket socket;
  final TextDirection? textDirection = TextDirection.LTR;

  @override
  void initState() {
    super.initState();
    userData = Get.arguments;
    userId = box.read('user_id');
    if (userData[0] == 0) {
    } else
      conversationID = userData[0];
    image = box.read('chat_image');
    connection();
  }

  void connection() async {
    loginToken = await box.read('access_token');
    if (userData[0] == 0) conversationID = await box.read('con_id');
    //  chatCont.getChatConvo(conversationID, page);
    var json = {'conversation_id': conversationID};
    chatCont.readConversation(json);
    try {
      socket = IO.io('https://ssnode.codility.co',
          IO.OptionBuilder().setTransports(['websocket']).build());
      socket.connect();
      socket.on(
          'connect',
          (_) => print(
              'connect with token: $loginToken  conversationID: $conversationID userId: $userId'));
      socket.on('message', handleMessage);
      socket.emit('joinRoom', {
        "token": loginToken,
        "room": "convo-$conversationID",
        "username": "user-$userId"
      });
    } catch (e) {
      print(e.toString());
    }
  }

  sendMessage(String chatMessage) {
    print("On sedn message.... Function${chatMessage.length}");
    socket.emit("chatMessage", chatMessage);
  }

  handleMessage(data) {
    chatCont.loadMessage(data);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //reviewd
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          socket.dispose();
          chatCont.getAllConvo();
          var json = {'conversation_id': conversationID};
          chatCont.readConversation(json);
          Get.back();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    socket.dispose();

                    var json = {'conversation_id': conversationID};
                    chatCont.readConversation(json);
                    chatCont.getAllConvo();
                    Get.back();
                  },
                  child: Padding(
                    padding: lang == 'ar'
                        ? EdgeInsets.only(
                            right: Get.width * 0.03,
                            bottom: Get.width * 0.03,
                            top: Get.width * 0.03)
                        : EdgeInsets.only(
                            left: Get.width * 0.03,
                            bottom: Get.width * 0.03,
                            top: Get.width * 0.03),
                    child: ImageIcon(AssetImage(AppImages.imagearrow1)),
                  )),
              elevation: 0,
              backgroundColor: AppColors.whitedColor,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: image != null
                            ? Image.network(
                                image,
                                fit: BoxFit.fill,
                                height: 80,
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.blue[100],
                              )),
                  ),
                  Padding(
                    padding: lang == 'ar'
                        ? EdgeInsets.only(right: Get.width * 0.02)
                        : EdgeInsets.only(left: Get.width * 0.02),
                    child: Text(
                      userData[1].toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Source_Sans_Pro'),
                    ),
                  ),
                ],
              )),
          body: Stack(
            children: [
              chattingList(),
              textFieldDataSender()])));
  }

  bool isLoading = false;

  //reviewed
  Future _loadData(data) async {
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
    return Container(
      height: Get.height / 1.0,
      margin: EdgeInsets.only(bottom: 45),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
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
          padding: EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            var date = DateTime.parse(messages[index]["created_at"]);
            var time = DateFormat().add_jm().format(date.toLocal());
            return Container(
              padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
              child: Align(
                alignment: (userId != messages[index]["created_by"]
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  // width: Get.width/1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: userId == messages[index]["created_by"]
                            ? Radius.circular(0)
                            : Radius.circular(10.0),
                        topLeft: userId == messages[index]["created_by"]
                            ? Radius.circular(10.0)
                            : Radius.circular(0.0),
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                    color: (userId != messages[index]["created_by"]
                        ? Colors.grey.shade200
                        : AppColors.whitedColor),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        messages[index]['message'],
                        style: TextStyle(
                            fontSize: 16,
                            color: userId == messages[index]["created_by"]
                                ? Colors.white
                                : Colors.grey),
                      ),
                      Text(time.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: userId == messages[index]["created_by"]
                                  ? Colors.white
                                  : Colors.grey),
                          textDirection: ui.TextDirection.ltr),
                    ],
                  ),
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
        child: Row(
          children: [
            Container(
              height: 40,
              width: Get.width - 45,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0XFFaaaaaa)),
                  color: Color(0XFFffffff),
                  borderRadius: BorderRadius.circular(78)),
              // margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: msg,
                maxLines: null,
                // maxLength: 160,
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
                  focusedBorder: InputBorder.none,
                  contentPadding: lang == 'en'
                      ? EdgeInsets.only(left: Get.width * 0.05, top: 8)
                      : EdgeInsets.only(right: Get.width * 0.05, top: 8),
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  // hintText: "Type_your_message_here".tr,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              height: Get.width * 0.1,
              child: InkWell(
                onTap: () {
                  sendMessage(msg.text);
                  setState(() {
                    me.add(ChatMessage(
                        messageContent: msg.text, messageType: "sender"));
                    msg.clear();
                  });
                },
                child: CircleAvatar(
                  child: ImageIcon(
                    AssetImage(AppImages.send),
                    color: Color(0XFF606996),
                    size: 18,
                  ),
                  backgroundColor: AppColors.whitedColor,
                ),
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
      margin: EdgeInsets.only(top: Get.height / 7.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(00), topRight: Radius.circular(00)),
        color: Color(0XFFffffff),
      ),
      padding: EdgeInsets.only(top: 20),
      child: Container(
          child: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (val) {
          if (val.isLoading == false &&
              val.chat != null &&
              val.chat['data'] != null) {
            if (val.chat['data']['participants'] != null) {
              if (val.chat['data']['participants'][0]['id'] == userId) {
                if (val.chat['data']['participants'][1]['image'] != null) {
                  image = val.chat['data']['participants'][1]['image']['url'];
                }
              }
            }
          }
          return val.isLoading == false && val.allChat.length != 0
              ?
              // ListView(
              //   reverse: true,
              //     children: [
              messageList(
                  val.allChat, val.chat['data']['messages']['next_page_url'])
              //   ],
              // )
              : Container();
        },
      )),
    );
  }
}

//reviewed
class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}
