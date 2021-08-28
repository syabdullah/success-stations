import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/ads.dart';
import 'package:success_stations/view/auth/my_adds/all_ads.dart';
import 'package:success_stations/view/auth/offer_list.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/friends/friend_list.dart';
import 'package:success_stations/view/google_map/mapview.dart';

class BottomTabs extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _BottomTabsState();
  }
}
class _BottomTabsState extends State<BottomTabs> {
  final banner = Get.put(BannerController());
  final mapCon = Get.put(LocationController());
  GetStorage box = GetStorage();
  void initState() {
    // TODO: implement initState
    banner.bannerController();
    var id = box.read('user_id');
     mapCon.getAllLocationToDB();
    super.initState();
  }
  @override
  void dispose() {
  
    super.dispose();

  }
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _children = [
    AdsView(),
    OfferList(),
    FriendList(),
    CustomInfoWindowExample(),
    AllAdds()  
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            title: Text('Home', style: AppTextStyles.appTextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
              ) 
            ),
            icon: Icon(Icons.home,color: AppColors.grey)
            //  ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
            ),
          BottomNavigationBarItem(
            title: Text('Offers', style: AppTextStyles.appTextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
              ) 
            ),
            icon: ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
            ),
            BottomNavigationBarItem(
              title: Text('Friends' ,style: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                ) 
              ),
              icon:ImageIcon(AssetImage(AppImages.friends),color: AppColors.grey),
            ),
            BottomNavigationBarItem(
              title: Text('Locations', style: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  ) 
                ),
              icon: ImageIcon(AssetImage(AppImages.locations),color: AppColors.grey),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Ads',style: 
                AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  )
                ),
              icon:ImageIcon(AssetImage(AppImages.ma),color: AppColors.grey),
            ),
        ],
      ),
    );
  }

}