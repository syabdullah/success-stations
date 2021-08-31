import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/messages/inbox.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChattingPage extends StatefulWidget {
  _ChattingState createState() => _ChattingState();
}
class _ChattingState extends State<ChattingPage> {
var uId;
ScrollController controller = new ScrollController();
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController msg = TextEditingController();
  var id,userId;
  var userData;
  var image;
  GetStorage box = GetStorage();
   @override
  void initState() {
    super.initState();
     userData = Get.arguments;
     userId = box.read('user_id');
     id = userData[0];
     image = box.read('chat_image');
     controller.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
     uId = box.read('user_id');
     print(id);
    //  chatCont.getChatConvo(id);
    // _controller = TabController(length: 2,vsync: this); 
  }
   final _channel = WebSocketChannel.connect(
    Uri.parse('wss://http://49.12.192.180'),
  );
   void _sendMessage() {
    if (msg.text.isNotEmpty) {
      print(msg.text);
      _channel.sink.add(msg.text);
    }
  }
   @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(50.0),
        key: _scaffoldKey,
        child:  AppBar(
          leading:Container(
            margin: EdgeInsets.only(top:20),
            child: GestureDetector(
              // behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.off(Inbox());
              },
              child: Image.asset(AppImages.arrowBack)),
          ),
          elevation: 0,
          backgroundColor: AppColors.appBarBackGroundColor,
          centerTitle: true,
          title:Container(
            margin: EdgeInsets.only(top:20),
            child: Text(userData[1] ,
              style:AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white,),
            ),
          )
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height/3.5,
            width: Get.width,
            color: AppColors.appBarBackGroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
              ],
            )
          ),
          
          Container(
            child: GetBuilder<ChatController>(
              init: ChatController(),
              builder: (val) {
                if(val.isLoading == false && val.chat != null) {
                  if(val.chat['data']['participants'][0]['id'] == userId) {
                    print(".............11111---${val.chat['data']['participants'][1]['image']}");
                    if (val.chat['data']['participants'][1]['image'] != null) {
                    image = val.chat['data']['participants'][1]['image']['url'];
                  }
                  }
                }
                return Column(
                  children: [
                    val.isLoading == false && val.chat != null? messageList(val.chat['data']['messages']):Container(
                    )
                  ],
                );
              },
            ),
          ), 
          FractionalTranslation(
            translation: Get.height > 700 ? const Offset(2.0, 1.7): const Offset(0.2, 0.9),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: image != null ? Image.network(image,fit: BoxFit.fill,height: 80,): Icon(Icons.person)
              ),
            )
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
                      _sendMessage();
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
    
    // controller.jumpTo(controller.position.maxScrollExtent);
    return  StreamBuilder(
      stream: _channel.stream,
      builder: (context, snapshot) {
        print(".......................>${snapshot.data}");
        return 
                // Text(snapshot.hasData ? '${snapshot.data}' : '');            
        Container(       
          height: Get.height/1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50)),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(top:Get.height/5.0,bottom: 25),
          // height: Get.height,
            child: ListView.builder(
              reverse: true,
              controller: controller,
              itemCount: data['data'].length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 14,bottom: 30),
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
        );
      },
    );
  }
}





class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}