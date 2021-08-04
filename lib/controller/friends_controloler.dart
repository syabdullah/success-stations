
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/friends.dart';

class FriendsController extends GetxController {
  List countryListdata = [];
  bool isLoading = false; 
  var friendsData;
  @override
  void onInit() { 
    isLoading = true;
    super.onInit();
  }

  getFriendsList() async{
    isLoading = true ;
    await allFriends().then((res) {
      friendsData = jsonDecode(res.body);
      print("...............$friendsData");
      isLoading = false;  
    });
    update();
  }

  appFriend(id) async{
    isLoading = true ;
    await approveFriends(id).then((res) {
      print(".......aaaaaaaaaa........${jsonDecode(res.body)}");
      // friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }

  rejFriend(id) async{
    isLoading = true ;
    await rejectFriends(id).then((res) {
      friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }

  sendFriend(id) async{
    isLoading = true ;
    await sendFriendReq(id).then((res) {
      friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }

  deleteFriend(id) async{
    isLoading = true ;
    await delFriendReq(id).then((res) {
      friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }
}