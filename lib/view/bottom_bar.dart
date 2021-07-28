import 'package:flutter/material.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ads.dart';
import 'package:success_stations/view/dashboard.dart';
import 'package:success_stations/view/friends/friend_list.dart';

class BottomTabs extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _BottomTabsState();
  }
}
class _BottomTabsState extends State<BottomTabs> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    FriendList(),
    Dashboard(),
    AdsView()
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar('',Icons.arrow_back_ios, AppImages.appBarLogo )),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.green,),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail,color: Colors.grey,),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Location'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.grey,),
            label: 'Ads'
          )
        ],
      ),
    );
  }

}