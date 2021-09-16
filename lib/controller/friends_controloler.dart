import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/action/ads_action.dart';
import 'package:success_stations/action/all_adds_category_action.dart';
import 'package:success_stations/action/friends.dart';
import 'package:success_stations/action/report_user_action.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/favorite_controller.dart';
import 'package:success_stations/utils/snack_bar.dart';

class FriendsController extends GetxController {
  final repetedCon = Get.put(FavoriteController());
  final allads = Get.put(AddBasedController());
  List countryListdata = [];
  bool isLoading = false;
  var friendsData;
  var sendReq;
  var appReq;
  var rejReq;
  var suggestionsData;
  var friendProfileData;
  var userAds, addAd, removeAds, rep;

  @override
  void onInit() {
    isLoading = true;
    super.onInit();
  }

  getSuggestionsList() async {
    isLoading = true;
    await suggestions().then((res) {
      var data = jsonDecode(res.body);
      suggestionsData = data['data'];
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  getFriendsList() async {
    isLoading = true;
    await allFriends().then((res) {
      friendsData = jsonDecode(res.body);
      print("...............$friendsData");
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  appFriend(id) async {
    isLoading = true;
    await approveFriends(id).then((res) {
      if (res.statusCode == 200 || res.statusCode < 401) getFriendsList();
      // friendsData = jsonDecode(res.body);
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  rejFriend(id) async {
    isLoading = true;
    await rejectFriends(id).then((res) {
      // friendsData = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200 || res.statusCode < 401) getFriendsList();

      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  sendFriend(data) async {
    isLoading = true;
    await sendFriendReq(data).then((res) {
       
      if ( res.statusCode ==  200 || res.statusCode < 400) {
        sendReq = jsonDecode(res.body);
        SnackBarWidget().showToast("", sendReq['message']);
      }else {
        SnackBarWidget().showToast("", res.body);
      }
      getFriendsList();
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  deleteFriend(id,pro) async {
    isLoading = true;
    await delFriendReq(id).then((res) {
      getFriendsList();
      getSuggestionsList();
      print(res.body);  
       if(pro == 'pro') {
         Get.back();
       }
      SnackBarWidget().showToast("", res.body);
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  friendDetails(id) async {
    isLoading = true;
    await friendsProfile(id).then((res) {
      friendProfileData = jsonDecode(res.body);
      isLoading = false;
    }).catchError((e) {
      return e;
    });
    update();
  }

  profileAds(id) async {
    isLoading = true;
    await getUserAds(id).then((res) {
      userAds = jsonDecode(res.body);
      print("......here the reo.....!!!!!!...!!!!>.......$userAds");
      isLoading = false;
    });
    update();
  }

  profileAdsToFav(id, userId) async {
    isLoading = true;
    await addAdsFav(id).then((res) {
      addAd = jsonDecode(res.body); 
      print("addAd ......... favourite message ........$addAd");    
      if(addAd['success'] == true) {
        if(userId != null)
        profileAds(userId);
        //SnackBarWidget().showToast("", addAd['message']); 
      }
      isLoading = false;
    });
    update();
  }

  profileAdsRemove(id, userId) async {
    isLoading = true;
    await removeAdsFav(id).then((res) {
      removeAds = jsonDecode(res.body);
      if (removeAds['success'] == true) {
        if (userId != null) profileAds(userId);
        repetedCon.favoriteList();
        //SnackBarWidget().showToast("", removeAds['message']);
      }
      isLoading = false;
    });
    update();
  }

  userReport(data, userId) async {
    isLoading = true;
    await reportUser(data).then((res) {
      rep = jsonDecode(res.body);
      if (rep['success'] == true) {
        SnackBarWidget().showToast("", rep['message']);
      } else {
        SnackBarWidget().showToast("", rep['errors']);
        isLoading = false;
      }
    });
    update();
  }

  var cData;
  addedByIdAddes(id, userId) async {
    isLoading = true;
    await basedAddById(id, userId).then((res) {
      cData = jsonDecode(res.body);
      isLoading = false;
    });
    update();
  }
}
