
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/skalton.dart';
import 'package:success_stations/view/drawer_screen.dart';

class FriendReqList extends StatefulWidget {
  _FriendReqListState createState() => _FriendReqListState();
}
class _FriendReqListState extends State<FriendReqList> {
   final friCont = Get.put(FriendsController());
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   GetStorage box = GetStorage();
   var id;
   @override
  void initState() {
    super.initState();
    friCont.getFriendsList();
    friCont.getSuggestionsList();
    id = box.read('user_id');
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        key: _scaffoldKey,
        appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch)),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // canvasColor: AppColors.botomTiles
          ),
          child: AppDrawer(),
        ),
       body: ListView(
         children: [
           GetBuilder<FriendsController>(
          init: FriendsController(),
          builder: (val) {
            return val.suggestionsData == null ? shimmer() : val.suggestionsData.length == 0  || val.suggestionsData == null? Container(
              child: Container(
                child:
               Text("no suggestions " ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24) )
              ),
            ) :  Column(
              children: [
                Column(
                  children:
                    friendList(val.friendsData['data']),
                ),
                SizedBox(
                  height: 20,
                ),
                // Divider(),
                 Column(
                  children:
                    sugesstionList(val.suggestionsData),
                ),
              ],
            );
        })
         ],
       ),
     );
  }
  List<Widget> friendList(data) { 
    print("....................//////.....$data");
    var count = 0;
     List<Widget> req = [];
     if(data != null)
     for(int i= 0; i< data.length; i++) {
        
       if(data[i]['status'] == null) {
         ++count;
        req.add(
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            count == 1  ?  Container(
              margin: EdgeInsets.only(top: 20,left: 20),
              child: Text(
                "Friend Requests",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
              ),
            ):Container(),
             GestureDetector(
              onTap: (){
                // Get.toNamed('/friendProfile');
              },
              child: Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        // child: Image.network(data[i]['user_requisted']['image']['url']),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width/4,
                          child: Text(data[i]['user_requisted']['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.asset(AppImages.location,height: 15,),
                        //     SizedBox(width:5),
                        //     Container(
                        //       // child: Text(data[i]['user_requisted']['city']['city']),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Spacer(),
                    data[i]['requister']['id'] != id ?
                    GestureDetector(
                      onTap: (){ 
                        friCont.appFriend(data[i]['id']);
                      },
                      child: Container( 
                         margin:EdgeInsets.only(right:10),
                        alignment: Alignment.center,
                        width: Get.width/4.2,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: AppColors.appBarBackGroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child:
                        Container(                        
                          child: Text(
                            "Approve",
                            style:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
                    ): 
                    GestureDetector(
                      onTap: (){ 
                        friCont.appFriend(data[i]['id']);
                      },
                      child: Container( 
                         margin:EdgeInsets.only(right:10),
                        alignment: Alignment.center,
                        width: Get.width/3.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child:
                        Container(                        
                          child: Text(
                            "Cancel",
                            style:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
                    ),
                    data[i]['requister']['id'] != id ?
                    GestureDetector(
                      onTap: (){friCont.rejFriend(data[i]['id']);},
                      child: Container( 
                        alignment: Alignment.center,
                        width: Get.width/4.2,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child:
                        Container(
                          margin:EdgeInsets.only(left:10),
                          child: Text(
                            'Reject',
                            style:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
                    ):Container()
                  ],
                ),
              ),
            ),
           ],
         )
      );
      }
      if(count == 0 && i == data.length) {
        req.add(
          Column(
            children: [
               Container(
                margin: EdgeInsets.only(top: 20,left: 20,bottom: 10),
                child: Text(
                  "Friend Requests",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                ),
              ),
              Container(
                child: Text("No Friend Request!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),
            ],
          )
        );
      }
    }
    return req;
  }
  List<Widget> sugesstionList(data) {
     List<Widget> req = [];
     if(data != null)
     for(int i= 0; i< data.length; i++) {
        req.add(
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              i == 0 ?  Container(
              margin: EdgeInsets.only(top: 20,left: 20,bottom: 10),
              child: Text(
                "Suggestions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
              ),
            ):Container(),
             GestureDetector(
              onTap: (){
                // Get.toNamed('/friendProfile');
              },
              child: Card(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        // child: Image.network(data[i]['user_requisted']['city']['image']['url']),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                           width: Get.width/4,
                          child: Text(data[i]['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.asset(AppImages.location,height: 15,),
                        //     SizedBox(width:5),
                        //     Container(
                        //       // child: Text(data[i]['user_requisted']['city']['city']),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){ 
                        var json = {
                          'requister_id' : id,
                          'user_requisted_id' : data[i]['id']
                        };
                        print("......./////$json");
                        friCont.sendFriend(json);
                      },
                      child: Container( 
                         margin:EdgeInsets.only(right:10),
                        alignment: Alignment.center,
                        width: Get.width/4.2,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: AppColors.appBarBackGroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child:
                        Container(
                         
                          child: Text(
                            AppString.addFriend,
                            style:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){friCont.rejFriend(data[i]['id']);},
                      child: Container( 
                        alignment: Alignment.center,
                        width: Get.width/4.2,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child:
                        Container(
                          margin:EdgeInsets.only(left:10),
                          child: Text(
                            AppString.remove,
                            style:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
        ),
           ],
         )
        // : Container(
        //   margin: EdgeInsets.only(top: 20),
        //   child: Center(
        //     child: Text(
        //       "No Friend Request.",style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // );
      
      );
    }
    return req;
  }
}