import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/responsive.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/skalton.dart';

class FriendList extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}
class _FriendListState extends State<FriendList> {
  final friCont = Get.put(FriendsController());
  var listtype = 'list';
  var grid = AppImages.gridOf;
  Color listIconColor = AppColors.appBarBackGroundColor;

  @override
  void initState() {
    super.initState();
    friCont.getFriendsList();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        topWidget(),
        GetBuilder<FriendsController>(
          init: FriendsController(),
          builder: (val) {
            print("/././././././${val.friendsData}");
            return val.friendsData == null ? shimmer() : val.friendsData['data'].length == 0  || val.friendsData == null? Container(
              child: Text("no suggestions "),
            ) :  Expanded(
              child: listtype == 'list' ? friendList(val.friendsData['data']) : friendGridView(val.friendsData['data'])
            );
        })
      ],
    );
  }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child:Container(
            margin: EdgeInsets.only(left:10),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15) ,
            color: Colors.grey[200],
            child: Row(
              children: [
                Image.asset(AppImages.filter,height: 15),
                SizedBox(width:5),
                Text("Filter",style: TextStyle(color: Colors.grey[700]),)
              ],
            ),
          )
        ),
        Row(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  listtype = 'grid';
                  listIconColor = Colors.grey;
                  grid = AppImages.grid;
                });             
              },
              icon: Image.asset(grid)
            ),
            Container(
              margin: EdgeInsets.only(bottom:15),
              child: IconButton(
                onPressed: (){
                  setState(() {
                    listtype = 'list';
                    listIconColor = AppColors.appBarBackGroundColor;
                    grid = AppImages.gridOf;
                  });
                },
                icon: Icon(Icons.list,color: listIconColor,size: 45,)
              ),
            ),
            SizedBox(height: 30,width: 15,)
          ],
        )
      ],
    );
  }

  Widget friendList(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext,index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed('/friendProfile');
          },
          child: Card(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Image.network(data[index]['user_requisted']['city']['image']['url']),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(data[index]['user_requisted']['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.location,height: 15,),
                        SizedBox(width:5),
                        Container(
                          child: Text(data[index]['user_requisted']['city']['city']),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                data[index]['status'] != "Accepted" ? 
                GestureDetector(
                  onTap: (){ addFriend(data[index]['id']);},
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
                ): Container(),
                data[index]['status'] != "Accepted" ? 
                GestureDetector(
                  onTap: (){rejFriend(data[index]['id']);},
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
                ): Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget friendGridView(data) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(data.length, (index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed('/friendProfile');
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height:8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child:Image.network(data[index]['user_requisted']['city']['image']['url']),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(data[index]['user_requisted']['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.location,height: 15),
                        SizedBox(width:5),
                        Container(
                          child: Text(data[index]['user_requisted']['city']['city']),
                        ),
                      ],
                    ),
                  ],
                ),
                data[index]['status'] != "Accepted" ? 
                Row(
                  children: [

                    GestureDetector(
                      onTap: (){ addFriend(data[index]['id']);},
                      child: Container( 
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
                          // margin:EdgeInsets.only(left:10),
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
                      onTap: (){rejFriend(data[index]['id']);},
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
                    ),
                  ],
                ):Container(),
                SizedBox(height:8),
              ],
            ),
          ),
        );

      },
      )
    );
  }


  Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
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