import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/sign_in_controller.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/favourite.dart';
import 'package:success_stations/view/UseProfile/user_profile.dart';
import 'package:success_stations/view/about_us.dart';
import 'package:success_stations/view/auth/advertise.dart';
import 'package:success_stations/view/auth/contact.dart';
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
  late String imageP;
  var fileName;
  
  // var name  = '';
  // name  = box.read('name');
   @override
  void initState() {
    super.initState();
    image = box.read('user_image');
  }
   Future getImage() async { 
    await ApiHeaders().getData();
   pickedFile =   await _picker.pickImage(source: ImageSource.gallery);
   
    setState(() {
      if (pickedFile != null) {
        imageP = pickedFile!.path;      
        fileName = pickedFile!.path.split('/').last;  
      } else {
        print('No image selected.');
      }
    });
      try {
          dio.FormData formData = dio.FormData.fromMap({          
            "file": await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
          });
   print("........................YYYYYYYYYYYY");
          Get.find<AdPostingController>().uploadAdImage(formData); 
        } catch (e) {

        }
  }
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
                                translation: Get.height > 400 ? const Offset(0.2, 1.3): const Offset(0.2, 0.8),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 60.0,
                                  child:   fileName != null ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: Image.file(File(imageP),fit: BoxFit.fitWidth,)): Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height:30),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(60.0),
                                        child: image != null ? 
                                        Image.network(
                                          image,
                                        ):
                                        Image.asset(AppImages.person),
                                      ),
                                      
                                    ],
                                  )
                                )
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                     Container(  
                       margin: EdgeInsets.only(top:25,right: 55),        
                       child: IconButton(
                       onPressed: () {
                         getImage();
                       },
                       icon:Icon(Icons.camera_alt,size: 40)
                       )
                      // ),
                    ),
                    // SizedBox(height:30),
                    Padding(
                      padding: const EdgeInsets.only(left:130.0),
                      child: Text(
                        box.read('name'),
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
                            Get.to(BottomTabs());
                          },15.0 ),
                          CustomListTile(AppImages.userProfile, 'profile'.tr, ()  {
                            // Get.toNamed('/friendProfile');
                            Get.offAll(UserProfile());
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
                          CustomListTile(AppImages.offers, 'My Offer', () {
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
                           Get.off(Contact())
                          },15.0 ),
                          SizedBox(height: 10.h),
                          Divider(),
                          CustomListTile(AppImages.logout, 'logout'.tr, ()  {
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