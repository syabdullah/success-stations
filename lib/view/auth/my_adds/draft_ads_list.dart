import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:success_stations/controller/user_drafted_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';

class DraftAds extends StatefulWidget {
  const DraftAds({ Key? key }) : super(key: key);

  @override
  _DraftAdsState createState() => _DraftAdsState();
}

class _DraftAdsState extends State<DraftAds> {
  final getData= Get.put(DraftAdsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Drafted Ads",),
        backgroundColor: AppColors.appBarBackGroundColor,),
        body: GetBuilder<DraftAdsController>( // specify type as Controller
          init: DraftAdsController(), // intialize with the Controller
          // print(getData.userData);
          builder: (value) { 
             print("..................f..............${value.userData}");
           return draftedlist();}
)
);
  }
}
Widget draftedlist(){
  return Container();
}

//  ListView.builder(
//           itemCount:value.userData.length,
//           itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(value.userData['data'].toString()),
//           );
//   },
//           )