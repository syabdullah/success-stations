import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/ad_views/about_tab.dart';
import 'package:success_stations/view/ad_views/add_offer_tab.dart';
import 'package:success_stations/view/ad_views/adtab.dart';
import 'package:success_stations/view/ad_views/location_tab.dart';
import 'package:success_stations/view/drawer_screen.dart';

class AdViewTab extends StatefulWidget {
  
  const AdViewTab({Key ? key,tabBarView}) : super(key: key);
  @override
  _AdViewTabState createState() => _AdViewTabState();
}

class _AdViewTabState extends State<AdViewTab> with SingleTickerProviderStateMixin {
  final userProfile = Get.put(UserProfileController());
   var id;
@override
  void initState() {
    id = Get.arguments;
    print(id);
    userProfile.getUseradProfile(id);
    super.initState();
  }    
  
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'about'.tr),
    Tab(text: 'offer'.tr),
    Tab(text: 'location'.tr),
    Tab(text: 'ads'.tr),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:  myTabs.length,
      child: Scaffold(
        drawer: AppDrawer(),
        body: NestedScrollView(
          headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled){
              return [
                SliverToBoxAdapter(child:topImage()
              )
            ];
          },
          body: Container(
            height: Get.height,
            child: Column(
              children: [
                SizedBox(height: 50.h),
                TabBar(
                labelColor: AppColors.appBarBackGroundColor,
                unselectedLabelColor: AppColors.inputTextColor,
                tabs: myTabs,
               ),
              tabBarView()
             ],
            ),
          ),
        )  
      ),
    );
  }
}


Widget topImage(){
  return Stack(
    children: [
      Container(
        width: Get.width,
        child: ClipRRect( 
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
          child: Image.asset(AppImages.topImage,fit: BoxFit.fill,)
        ),
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:45,left: 12),
            child: Row(
              children: [
                 Image.asset(AppImages.arrowBack),
                 Center(
                   widthFactor:4,
                   child: Text("TED LIBRARY",
                   style:AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor,),
                  ),
                 ),
              ],
            ),
          ),
          Text("Edwardian House Library,Screening \n mainstreaming loerm films ",textAlign: TextAlign.center,
            style:AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor,),
          ),
        ],
      ),
      Center(
        child: FractionalTranslation(
          translation: const Offset(0.0, 1.7),
          child: CircleAvatar(
            backgroundColor: Colors.white54,
            radius: 45.0,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0,),
            child:Image.asset(AppImages.ted),
            )
          )
        ),
      ),
    ],
  );
}
Widget tabBarView(){
  return Expanded(
    child: TabBarView(children: [
     AboutTab(),
     AdOffers(),
     LocationTab(),
     AdListTab()
    ]),
  );
}