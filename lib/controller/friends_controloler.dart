
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/friends.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/utils/snack_bar.dart';

class FriendsController extends GetxController {
  List countryListdata = [];
  bool isLoading = false; 
  var friendsData;
  var sendReq;
  var appReq;
  var rejReq;
  var suggestionsData;
  var friendProfileData;
  @override
  void onInit() { 
    isLoading = true;
    super.onInit();
  }

  getSuggestionsList() async {
    isLoading = true ;
    await suggestions().then((res) {
      suggestionsData = jsonDecode(res.body);
      // print("..........ssssss.....$suggestionsData");
      isLoading = false;  
    });
    update();
  }

  getFriendsList() async {
    isLoading = true ;
    await allFriends().then((res) {
      friendsData = jsonDecode(res.body);
      // print("...............$friendsData");
      isLoading = false;  
    });
    update();
  }

  appFriend(id) async {
    isLoading = true ;
    await approveFriends(id).then((res) {
      // print(".......aaaaaaaaaa........${jsonDecode(res.body)}");
      if(res.statusCode ==200 || res.statusCode < 401)
      getFriendsList();
      // friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }

  rejFriend(id) async {
    isLoading = true ;
    await rejectFriends(id).then((res) {
      // friendsData = jsonDecode(res.body);
      print(res.body);
      if(res.statusCode ==200 || res.statusCode < 401)
      getFriendsList();

      isLoading = false;  
    });
    update();
  }

  sendFriend(data) async {
    isLoading = true ;
    await sendFriendReq(data).then((res) {
      print(".,.,.,.,RRRRR.,.,------${res.statusCode}");
      if(res.statusCode > 400 ) {
        SnackBarWidget().showToast("", res.body );  
      }
      sendReq = jsonDecode(res.body);
      getFriendsList();
      print(".,.,.,.,RRRRR.,.,$sendReq");
      isLoading = false;  
    });
    update();
  }

  deleteFriend(id) async {
    isLoading = true ;
    await delFriendReq(id).then((res) {
      friendsData = jsonDecode(res.body);
      isLoading = false;  
    });
    update();
  }

  friendDetails(id) async {
    isLoading = true ;
    await friendsProfile(id).then((res) {
      print("/././././.-----$id");
      friendProfileData = jsonDecode(res.body);
      print("/././././.-----$friendProfileData");
      isLoading = false;  
    });
    update();
  }

}