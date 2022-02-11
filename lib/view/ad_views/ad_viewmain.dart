import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/inbox_controller/chat_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/ad_views/about_tab.dart';
import 'package:success_stations/view/ad_views/add_offer_tab.dart';
import 'package:success_stations/view/ad_views/adtab.dart';
import 'package:success_stations/view/ad_views/location_tab.dart';
import 'package:success_stations/view/messages/chatting_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class AdViewTab extends StatefulWidget {
  const AdViewTab({Key ? key,tabBarView}) : super(key: key);
  @override
  _AdViewTabState createState() => _AdViewTabState();
}
class _AdViewTabState extends State<AdViewTab> with SingleTickerProviderStateMixin {
  final userProfile = Get.put(UserProfileController());
  var id;
  var name = '';
  final chatCont = Get.put(ChatController());
  @override
  void initState() {
    id = Get.arguments;
    userProfile.getUseradProfile(id);
    super.initState();
  }    
  
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Stack(
        children: [
          Padding(
            padding: lang == 'ar' ? EdgeInsets.only(right:Get.width *0.04) :EdgeInsets.only(left:Get.width *0.04),
            child:
          Text('aboutsu'.tr,style: TextStyle(fontWeight: FontWeight.bold),),),
          Padding(
            padding: lang == 'ar' ? EdgeInsets.only(right:Get.width *0.24) :EdgeInsets.only(left:Get.width *0.24),
            child: Container(height: 20, child: VerticalDivider(color: Colors.black,thickness: 1,)),
          ),
        ],
      ),
    ),
    Tab(
      child:Stack(
      children: [
        Padding(
          padding: lang == 'ar' ? EdgeInsets.only(right:Get.width *0.04) :EdgeInsets.only(left:Get.width *0.04),
          child: Text('locationTab1'.tr,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: lang == 'ar' ? EdgeInsets.only(right:Get.width *0.24) :EdgeInsets.only(left:Get.width *0.24),
          child: Container(height: 15, child: VerticalDivider(color: Colors.black,thickness: 1,)),
        ),
      ],
    ),
    ),
    Tab(
      child: Stack(
        children: [
          Padding(
            padding:  lang == 'ar' ? EdgeInsets.only(right:Get.width *0.08) :EdgeInsets.only(left:Get.width *0.08),
            child: Text('ads'.tr,style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: lang == 'ar' ? EdgeInsets.only(right:Get.width *0.24) :EdgeInsets.only(left:Get.width *0.24),
            child: Container(height: 15, child: VerticalDivider(color: Colors.black,thickness: 1,)),
          ),
        ],
      ),
    ),
    Tab(
      child: Text('offerTab'.tr,style: TextStyle(fontWeight: FontWeight.bold),),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<UserProfileController>(
                    init: UserProfileController(),
                    builder: (value) {
                       if(value.userData2 != null && value.userData2['success'] != true ){
                         name= value.userData2['data']['name'];
                         print(name);

                         return topImage(value.userData2['data'],myTabs,id,chatCont);
                      }else{
                      return LinearProgressIndicator();
                       }

                    }
                  ),

              ],
            ),
          ),
        )  
      );
    // );
  }
}

Widget topImage(userData2, List<Tab> myTabs, id, ChatController chatCont){

  return Column(
    children: [
      Stack(
        children: [
          Container(
            width: Get.width,
            child: Image.asset(AppImages.topImage,fit: BoxFit.fill),
          ),
          Column(
            children: [
              AppBar(
                leading: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child:Padding(
                    padding:  EdgeInsets.only(bottom: Get.height * 0.05,left: Get.width *0.02,right: Get.width *0.02),
                    child: ImageIcon(AssetImage(AppImages.imagearrow1),),
                  )
                ),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Center(
            child: FractionalTranslation(
              translation: lang == 'ar' ? Offset(1.4,1.6) : Offset(-1.4, 1.6),
              child:  userData2 !=null  &&  userData2['image'] != null?
                CircleAvatar(
                  backgroundImage: NetworkImage(userData2['image']['url']),
                  radius: 45.0,
                )
              :CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 45.0,
                child: Icon(
                  Icons.person,size: 70,color: Colors.black
                )
              ),
            ),
          ),
        ],
      ),
      Container(
        height: Get.height,
        child: Column(
          children: [
            // SizedBox(height: 20.h),
            //     Container(
            //           child : userData2!= null ?
            // Center(
            //   child: Text(userData2['name'],
            //     style:AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.inputTextColor,),
            //   ),
            // )
            //     :Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: Get.width * 0.13),
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 5),
                      child: Text(userData2['name'],style: TextStyle(color:Color(0XFF040404),fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Text(userData2['name'],style: TextStyle(color:Colors.black,)),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 38.0),
                      child: InkWell(child: Image.asset(AppImages.callerImage, height: Get.height * 0.035),onTap: ()  {
                        launch("tel:123456789");
                      },),
                    ),
                    SizedBox(width: Get.width * 0.015),
                    GestureDetector(
                        onTap: () {
                          chatCont.createConversation(id);
                          Get.to(ChattinPagePersonal(), arguments: [0, 'name']);
                        },
                        child:
                        Image.asset(AppImages.chating, height: Get.height * 0.045)),
                    SizedBox(width: Get.width * 0.015),
                    InkWell(child: Image.asset(AppImages.whatsapp, height: Get.height * 0.035),onTap: (){
                      const url = "https://wa.me/?text=Your Message here";
                      var encoded = Uri.encodeFull(url);
                      launch(encoded);
                    },),
                    SizedBox(width: Get.width * 0.015),
                  ],
                ),

              ],
            ),
            Divider(),
            Container(height: Get.height *0.03,
              child: TabBar(
                unselectedLabelColor: Color(0xFF0d0d0d),
                unselectedLabelStyle: TextStyle(
                  // fontWeight: FontWeight.w700,
                  fontSize:14,
                  color: Colors.black,
                ),

                labelColor: AppColors.appBarBackGroundColor,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
                labelStyle: TextStyle(
                  // fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                indicatorColor: Colors.transparent,
                tabs: myTabs,
              ),
            ),
            Divider(),
            tabBarView()
          ],
        ),
      ),
    ],
  );
}

Widget tabBarView(){
  return Expanded(
    child: TabBarView(
      children: [
        AboutTab(),
        LocationTab(),
        AdListTab(),
        AdOffers(),
      ]
    ),
  );
}