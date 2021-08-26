import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({ Key? key }) : super(key: key);

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
    final userProfile = Get.put(UserProfileController());
   var id;
@override
  void initState() {
    id = Get.arguments;
    print(id);
    userProfile.getUseradProfile(id);
    super.initState();
  }    
  
  
  int offer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: ListView(
          children: [
            detail(),
             Text("${'lastads'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
            lastAds(),
             Text("${'lastoffers'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
            lastAds2(),
             Text("${'laslocation'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color:AppColors.inputTextColor),
              ),
              lastLocations(),
         ],
         ),
      ),
    );
  }
}

Widget detail(){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(right: 10,top: 10),
        child: Card(
          child:Container(
            margin: EdgeInsets.all(7),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'details'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(height:5),
              Text("AppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.details",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
            ],
        ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 5,top: 3),
        child: Card(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text("${'name'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("Ted library",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                    Text("${'mobile'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("+96-6xx-0061395",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                ],
              ),
              // SizedBox(width: 10,)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text("${'email'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("admin@tedlibrary.net",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                  Text("${'address'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("Jeddah,KSA",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 10),
                  
                ],
               ),
              ],
            )
          ),
        ),
    ],
  );
}
Widget lastAds2(){
  return Container(
    margin: EdgeInsets.symmetric(vertical:15),
    height: Get.height/4.5,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Column(
          children: [
            Card(
              elevation: 3,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: Get.width/3,
                  height: Get.height/5.6,
                  child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                ),
              ),
            ),
            Container(
              child: Text("Category1",style: TextStyle(color: Colors.grey),
            )
            )
            ],
        );
      }
    ),
  );
}
Widget lastAds(){
  return Container(
    margin: EdgeInsets.symmetric(vertical:15),
    height: Get.height/4,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                child: Container(
                  width: Get.width/2.3,
                  height: Get.height/7.5,
                  child: Image.asset(AppImages.profileBg,fit: BoxFit.cover,)
                ),
              ),
             Container(
              margin: EdgeInsets.only(left:10,top: 2),
              child: Text("Title",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              ),
             ),
            SizedBox(height: 5,),
            Container(
              margin: EdgeInsets.only(left:9,),
              width: Get.width/2.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(AppImages.location,height: 17,),
                    SizedBox(width: 3,),
                    Text("Locatoin",
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                     ),
                   ]
                ),
                
                Text("SAR 99",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            ),
            ),
            SizedBox(height: 6,),
            Container(
              margin: EdgeInsets.only(left:10),
              width: Get.width/3,
              child: Row(
                children: [
                  Row(children: [
                    Image.asset(AppImages.userProfile,height: 16,),
                    SizedBox(width: 4,),
                    Text("username",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                    ),
                  ]
                ),
              ],
            ),
           ),
         ],
       ),
     );
    }
   ),
 );
}
Widget lastLocations(){
  return Container(
    // margin: EdgeInsets.symmetric(vertical:10),
    height: Get.height/4,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                child: Container(
                  width: Get.width/2.3,
                  height: Get.height/7.5,
                  child: Image.asset(AppImages.profileBg,fit: BoxFit.cover,)
                ),
              ),
            Container(
              margin: EdgeInsets.only(left:9,),
              width: Get.width/2.5,
              child: Container(
                 width: Get.width/2.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 13.5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  SizedBox(width: 2,),
                  Text("(657)",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                   ),
                   Spacer(flex:2),
                   PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (int item) => handleClick(item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Logout')),
                    PopupMenuItem<int>(value: 1, child: Text('Settings')),
                  ],
                ),
                 ]
                ),
              ),
            ),
            Container(
               margin: EdgeInsets.only(left:10),
              width: Get.width/3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text("Zealot Ulotpia",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                    ),
                  ]
                ),
                Image.asset(AppImages.heart)
              ],
            ),
           ),
         ],
       ),
     );
    }
   ),
 );
}
void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}