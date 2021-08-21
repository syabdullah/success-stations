
import 'dart:convert';

import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';
import 'package:success_stations/action/friends.dart';
import 'package:success_stations/utils/snack_bar.dart';

class FriendsController extends GetxController {
  // final repetedCon = Get.put(FriendsController());
  List countryListdata = [];
  bool isLoading = false; 
  var friendsData;
  var sendReq;
  var appReq;
  var rejReq;
  var suggestionsData;
  var friendProfileData;
  var userAds,addAd,removeAds;
  
  @override
  void onInit() { 
    isLoading = true;
    super.onInit();
  }

  getSuggestionsList() async {
    isLoading = true ;
    await suggestions().then((res) {
      var data = jsonDecode(res.body);
      suggestionsData = data['data'];
      // print("..........ssssss.....$suggestionsData");
      isLoading = false;  
    }).catchError((e){
      return e;
    });
    update();
  }

  getFriendsList() async {
    isLoading = true ;
    await allFriends().then((res) {
      friendsData = jsonDecode(res.body);
      print("...............$friendsData");
      isLoading = false;  
    }).catchError((e){
      return e;
    });
    update();
  }

  appFriend(id) async {
    isLoading = true ;
    print(".......aaaaaaaaaa........$id");
    await approveFriends(id).then((res) {
      print(".......aaaaaaaaaa........${jsonDecode(res.body)}");
      if(res.statusCode ==200 || res.statusCode < 401)
      getFriendsList();
      // friendsData = jsonDecode(res.body);
      isLoading = false;  
    }).catchError((e){
      return e;
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
    }).catchError((e){
      return e;
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
    }).catchError((e){
      return e;
    });
    update();
  }

  deleteFriend(id) async {
    isLoading = true ;
    await delFriendReq(id).then((res) {
      friendsData = jsonDecode(res.body);
      isLoading = false;  
    }).catchError((e){
      return e;
    });
    update();
  }

  friendDetails(id) async {
    isLoading = true ;
    await friendsProfile(id).then((res) {
      // print("/././././.-----$id");
      friendProfileData = jsonDecode(res.body);
      // print("/././././.-----$friendProfileData");
      isLoading = false;  
    }).catchError((e){
      return e;
    });
    update();
  }

   profileAds(id) async{
    isLoading = true ;
    await getUserAds(id).then((res) {
      userAds = jsonDecode(res.body);
     
      isLoading = false;
    });
    update();
  }

  profileAdsToFav(id,userId) async{
    print("/././././.-----$id");
    isLoading = true ;
    await addAdsFav(id).then((res) {
      addAd = jsonDecode(res.body);
      
      if(addAd['success'] == true) {
        profileAds(userId);
        SnackBarWidget().showToast("", addAd['message']); 
        
      }
       print("/././././.-----$addAd");
      isLoading = false;
    });
    update();
  }
  
  profileAdsRemove(id, userId) async{
    print(".........remove.......profileAdsRemove....profileAdsRemove....profileAdsRemove......App.........$id");
    isLoading = true ;
    await removeAdsFav(id).then((res) {

    print("!!!!!!!!!!!!!!!!!!!!!!>>>>>>>>>>!!!!!!!!!!!!!!!!$id .............>>>>${res.body}");
      removeAds = jsonDecode(res.body);
      print("remove adds ..........remove adds......$removeAds");
      if(removeAds['success'] == true) {
        print(".....!!!!!!!!!!!!!!!!!!!!!!if Condition");
        if(userId !=null)
        profileAds(userId);
        SnackBarWidget().showToast("", removeAds['message']); 
      }
      // Get.off(repetedCon);
      //  print("/././././.-----$userAds");
      isLoading = false;
    });
    update();
  }  




























}