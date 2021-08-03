import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';

class FriendList extends StatefulWidget {
  _FriendListState createState() => _FriendListState();
}
class _FriendListState extends State<FriendList> {
  var listtype = 'list';
  var grid = AppImages.gridOf;
  Color listIconColor = AppColors.appBarBackGroundColor;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        topWidget(),
        Expanded(
          child: listtype == 'list' ? friendList() : friendGridView()
        ),
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

  Widget friendList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext,index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed('/friendProfile');
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(Icons.person),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text("Maryam Cheema",style: TextStyle(fontWeight: FontWeight.bold),),
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
                          child: Text("codility solutions"),
                        ),
                      ],
                    ),
                  ],
                ),
                submitButton(
                  bgcolor: AppColors.appBarBackGroundColor,
                  textColor: AppColors.appBarBackGroun,
                  buttonText: AppString.addFriend,
                  callback: navigateToGoogleLogin,
                  width: Get.width/4.8,
                  height: 35.0
                ),
                submitButton(
                  bgcolor: Colors.grey,
                  textColor: AppColors.appBarBackGroun,
                  buttonText: AppString.remove,
                  callback: navigateToGoogleLogin,
                  width: Get.width/4.8,
                  height: 35.0
                ),
              ],
            ),
          ),
        );

      },
    );
  }

  Widget friendGridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(100, (index) {
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
                    child: Icon(Icons.person),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text("Maryam Cheema",style: TextStyle(fontWeight: FontWeight.bold),),
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
                          child: Text("codility solutions"),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    submitButton(
                      bgcolor: AppColors.appBarBackGroundColor,
                      textColor: AppColors.appBarBackGroun,
                      buttonText: AppString.addFriend,
                      callback: navigateToGoogleLogin,
                      width: Get.width/4.2,
                      height: 35.0
                    ),
                    submitButton(
                      bgcolor: Colors.grey,
                      textColor: AppColors.appBarBackGroun,
                      buttonText: AppString.remove,
                      callback: navigateToGoogleLogin,
                      width: Get.width/4.2,
                      height: 35.0
                    ),
                  ],
                ),
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
  
  void navigateToGoogleLogin() {
  }
}