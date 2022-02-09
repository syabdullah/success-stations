import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
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

import 'friends/friend_filter.dart';

class BottomTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabsState();
  }
}

class _BottomTabsState extends State<BottomTabs> {
  final banner = Get.put(BannerController());
  final mapCon = Get.put(LocationController());
  final offer = Get.put(OfferController());
  var lang;
  var countryIDD;
  GetStorage box = GetStorage();

  void initState() {
    banner.bannerController();
    offer.offerList();
    // ignore: unused_local_variable
    var id = box.read('user_id');
    lang = box.read('lang_code');
    countryIDD = box.read('country_id');
    print("country iddddd //..... bottom bar ....$countryIDD");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 2;
  final List<Widget> _children = [
    OfferList(),
    FriendList(),
    AdsView(),
    CustomInfoWindowExample(),
    AllAdds(),
  ];
  // final List<Widget> _archildren = [
  //   AllAdds(),
  //   CustomInfoWindowExample(),
  //   AdsView(),
  //   FriendList(),
  //   OfferList(),
  // ];

  final List<Widget> _archildren = [
    OfferList(),
    FriendList(),
    AdsView(),
    CustomInfoWindowExample(),
    AllAdds(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print("...... current index ....$_currentIndex");
    });
  }

  @override
  Widget build(BuildContext context) {
    return lang == 'ar'
        ? Scaffold(
            key: _scaffoldKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: _currentIndex == 1 || _currentIndex == 3
                    ? SizedBox(height: Get.height * 0.038)
                    : appbar(_scaffoldKey, context, AppImages.appBarLogo,
                        AppImages.appBarSearch, _currentIndex)),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                  // canvasColor: AppColors.botomTiles
                  ),
              child: _currentIndex==2?AppDrawer():FriendsFilter(),
            ),
            body: _archildren[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              type: BottomNavigationBarType.fixed,
              iconSize: 0,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedItemColor: AppColors.whitedColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  // title: Text('offer'.tr,
                  // ),
                  label: 'offer'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.offers,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'friends'.tr,
                  // ignore: deprecated_member_use

                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.friends,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  // ignore: deprecated_member_use

                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ImageIcon(
                      AssetImage(
                        AppImages.home,
                      ),
                      color: AppColors.black,
                      size: 55,
                    ),
                  ),
                ),
                //  ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
                BottomNavigationBarItem(
                  label: 'locationTab'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.locations,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'ads'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.ads,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
              ],
            ),
          )
        :Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: appbar(_scaffoldKey, context, AppImages.appBarLogo,
              AppImages.appBarSearch, _currentIndex)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child:  _currentIndex==2?AppDrawer():FriendsFilter(),
      ),
      body: _archildren[_currentIndex],

      
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              type: BottomNavigationBarType.fixed,
              iconSize: 0,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedItemColor: AppColors.whitedColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  // title: Text('offer'.tr,
                  // ),
                  label: 'offer'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.offers,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'friends'.tr,
                  // ignore: deprecated_member_use

                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.friends,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  // ignore: deprecated_member_use

                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ImageIcon(
                      AssetImage(
                        AppImages.home,
                      ),
                      color: AppColors.black,
                      size: 55,
                    ),
                  ),
                ),
                //  ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
                BottomNavigationBarItem(
                  label: 'locationTab'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.locations,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'ads'.tr,
                  icon: ImageIcon(
                    AssetImage(
                      AppImages.ads,
                    ),
                    color: AppColors.black,
                    size: 25,
                  ),
                ),
              ],
            ),
          );
  }
}
