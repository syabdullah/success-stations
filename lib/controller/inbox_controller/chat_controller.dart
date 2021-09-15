
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/action/messages/inbox_action.dart';

class ChatController extends GetxController {
  bool isLoading = false; 
  var adsCreate;
  var chat;
  var allConvo;
  var read;
  var allChat = [];
  
  GetStorage box = GetStorage();
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
      if(res.statusCode == 200 || res.statusCode < 400) {
         box.write('con_id',adsCreate['data']['id']);
        getChatConvo(adsCreate['data']['id'],1);        
      }
      isLoading = false;      
    });
    update();
  }

  readConversation(data) async{
    isLoading = true ;
    await readMessage(data).then((res) {
      read = jsonDecode(res.body);    
      print(",.........$read");
      if(res.statusCode == 200 || res.statusCode < 400) {   
      }
      isLoading = false;      
    });
    update();
  }


  getChatConvo(id,page) async{
    isLoading = true ;
    allChat = [];
    await getconvo(id,page).then((res) {
      chat = res.body;
      if(res.statusCode == 200 || res.statusCode < 400) {
        chat = jsonDecode(res.body);
        // print(" chat response controller.....................$chat");
        if(chat['data'] !=null && chat['data']['messages']['data']!=null){
          for(int m = 0; m < chat['data']['messages']['data'].length; m++ ){
            allChat.add(chat['data']['messages']['data'][m]);
            // print(" chat response controller................---------.....${allChat.length}");
            // print("Allchat printed/........$allChat");

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
 loadMessage(message){
    allChat.insert(0, message);
    print(" chat response controller.....................${allChat.length}");
    update();
  }
}
