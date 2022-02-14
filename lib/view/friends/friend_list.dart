import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/app_bar_filtered_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/friends/friends_drawer.dart';
import 'package:success_stations/view/friends/friends_profile.dart';
import '../shimmer.dart';
import 'friend_request.dart';

class FriendList extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  static var friendlistappbar = GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
  var grid = AppImages.gridOf, id, selected, requisterId, lang;
  Color listIconColor = Colors.grey;
  Color gridIconColor = AppColors.whitedColor;
  final banner = Get.put(BannerController());
  final gridList = Get.put(GridListCategory());
  final friCont = Get.put(FriendsController());
  final callingFreindController = Get.put(FriendsController());
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gridList.listingGrid('grid');
    banner.bannerController();
    friCont.getFriendsList();
    friCont.getSuggestionsList();
    id = box.read('user_id');
    lang = box.read('lang_code');
  }

  result() {
    var json = {
      'name': nameController.text,
      'city': cityController.text,
      'degree': degreeController.text,
      'semester': semesterController.text
    };
    callingFreindController.searchFriendControl(json);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: appbar(friendlistappbar, context, AppImages.appBarLogo,
                  AppImages.appBarSearch, 1)),
          key: friendlistappbar,
          drawer: Theme(
              data: Theme.of(context).copyWith(
                  // canvasColor: AppColors.botomTiles
                  ),
              child: FriendsDrawer(globalKey: friendlistappbar)),
          body: GetBuilder<GridListCategory>(
              init: GridListCategory(),
              builder: (valuee) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: Get.height / 28,
                        child: TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          isScrollable: false,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          //For Selected tab
                          unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.normal),

                          indicatorColor: Colors.transparent,
                          labelPadding: EdgeInsets.all(0),
                          indicatorPadding: EdgeInsets.all(0),
                          tabs: [
                            _individualTab("All"),
                            _individualTab("Find Friend"),
                            _individualTab("Friend Request"),
                            _individualTab("My Request"),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      // height: Get.height<700? Get.height - Get.height * 0.3:Get.height - Get.height*0.28,
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          FriendReqList(),
                          findfriend(valuee),
                          friendRequest(),
                          // Center(
                          //   child: Text("friend request"),
                          // ),
                          Center(
                            child: Text("my request"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ));
  }

  Widget friendRequest() {
    return GetBuilder<FriendsController>(
        init: FriendsController(),
        builder: (val) {
          return val.suggestionsData == null
              ? Container(
                  height: Get.height / 1.5,
                  child: Center(
                      child: Text("No Record Found",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal))))
              : val.suggestionsData.length == 0 || val.suggestionsData == null
                  ? Container(
                      child: Text("suggestion".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)))
                  : val.friendsData != null
                      ? SingleChildScrollView(
                          child: Column(
                            children: friendLists(val.friendsData['data']),
                          ),
                        )
                      : friendReqShimmer();
        });
  }

  List<Widget> friendLists(data) {
    var count = 0;
    List<Widget> req = [];
    if (data != null)
      for (int i = 0; i < data.length; i++) {
        if (data[i]['requister'] != null && data[i]['status'] == null) {
          ++count;
          req.add(SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Card(
                    child: Row(
                      children: [
                        id == data[i]['requister_id']
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[100],
                                  child:
                                      data[i]['user_requisted']['image'] != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.network(
                                                  data[i]['user_requisted']
                                                      ['image']['url'],
                                                  fit: BoxFit.fill,
                                                  height: 60,
                                                  width: 60))
                                          : Image.asset(AppImages.person),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[100],
                                  child: data[i]['requisted'] != null &&
                                          data[i]['requisted']['image'] != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.network(
                                              data[i]['requisted']['image']
                                                  ['url'],
                                              fit: BoxFit.fill,
                                              height: 60,
                                              width: 60))
                                      : Image.asset(AppImages.person),
                                ),
                              ),
                        Column(
                          children: [
                            Container(
                                width: Get.width / 4,
                                child: id == data[i]['requister_id']
                                    ? Text(data[i]['user_requisted']['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                    : Text(data[i]['requister']['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Spacer(),
                        data[i]['requister']['id'] != id
                            ? GestureDetector(
                                onTap: () {
                                  friCont.appFriend(data[i]['id']);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.center,
                                    width: Get.width / 4.2,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.whitedColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Container(
                                      child: Text(
                                        "approve".tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              )
                            : GestureDetector(
                                onTap: () {
                                  friCont.deleteFriend(data[i]['id'], '');
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.center,
                                    width: Get.width / 3.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Container(
                                      child: Text(
                                        "cancel".tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                        data[i]['requister']['id'] != id
                            ? GestureDetector(
                                onTap: () {
                                  friCont.rejFriend(data[i]['id']);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: Get.width / 4.2,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'reject'.tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        }
        if (count == 0 && i == data.length) {
          req.add(Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, bottom: 10),
                child: Text(
                  "Friend Requests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Container(
                child: Text("No Friend Request!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ));
        }
      }
    return req;
  }

  Widget findfriend(valuee) {
    return GetBuilder<FriendsController>(
        init: FriendsController(),
        builder: (val) {
          return val.friendsData == null
              ? Expanded(
                  child: valuee.dataType == 'list' ? shimmer() : gridShimmer())
              : val.friendsData['success'] == false ||
                      val.friendsData['data'].length == 0 ||
                      val.friendsData == null
                  ? SingleChildScrollView(
                      child: Container(
                        // height: Get.height/1.5,
                        child: Center(
                            child: Text("nofriends".tr,
                                style: TextStyle(fontSize: 20))),
                      ),
                    )
                  : Expanded(
                      child: valuee.dataType == 'list'
                          ? friendGridView(val.friendsData['data'])
                          // friendList(val.friendsData['data'])
                          : friendGridView(val.friendsData['data']));
        });
  }

  var count = 0;

  Widget friendList(dataa) {
    print(".....!!!!!!!!!!!!razaaaa!!!!!!....$dataa");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: dataa.length,
        itemBuilder: (BuildContext context, index) {
          print(
              "sakdhdhdhhdhdhlsajxhsakjxhsa...${count == 0 && index == dataa.length - 1}");
          if (dataa[index]['status'] == "Accepted") {
            ++count;
          } else {
            count = 0;
          }
          return dataa[index]['status'] == "Accepted"
              ? GestureDetector(
                  onTap: () {
                    selected = box.write("selected", dataa[index]['id']);
                    requisterId =
                        box.write("requister", dataa[index]['requister_id']);
                    Get.to(FriendProfile(),
                        arguments: id != dataa[index]['requister_id']
                            ? [dataa[index]['id'], dataa[index]['requister_id']]
                            : [
                                dataa[index]['id'],
                                dataa[index]['user_requisted']['id']
                              ]);
                  },
                  child: Card(
                    child: ListTile(
                      trailing: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () {
                            friCont.deleteFriend(dataa[index]['id'], '');
                          },
                          child: Container(
                            height: 35,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text("remove".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          id != dataa[index]['requister_id']
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Container(
                                    child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.grey[100],
                                        child: dataa[index]['requister']
                                                    ['image'] !=
                                                null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: Image.network(
                                                  dataa[index]['requister']
                                                      ['image']['url'],
                                                  height: 80,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Image.asset(AppImages.person)),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Colors.grey[100],
                                      child: dataa[index]['user_requisted']
                                                  ['image'] !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.network(
                                                dataa[index]['user_requisted']
                                                    ['image']['url'],
                                                height: 80,
                                                fit: BoxFit.fill,
                                              ))
                                          : Image.asset(AppImages.person)),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: id == dataa[index]['requister_id']
                                      ? Text(
                                          dataa[index]['user_requisted']
                                              ['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          dataa[index]['requister']['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                              Container(
                                  width: Get.width / 3,
                                  margin: EdgeInsets.only(left: 10),
                                  child: id == dataa[index]['requister_id']
                                      ? Text(
                                          dataa[index]['user_requisted']
                                                  ['degree'] ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          dataa[index]['requister']['degree'] ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              : count == 0 && index == dataa.length - 1
                  ? Center(
                      heightFactor: 22,
                      child:
                          Text("nofriends".tr, style: TextStyle(fontSize: 20)))
                  : Container();
        },
      ),
    );
  }

  Widget friendGridView(dataGrid) {
    var newData = [];
    for (int i = 0; i < dataGrid.length; i++) {
      if (dataGrid[i]['status'] == "Accepted") {
        newData.add(dataGrid[i]);
      }
    }
    return newData.length == 0
        ? Container(
            height: Get.height,
            child: Center(
                child: Text("nofriends".tr, style: TextStyle(fontSize: 20))),
          )
        : Padding(
            padding: EdgeInsets.only(top: Get.height * 0.002),
            child: SizedBox(
              child: GridView.count(
                  padding: EdgeInsets.only(left: Get.width * 0.005),
                  crossAxisCount: 2,
                  childAspectRatio: (Get.height < 700
                      ? Get.width / Get.height * 1.30
                      : Get.width / Get.height * 1.4),
                  children: List.generate(
                    newData.length,
                    (index) {
                      return GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 0),
                                id != newData[index]['requister_id']
                                    ? Stack(
                                        children: [
                                          newData[index]['requister']
                                                      ['image'] !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  child: Image.network(
                                                    "https://www.wallpaperup.com/uploads/wallpapers/2013/12/15/196200/f2c43e4304abcbd78e81c243a33bfb54-375.jpg",
                                                    height: Get.height * 0.08,
                                                    width: Get.width,
                                                    fit: BoxFit.fill,
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  child: Image.network(
                                                    "https://www.wallpaperup.com/uploads/wallpapers/2013/12/15/196200/f2c43e4304abcbd78e81c243a33bfb54-375.jpg",
                                                    height: Get.height * 0.08,
                                                    width: Get.width,
                                                    fit: BoxFit.fill,
                                                  )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: Get.width * 0.01,
                                                left: Get.width * 0.01,
                                                top: Get.height * 0.02),
                                            child: Center(
                                              child: Container(
                                                child: CircleAvatar(
                                                    radius: Get.height * 0.06,
                                                    backgroundColor:
                                                        Colors.grey[100],
                                                    child: newData[index][
                                                                    'requister']
                                                                ['image'] !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            child:
                                                                Image.network(
                                                              newData[index][
                                                                      'requister']
                                                                  [
                                                                  'image']['url'],
                                                              height:
                                                                  Get.height *
                                                                      0.2,
                                                              fit: BoxFit.fill,
                                                            ))
                                                        : Image.asset(
                                                            AppImages.person)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: Get.width * 0.02,
                                            top: Get.width * 0.02,
                                            child: InkWell(
                                              onTap: () {
                                                friCont.deleteFriend(
                                                    newData[index]['id'], '');
                                              },
                                              child: Image.asset(
                                                AppImages.remove_friend,
                                                height: Get.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          newData[index]['requister']
                                                      ['image'] !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  child: Image.network(
                                                    "https://www.wallpaperup.com/uploads/wallpapers/2013/12/15/196200/f2c43e4304abcbd78e81c243a33bfb54-375.jpg",
                                                    height: Get.height * 0.08,
                                                    width: Get.width,
                                                    fit: BoxFit.fill,
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  child: Image.network(
                                                    "https://www.wallpaperup.com/uploads/wallpapers/2013/12/15/196200/f2c43e4304abcbd78e81c243a33bfb54-375.jpg",
                                                    height: Get.height * 0.08,
                                                    width: Get.width,
                                                    fit: BoxFit.fill,
                                                  )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: Get.width * 0.01,
                                                left: Get.width * 0.01,
                                                top: Get.height * 0.02),
                                            child: Center(
                                              child: Container(
                                                child: CircleAvatar(
                                                    radius: Get.height * 0.06,
                                                    backgroundColor:
                                                        Colors.grey[100],
                                                    child: newData[index][
                                                                    'requister']
                                                                ['image'] !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            child:
                                                                Image.network(
                                                              newData[index][
                                                                      'requister']
                                                                  [
                                                                  'image']['url'],
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                              fit: BoxFit.fill,
                                                            ))
                                                        : Image.asset(
                                                            AppImages.person)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: Get.width * 0.02,
                                            top: Get.width * 0.02,
                                            child: InkWell(
                                              onTap: () {
                                                friCont.deleteFriend(
                                                    newData[index]['id'], '');
                                              },
                                              child: Image.asset(
                                                AppImages.remove_friend,
                                                height: Get.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: Get.height * .015,
                                ),
                                Column(
                                  children: [
                                    Container(
                                        child: id ==
                                                newData[index]['requister_id']
                                            ? Text(
                                                newData[index]['user_requisted']
                                                    ['name'],
                                                style: TextStyle(
                                                    fontSize:
                                                        lang == 'ar' ? 15 : 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                newData[index]['requister']
                                                    ['name'],
                                                style: TextStyle(
                                                    fontSize: lang == 'ar'
                                                        ? 14.5
                                                        : 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                    Container(
                                        child: Text(
                                      newData[index]['requister']['degree'] !=
                                              null
                                          ? newData[index]['requister']
                                              ['degree']
                                          : newData[index]['user_requisted']
                                              ['degree'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    )),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * .02,
                                          right: Get.width * .02,
                                          top: Get.height * .012),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 12.0,
                                              backgroundColor: Colors.grey,
                                              child: newData[index]['requister']
                                                          ['image'] !=
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.asset(
                                                        AppImages.man,
                                                        height:
                                                            Get.height * .03,
                                                        width: Get.width * .06,
                                                        fit: BoxFit.fill,
                                                      ))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.asset(
                                                        AppImages.man,
                                                        height:
                                                            Get.height * .03,
                                                        width: Get.width * .06,
                                                        fit: BoxFit.fill,
                                                      ))),
                                          SizedBox(width: Get.width * 0.006),
                                          Container(
                                              child: lang=='en'?Text(
                                            newData[index]['requister']
                                                        ['university'] !=
                                                    null
                                                ? newData[index]['requister']
                                                    ['university']['name']['en']
                                                : newData[index]
                                                            ['user_requisted']
                                                        ['university']['name']
                                                    ['en'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ):Text(
                                                newData[index]['requister']
                                                ['university'] !=
                                                    null
                                                    ? newData[index]['requister']
                                                ['university']['name']['ar']
                                                    : newData[index]
                                                ['user_requisted']
                                                ['university']['name']
                                                ['ar'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              )),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //     margin: EdgeInsets.only(left: 10),
                                    //     child: id ==
                                    //             newData[index]
                                    //                 ['requister_id']
                                    //         ? Text(
                                    //             newData[index][
                                    //                         'user_requisted']
                                    //                     ['degree'] ??
                                    //                 '',
                                    //             overflow:
                                    //                 TextOverflow.ellipsis,
                                    //           )
                                    //         : Text(
                                    //             newData[index]['requister']
                                    //                     ['degree'] ??
                                    //                 '',
                                    //           )),
                                    SizedBox(
                                      height: Get.height * .015,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        selected = box.write(
                                            "selected", newData[index]['id']);
                                        requisterId = box.write("requister",
                                            newData[index]['requister_id']);
                                        Get.to(FriendProfile(),
                                            arguments: id !=
                                                    newData[index]
                                                        ['requister_id']
                                                ? [
                                                    newData[index]['id'],
                                                    newData[index]
                                                        ['requister_id']
                                                  ]
                                                : [
                                                    newData[index]['id'],
                                                    newData[index]
                                                        ['user_requisted']['id']
                                                  ]);
                                        // final snackBar = SnackBar(content: Text('Working on screen'));

                                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      child: Container(
                                        height: Get.height * 0.05,
                                        width: Get.width * 0.4,
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.whitedColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                            child: Text("Connect",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        AppColors.whitedColor,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 6),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       GestureDetector(
                                    //         onTap: () {
                                    //           friCont.deleteFriend(
                                    //               newData[index]['id'], '');
                                    //         },
                                    //         child: Container(
                                    //           height: 35,
                                    //           width: 70,
                                    //           decoration: BoxDecoration(
                                    //               color: Colors.grey[700],
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       10)),
                                    //           child: Center(
                                    //               child: Text("remove".tr,
                                    //                   style: TextStyle(
                                    //                       color:
                                    //                           Colors.white,
                                    //                       fontWeight:
                                    //                           FontWeight
                                    //                               .bold))),
                                    //         ),
                                    //       ),
                                    //       GestureDetector(
                                    //         onTap: () {
                                    //           selected = box.write(
                                    //               "selected",
                                    //               newData[index]['id']);
                                    //           requisterId = box.write(
                                    //               "requister",
                                    //               newData[index]
                                    //                   ['requister_id']);
                                    //           Get.to(FriendProfile(),
                                    //               arguments: id !=
                                    //                       newData[index][
                                    //                           'requister_id']
                                    //                   ? [
                                    //                       newData[index]
                                    //                           ['id'],
                                    //                       newData[index][
                                    //                           'requister_id']
                                    //                     ]
                                    //                   : [
                                    //                       newData[index]
                                    //                           ['id'],
                                    //                       newData[index][
                                    //                               'user_requisted']
                                    //                           ['id']
                                    //                     ]);
                                    //         },
                                    //         child: Container(
                                    //           height: 35,
                                    //           width: 90,
                                    //           margin: EdgeInsets.only(
                                    //               left: 5, right: 5),
                                    //           decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       10),
                                    //               color: AppColors
                                    //                   .whitedColor),
                                    //           child: Center(
                                    //               child: Text(
                                    //                   "viewprofile".tr,
                                    //                   style: TextStyle(
                                    //                       color:
                                    //                           Colors.white,
                                    //                       fontWeight:
                                    //                           FontWeight
                                    //                               .bold))),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          );
  }

  Widget submitButton(
      {buttonText,
      fontSize,
      callback,
      bgcolor,
      textColor,
      fontFamily,
      fontWeight,
      height,
      width,
      borderColor}) {
    return AppButton(
      buttonText: buttonText,
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      borderColor: borderColor,
      height: height,
      width: width,
    );
  }

  Widget name() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: nameController,
        style: TextStyle(
          color: AppColors.inputTextColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          hintText: "name".tr,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget city() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: cityController,
        style: TextStyle(
          color: AppColors.inputTextColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          hintText: "city".tr,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget degree() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: degreeController,
        style: TextStyle(
          color: AppColors.inputTextColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          hintText: "degree".tr,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget semester() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: semesterController,
        style: TextStyle(
          color: AppColors.inputTextColor,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 10.0, 0),
          hintText: "semester".tr,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: Get.height * 0.05,
          margin: lang == 'en'
              ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
              : EdgeInsets.only(top: 8, bottom: 6, right: 8),
          width: Get.width / 3,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: GestureDetector(
              child: Center(
                  child: Text("cancel".tr,
                      style: TextStyle(color: AppColors.inputTextColor))),
              onTap: () {
                Get.back();
              }),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            result();
          },
          child: Container(
            height: Get.height * 0.05,
            margin: lang == 'en'
                ? EdgeInsets.only(top: 8, bottom: 6, left: 8)
                : EdgeInsets.only(top: 8, bottom: 6, right: 8),
            width: Get.width / 3,
            decoration: BoxDecoration(
                color: AppColors.whitedColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
                child: Text(
              "apply".tr,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget _individualTab(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        height: 50 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    color: AppColors.border,
                    width: 1,
                    style: BorderStyle.solid))),
        child: Tab(
            child: Text(title,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12,
                ))),
      ),
    );
  }
}
