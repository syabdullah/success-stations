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
                child: appbar(_scaffoldKey, context, AppImages.appBarLogo,
                    AppImages.appBarSearch, _currentIndex)),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                  // canvasColor: AppColors.botomTiles
                  ),
              child: AppDrawer(),
            ),
            body: _archildren[_currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.offers,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('offer'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(

                  // ignore: deprecated_member_use
                  title: Text('friends'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.friends,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('friends'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('home'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ImageIcon(
                          AssetImage(
                            AppImages.home,
                          ),
                          color: AppColors.black,
                          size: 55,
                        ),
                      ),
                      // Text('home'.tr, style: AppTextStyles.appTextStyle(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w600, color: Colors.black
                      // )
                      // ),
                    ],
                  ),

                ),
                //  ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('locationTab'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.locations,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('locationTab'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('ads'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whitedColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.ads,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('ads'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            key: _scaffoldKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: lang == 'en'&&_currentIndex == 3|| lang == 'ar'&&_currentIndex == 1
                    ? SizedBox(height: Get.height * 0.038)
                    : appbar(_scaffoldKey, context, AppImages.appBarLogo,
                        AppImages.appBarSearch, _currentIndex)),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                  // canvasColor: AppColors.botomTiles
                  ),
              child: AppDrawer(),
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('offer'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.offers,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('offer'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('friends'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.friends,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('friends'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('home'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ImageIcon(
                          AssetImage(
                            AppImages.home,
                          ),
                          color: AppColors.black,
                          size: 55,
                        ),
                      ),
                      // Text('home'.tr, style: AppTextStyles.appTextStyle(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w600, color: Colors.black
                      // )
                      // ),
                    ],
                  ),

                ),
                //  ImageIcon(AssetImage(AppImages.offers,),color: AppColors.grey),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('locationTab'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.locations,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('locationTab'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text('ads'.tr,
                      style: AppTextStyles.appTextStyle(
                          fontSize: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.inputTextColor)),
                  icon: Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          AppImages.ads,
                        ),
                        color: AppColors.black,
                        size: 25,
                      ),
                      Text('ads'.tr,
                          style: AppTextStyles.appTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
