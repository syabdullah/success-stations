import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/member_ship/member_ship.dart';
class AppDrawer extends StatefulWidget {
 const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(45), bottomRight: Radius.circular(30)),
            child: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration:BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Stack(
                      children: [
                        FractionalTranslation(
                          translation: const Offset(0.0, 0.7),
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
                    padding: const EdgeInsets.only(left:150.0),
                    child: Text("User Name",
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
                            "Main Menu ",
                            style: AppTextStyles.appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800
                            ),
                          ),
                        ),
                        CustomListTile(AppImages.userProfile, 'PROFILE', () => {},15.0 ),
                        CustomListTile(AppImages.ma, 'MY ADS', () => {} ,15.0),
                        CustomListTile(AppImages.message, 'MESSAGE', () => {},15.0 ),
                        CustomListTile(AppImages.membership, 'MEMBERSHIP', () {
                          Get.to(MemberShip());
                        },13.2 ),
                        CustomListTile(AppImages.notification, 'NOTIFICATIONS', () => {},15.0 ),
                        CustomListTile(AppImages.freq, 'FRIEND REQUESTS', () => {} ,15.0), 
                        CustomListTile(AppImages.fav, 'FAVOURITES', () => {},15.0 ), 
                        SizedBox(height: 10.h),
                        Divider(),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(
                            AppString.overview,
                              style: AppTextStyles.appTextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold, color:Colors.grey.shade800
                              ),
                            ),
                        ),
                        SizedBox(height: 10.h),
                        CustomListTile(AppImages.aboutus, 'ABOUT US', () => {},15.0 ),
                        CustomListTile(AppImages.adwithus, 'ADVERTIESE WITH US', () => {},15.0 ),
                        CustomListTile(AppImages.privacy, 'PRIVACY', () => {},15.0 ),
                        CustomListTile(AppImages.ugr, 'USAGE AGREEMENT', () => {},12.0 ),
                        CustomListTile(AppImages.contactus, 'CONTACT US', () => {},15.0 ),
                        SizedBox(height: 10.h),
                        Divider(),
                        CustomListTile(AppImages.logout, 'LOGOUT', () => {},15.0 ),
                      ],
                    ),
                  ),
                ],
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
        onTap:() => onTap,
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