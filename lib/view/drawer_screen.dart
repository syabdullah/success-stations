import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/google_map/my_locations.dart';
import 'package:success_stations/view/member_ship/member_ship.dart';
import 'package:success_stations/view/messages/inbox.dart';
class AppDrawer extends StatefulWidget {
 const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(45), bottomRight: Radius.circular(30)),
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      width: Get.width,
                      height: Get.height/4,
                      child: Stack(
                        children: [
                          FractionalTranslation(
                            translation: const Offset(0.2, 0.8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white54,
                              radius: 60.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child:Image.network(
                                  'https://picsum.photos/250?image=9',
                                ),
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height:30),
                    Padding(
                      padding: const EdgeInsets.only(left:130.0),
                      child: Text("user_name".tr,
                        style:AppTextStyles.appTextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color:Colors.grey.shade800
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text(
                              "mainMenu".tr,
                              style: AppTextStyles.appTextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800
                              ),
                            ),
                          ),
                          CustomListTile(AppImages.aboutus, 'home'.tr, ()  {
                            Get.toNamed('/tabs');
                          },15.0 ),
                          CustomListTile(AppImages.userProfile, 'profile'.tr, ()  {
                            Get.toNamed('/friendProfile');
                          },15.0 ),
                          CustomListTile(AppImages.ma, 'my_ads'.tr, ()  {
                            Navigator.pushNamed(context,'/myAddsPage');
                          } ,15.0),
                          CustomListTile(AppImages.message, 'messages'.tr, () {
                            Get.to(Inbox());
                          },15.0 ),
                          CustomListTile(AppImages.location, 'addlocation'.tr, () {
                            Get.to(MyLocations());
                          },15.0 ),
                          CustomListTile(AppImages.membership, 'membership'.tr, () {
                          
                            Get.to(MemberShip());
                          },13.2 ),
                          CustomListTile(AppImages.notification, 'notification'.tr, () => {
                            Get.toNamed('/notification')
                          },15.0 ),
                          CustomListTile(AppImages.freq, 'friend_requests'.tr, ()  {
                            Get.toNamed('/friReq');
                          } ,15.0), 
                          CustomListTile(AppImages.fav, 'favourite'.tr, () => {},15.0 ), 
                          SizedBox(height: 10.h),
                          Divider(),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text(
                              "overviewAndDefications".tr,
                                style: AppTextStyles.appTextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold, color:Colors.grey.shade800
                                ),
                              ),
                          ),
                          SizedBox(height: 10.h),
                          CustomListTile(AppImages.aboutus, 'about_us'.tr, ()  {
                            Get.toNamed('/aboutUs');
                          },15.0 ),
                          CustomListTile(AppImages.privacy, 'privacy'.tr, () => {},15.0 ),
                          CustomListTile(AppImages.adwithus, 'ADVERTIESE WITH US', () => {
                            Navigator.pushNamed(context, '/advertisement')
                          },15.0 ),
                          CustomListTile(AppImages.ugr, 'user_agreement'.tr, () => {},12.0 ),
                          CustomListTile(AppImages.contactus, 'cntact_us'.tr, () => {
                            Navigator.pushNamed(context, '/contact')
                          },15.0 ),
                          SizedBox(height: 10.h),
                          Divider(),
                          CustomListTile(AppImages.logout, 'logout'.tr, ()  {
                            // box.remove("access_token");
                            Get.toNamed('/login');
                          },15.0 ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
      }
 // ignore: must_be_immutable
 class CustomListTile  extends StatelessWidget {
  String image ;
  String text;
  Function onTap;
  double height;
  CustomListTile(this.image, this.text, this.onTap ,this.height);
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.fromLTRB(15.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: Colors.grey,
        onTap:() => onTap(),
        child:Container(
          height: 50,
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(image.toString(),height: height,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                      child:Text(text,textAlign: TextAlign.start,
                       style: AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey,
                      )
                    )
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}