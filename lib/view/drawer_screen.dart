import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/favourite.dart';
import 'package:success_stations/view/UseProfile/user_profile.dart';
import 'package:success_stations/view/about_us.dart';
import 'package:success_stations/view/auth/advertise.dart';
import 'package:success_stations/view/auth/contact.dart';
import 'package:success_stations/view/auth/my_adds/draft_ads_list.dart';
import 'package:success_stations/view/auth/my_adds/my_adds.dart';
import 'package:success_stations/view/auth/notification.dart';
import 'package:success_stations/view/bottom_bar.dart';
import 'package:success_stations/view/friends/friend_request.dart';
import 'package:success_stations/view/google_map/my_locations.dart';
import 'package:success_stations/view/member_ship/member_ship.dart';
import 'package:success_stations/view/messages/inbox.dart';
import 'package:success_stations/view/offers/my_offers.dart';
import 'package:dio/dio.dart' as dio;

class AppDrawer extends StatefulWidget {
 const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final logoutCont = Get.put(LoginController());
  var image;
  GetStorage box = GetStorage();
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    XFile? pickedFile;
  var imageP;
  var fileName;
  
   final banner = Get.put(BannerController());

  @override
  void dispose() {
    // TODO: implement dispose
    banner.bannerController();
    super.dispose();

  }
  // var name  = '';
  // name  = box.read('name');
   @override
  void initState() {
    super.initState();
    image = box.read('user_image');
    print("............11-1-1-1--1-1-.$image");
    imageP = box.read('user_image_local');
    banner.bannerController();
    
  }
  Future getImage() async { 
    await ApiHeaders().getData();
    pickedFile =   await _picker.pickImage(source: ImageSource.gallery);
   
    setState(() {
      if (pickedFile != null) {
        imageP = pickedFile!.path;    
        
        box.write("user_image_local", imageP);
        fileName = pickedFile!.path.split('/').last;  
      } else {
        print('No image selected.');
      }
    });
      try {
          dio.FormData formData = dio.FormData.fromMap({          
            "file": await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
          });
   print("..........=-=-=-=-=-=-=-=-=$imageP");  
          Get.find<AdPostingController>().uploadAdImage(formData); 
          Get.find<UserProfileController>().getUserProfile();
        } catch (e) {

        }
  }

  @override
  Widget build(BuildContext context) {
    imageP = box.read('user_image_local').toString();
    // print(".............$imageP...........YYYYYYYYYYYY${Get.height}");
    image = box.read('user_image');
    
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
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                        },
                        child: Stack(
                          children: [                              
                            GestureDetector(
                               onTap:() { 
                                getImage();
                              },
                              child: FractionalTranslation(
                                translation: Get.height > 700 ? const Offset(0.2, 1.3): const Offset(0.2, 0.9),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 60.0,
                                  // child:   Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                      // SizedBox(height:30)≥
                                      child:ClipRRect(
                                        borderRadius: BorderRadius.circular(60.0),
                                        child:                                       
                                        imageP.toString() != 'null' ?
                                         Image.file(File(imageP),fit: BoxFit.cover,height: Get.height/5,width: Get.width/3.3,):
                                         image.toString() == 'null' ? 
                                        Image.asset(AppImages.person,color: Colors.grey[400]) : 
                                        Image.network(
                                          image['url'],
                                          fit: BoxFit.fill,
                                          height: Get.height/6.5,width: Get.width/3.3,
                                        ))
                                      
                                      
                                  //   ],
                                  // )
                                )
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    
                    // SizedBox(height:30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Container(  
                       margin: Get.height > 700 ? EdgeInsets.only(top:35,left: 35): EdgeInsets.only(top:25,left: 85),        
                       child: IconButton(
                       onPressed: () {
                         getImage();
                       },
                       icon:Icon(Icons.camera_alt,size: 40,color: Colors.grey,)
                       )
                      // ),
                    ),
                        Padding(
                          padding: Get.height > 700 ?  const EdgeInsets.only(left:10.0) :const EdgeInsets.only(left:50.0),
                          child: Text(
                            box.read('name'),
                            style:AppTextStyles.appTextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color:Colors.grey.shade800
                            ),
                          ),
                        ),
                      ],
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
                            Get.to(BottomTabs());
                          },15.0 ),
                          CustomListTile(AppImages.aboutus, 'Draft Ads'.tr, ()  {
                            Get.to(DraftAds());
                          },15.0 ),
                          CustomListTile(AppImages.userProfile, 'profile'.tr, ()  {
                            // Get.toNamed('/friendProfile');
                            Get.to(UserProfile());
                          },15.0 ),
                          CustomListTile(AppImages.ma, 'my_ads'.tr, ()  {
                           Get.to(MyAdds());
                          } ,15.0),
                          CustomListTile(AppImages.message, 'messeges'.tr, () {
                            Get.to(Inbox());
                          },15.0 ),
                          CustomListTile(AppImages.location, 'addlocation'.tr, () {
                            Get.to(MyLocations());
                          },15.0 ),
                          CustomListTile(AppImages.membership, 'membership'.tr, () {
                          
                            Get.to(MemberShip());
                          },13.2 ),
                          CustomListTile(AppImages.notification, 'notification'.tr, () => {
                            Get.to(NotificationPage())
                          },15.0 ),
                          CustomListTile(AppImages.freq, 'friend_requests'.tr, ()  {
                           Get.to(FriendReqList());
                          } ,15.0),
                          CustomListTile(AppImages.offers, 'myoffer'.tr, () {
                            Get.to(OffersDetail());
                          },15.0 ), 
                          CustomListTile(AppImages.fav, 'favourite'.tr, () => {
                            Get.toNamed('/favourities')
                          },15.0 ), 
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
                           Get.to(AboutUs());
                          },15.0 ),
                          CustomListTile(AppImages.privacy, 'privacy'.tr, () => {},15.0 ),
                          CustomListTile(AppImages.adwithus, 'advertise_with_us'.tr, () => {
                           Get.to(AdvertisePage())
                          },15.0 ),
                          CustomListTile(AppImages.ugr, 'user_agreement'.tr, () => {},12.0 ),
                          CustomListTile(AppImages.contactus, 'cntact_us'.tr, () => {
                           Get.to(Contact())
                          },15.0 ),
                          SizedBox(height: 10.h),
                          Divider(),
                          CustomListTile(AppImages.logout, 'logout'.tr, ()  {
                            box.remove('user_image_local');
                            logoutCont.userLogout();                            
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
                  Image.asset(image.toString(),height: height,color:Colors.grey[600]),
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