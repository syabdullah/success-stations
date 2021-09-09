
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/messages/inbox_action.dart';

class ChatController extends GetxController {
  bool isLoading = false; 
  var adsCreate;
  var chat;
  var allConvo;
  var allChat = [];
  

  @override
  void onInit(){
    allChat=[];
    isLoading = true;
    super.onInit();
  }

  createConversation(data) async{
    isLoading = true ;
    await createconvo(data).then((res) {
      adsCreate = jsonDecode(res.body);
      print("//.//././.------$adsCreate");
      if(res.statusCode == 200 || res.statusCode < 400) {
        getChatConvo(adsCreate['data']['id'],1);
        
      }
      isLoading = false;
      
    });
    update();
  }

  loadMessage(message){
    allChat.add(message);
    update();
  }

  getChatConvo(id,page) async{
    isLoading = true ;
    await getconvo(id,page).then((res) {
      chat = res.body;
      if(res.statusCode == 200 || res.statusCode < 400) {
        chat = jsonDecode(res.body);
        print(" chat response controller.....................$chat");
        if(chat['data'] !=null && chat['data']['messages']['data']!=null){
          for(int m = 0; m < chat['data']['messages']['data'].length; m++ ){
            allChat.add(chat['data']['messages']['data'][m]);
            print("Allchat printed/........$allChat");

          }
        }
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
