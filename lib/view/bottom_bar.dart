import 'package:flutter/material.dart';
import 'package:success_stations/view/dashboard.dart';

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
    Dashboard(),
    Dashboard(),
    Dashboard()
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Location'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Ads'
          )
        ],
      ),
    );
  }

}