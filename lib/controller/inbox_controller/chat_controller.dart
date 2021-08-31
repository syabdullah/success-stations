
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';
import 'package:success_stations/action/messages/inbox_action.dart';
import 'package:success_stations/view/messages/chat.dart';

class ChatController extends GetxController {
  bool isLoading = false; 
  var adsCreate;
  var chat;
  var allConvo;
  

  @override
  void onInit(){
    isLoading = true;
    super.onInit();
  }

  createConversation(data) async{
    isLoading = true ;
    await createconvo(data).then((res) {
      adsCreate = jsonDecode(res.body);
      print("//.//././.------$adsCreate");
      if(res.statusCode == 200 || res.statusCode < 400) {
        getChatConvo(adsCreate['data']['id']);
        
      }
      isLoading = false;
    });
    update();
  }
 getChatConvo(id) async{
    isLoading = true ;
    await getconvo(23).then((res) {
      chat = res.body;
      
      if(res.statusCode == 200 || res.statusCode < 400) {
        chat = jsonDecode(res.body);
        // print("//.//././.-----000000----$chat");
        // Get.to(ChattingPage());
      }
      isLoading = false;
    });
    update();
  }
 
  getAllConvo() async{
    isLoading = true ;
    await  getAllChats().then((res) {
      allConvo = res.body;
      
      if(res.statusCode == 200 || res.statusCode < 400) {
        allConvo = jsonDecode(res.body);
        // print("//.//././.-----000000----$allConvo");/
      }
      isLoading = false;
    });
    update();
  }
 
}
