import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/ad_views/about_tab.dart';

class AdViewTab extends StatefulWidget {
  
  const AdViewTab({Key ? key,tabBarView}) : super(key: key);
  @override
  _AdViewTabState createState() => _AdViewTabState();
}

class _AdViewTabState extends State<AdViewTab>
    with SingleTickerProviderStateMixin {
    
  
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'About'),
    Tab(text: 'Offer'),
    Tab(text: 'Location'),
    Tab(text: 'Ads'),
  ];

  // TabController ? _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(vsync: this, length: myTabs.length);
  // }

  // @override
  // void dispose() {
  //   _tabController!.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:  myTabs.length,
      child: Scaffold(
        // appBar:TabBar(
        //     labelColor: AppColors.appBarBackGroundColor,
        //     unselectedLabelColor: AppColors.inputTextColor,
        //     controller: _tabController,
        //     tabs: myTabs,
        //   ),
        
        body: NestedScrollView(
           headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled){
                  return [
                  SliverToBoxAdapter(child:topImage())];
                },
          body: Container(
            height: Get.height,
            child: Column(
              children: [
                
                SizedBox(height: 50.h),
                TabBar(
              labelColor: AppColors.appBarBackGroundColor,
              unselectedLabelColor: AppColors.inputTextColor,
              // controller: _tabController,
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
      
      ClipRRect( 
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
        child: Image.asset(AppImages.topImage,fit: BoxFit.fill,)
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
                   child: Text("TED LIBRARY",style:AppTextStyles.appTextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor,),
                ),
                 ),
              ],
            ),
          ),
          Text("Edwardian House Library,Screening \n mainstreaming loerm films ",textAlign: TextAlign.center,style:AppTextStyles.appTextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor,),
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
      Text("1"),
      Text("1"),
      Text("1")
    ]),
  );
}