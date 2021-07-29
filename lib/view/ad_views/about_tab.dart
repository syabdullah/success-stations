import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({ Key? key }) : super(key: key);

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  int offer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: ListView(
          children: [
            detail(),
             Text("${AppString.lastAds}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
            lastAds(),
             Text("${AppString.lastOffer}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
            lastAds2(),
             Text("${AppString.lastLocations}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color:AppColors.inputTextColor),
              ),
              lastAds2(),
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
              Text("${AppString.details}:",
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
                  Text("${AppString.namec}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("Ted library",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                    Text("${AppString.mobilec}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
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
                  Text("${AppString.emailc}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("admin@tedlibrary.net",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                  Text("${AppString.adress}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
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
    height: Get.height/5.5,
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
                  height: Get.height/7.5,
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
        return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: Get.height/7.5,
                  child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                ),
              ),
            ),
            Text("Category1",style: TextStyle(color: Colors.grey),
               ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  Icon(Icons.location_city),
                  Text("data"),
                ],),
              Text("data"),
              ],
            )
            ],
        );
      }
    ),
  );
}