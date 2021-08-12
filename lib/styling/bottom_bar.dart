import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/about_us.dart';
import 'package:success_stations/view/add_posting_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({ Key? key }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return   BottomNavigationBar(
      iconSize: 35,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      selectedFontSize: 14,
      unselectedFontSize: 14,
        onTap: (value) {
        setState(() => _currentIndex = value);
          _currentIndex == 0 ? Get.off(AddPostingScreen())  : Get.off(AboutUs());
          
        },
        items: [
            BottomNavigationBarItem(
              
              // ignore: deprecated_member_use
              title: Text("offer".tr, style: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  ) 
                ),
              icon: ImageIcon(AssetImage(AppImages.offers,),),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("friends".tr ,style: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  ) 
                ),
              icon:ImageIcon(AssetImage(AppImages.friends)),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('location'.tr, style: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  ) 
                ),
              icon: ImageIcon(AssetImage(AppImages.locations)),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("ads".tr,style: 
                AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor
                  )
                ),
              icon:ImageIcon(AssetImage(AppImages.ma)),
            ),
        ],
      
    );
  }
}
