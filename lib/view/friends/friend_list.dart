import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/utils/skalton.dart';
import 'package:success_stations/view/friends/friends_profile.dart';

class FriendList extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final friCont = Get.put(FriendsController());
  GetStorage box = GetStorage();
  var listtype = 'grid';
  var grid = AppImages.gridOf;
  Color listIconColor = Colors.grey;
   Color gridIconColor = AppColors.appBarBackGroundColor;
  var id;
  var selected;
  var requisterId;
  final banner = Get.put(BannerController());

  @override
  void initState() {
    super.initState();
    banner.bannerController();
    friCont.getFriendsList();
    friCont.getSuggestionsList();
    id = box.read('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topWidget(),
        GetBuilder<FriendsController>(
            init: FriendsController(),
            builder: (val) {
            return val.friendsData == null
            ? shimmer()
            : val.friendsData['data'].length == 0 ||
                val.friendsData == null
            ? Container(
                child: Text("nofriends".tr),
              )
            : Expanded(
              child: listtype == 'list'
              ? friendList(val.friendsData['data'])
              : friendGridView(val.friendsData['data']));
        })
      ],
    );
  }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.grey[200],
            ),
            margin: EdgeInsets.only(left: 10,right: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Image.asset(AppImages.filter, height: 15),
                SizedBox(width: 5),
                Text(
                  "filter".tr,
                  style: TextStyle(color: Colors.grey[700]),
                )
              ],
          ),
        )),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    listtype = 'grid';
                    listIconColor = Colors.grey;
                    gridIconColor = AppColors.appBarBackGroundColor;
                    grid = AppImages.grid;
                  });
                },
                icon: Image.asset(grid,color: gridIconColor,)),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      listtype = 'list';
                      gridIconColor = Colors.grey;
                      listIconColor = AppColors.appBarBackGroundColor;
                      grid = AppImages.gridOf;
                    });
                  },
                  icon: Icon(
                    Icons.list,
                    color: listIconColor,
                    size: 45,
                  )),
            ),
            SizedBox(
              height: 30,
              width: 15,
            )
          ],
        )
      ],
    );
  }

  Widget friendList(dataa) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
     // margin: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: dataa.length,
        itemBuilder: (BuildContext context, index) {
          
          return dataa[index]['status'] == "Accepted"
          ? GestureDetector(
            onTap: () {
              selected = box.write("selected", dataa[index]['id']);
              requisterId = box.write("requister", dataa[index]['requister_id']);
              Get.to(FriendProfile(),
              arguments: id != dataa[index]['requister_id']
              ? [dataa[index]['id'],dataa[index]['requister_id']]
              : [dataa[index]['id'],dataa[index]['user_requisted']['id']]);
            },
            child: Card(
              child: Row(
                children: [
                  id != dataa[index]['requister_id']
                  ? Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0
                    ),
                    child: Container(
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[100],
                        child: dataa[index]['requister']['image'] !=
                        null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            dataa[index]['requister']['image'] ['url'],
                            height: 80,
                            fit: BoxFit.fill,
                          )
                        )
                        : Image.asset(AppImages.person)
                      ),
                    ),
                  )
                  : Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: dataa[index]['user_requisted']['image'] != null
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(50.0),
                          child: Image.network(
                            dataa[index]['user_requisted']
                                ['image']['url'],
                            height: 80,
                            fit: BoxFit.fill,
                          )
                      )
                      : Image.asset(AppImages.person)
                    ),
                  ),
              
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: id == dataa[index]['requister_id']
                        ? Text(
                          dataa[index]['user_requisted']['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                        : Text(
                          dataa[index]['requister']['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: id == dataa[index]['requister_id']
                        ? Text(
                          dataa[index]['user_requisted']['degree'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                        : Text(
                          dataa[index]['requister']['degree'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                       
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          dataa[index]['user_requisted']['address'] == null ? Container() :  Icon(Icons.location_on,color:Colors.grey,),
                            SizedBox(width: 5),
                            Container(
                              child: id == dataa[index]['requister_id']
                              ? Text(
                                dataa[index]['user_requisted']['address'] ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                              : Text(
                                dataa[index]['requister']['address'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                          ],
                        ),
                      ) 
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
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
        print(newData.length);
      }
    }
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          newData.length,
          (index) {
            return  GestureDetector(
              onTap: () {
                selected = box.write("selected", newData[index]['id']);
                requisterId = box.write("requister", newData[index]['requister_id']);
                Get.to(FriendProfile(),
                arguments: id != newData[index]['requister_id']
                ? [newData[index]['id'],newData[index]['requister_id']]
                : [newData[index]['id'],newData[index]['user_requisted']['id']]);
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 8),
                    id != newData[index]['requister_id']
                    ? Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0
                    ),
                    child: Container(
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[100],
                        child: newData[index]['requister']['image'] !=
                        null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            newData[index]['requister']['image'] ['url'],
                            height: 80,
                            fit: BoxFit.fill,
                          )
                        )
                        : Image.asset(AppImages.person)
                      ),
                    ),
                  )
                  : Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: newData[index]['user_requisted']['image'] != null
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(50.0),
                          child: Image.network(
                            newData[index]['user_requisted']
                                ['image']['url'],
                            height: 80,
                            fit: BoxFit.fill,
                          )
                      )
                      : Image.asset(AppImages.person)
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                      child: id == newData[index]['requister_id']
                      ? Text(
                        newData[index]['user_requisted']['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      )
                      : Text(
                        newData[index]['requister']['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: id == newData[index]['requister_id']
                      ? Text(
                        newData[index]['user_requisted']['degree'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      )
                      : Text(
                        newData[index]['requister']['degree'] ??'',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        newData[index]['user_requisted']['address'] == null ? Container() : 
                        Icon(Icons.location_on,color:Colors.grey,),
                        SizedBox(width: 5),
                        Container(
                          child: id == newData[index]['requister_id']
                          ? Text(
                            newData[index]['user_requisted']['address'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          )
                          : Text(
                            newData[index]['requister']['address'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    )
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

  addFriend(id) {
    friCont.appFriend(id);
  }

  rejFriend(id) {
    // friCont.appFriend(id);
  }
}
