import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/view/offers/all_offer_detail.dart';

import '../../main.dart';
import '../shimmer.dart';
class AdOffers extends StatefulWidget {
  const AdOffers({ Key? key }) : super(key: key);

  @override
  _AdOffersState createState() => _AdOffersState();
}

class _AdOffersState extends State<AdOffers> {
  final userProfile = Get.put(UserProfileController());
  final userOffers = Get.put(UserOfferController());
  var id, lang;
  GetStorage box = GetStorage();

  @override
  void initState() {
    id = Get.arguments;
    userProfile.getUseradProfile(id);
    userOffers.userOfferList(id);
    lang = box.read('lang_code');
    super.initState();
  }   

  @override
  Widget build(BuildContext context) {
    return 
     GetBuilder<UserOfferController>(
        init: UserOfferController(), 
        builder: (value){ 
          return  value.offerDattaTypeCategory != null && value.offerDattaTypeCategory['data'].length == 0 ? 
          Container(
            width: Get.width,
            alignment: Alignment.center,
            margin:EdgeInsets.only(bottom:Get.height/3.9),
            child: Text(
              "noOfferyet".tr, 
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color:AppColors.black)
            )
          ): 
          value.offerDattaTypeCategory != null ?
          allUsers(value.offerDattaTypeCategory['data']): friendReqShimmer();
        }      
    );
  }
}

Widget gridView(offeredList){
  return  GridView.builder(
    physics: AlwaysScrollableScrollPhysics(),
    primary: false,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: Get.width /(Get.height >= 800 ? Get.height * 0.54 : Get.height <= 800  ? Get.height /1.82  : 0
    ),
    crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 2,),
    itemCount: offeredList.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: (){
          Get.to(MyOfferDetailMain(), arguments:offeredList[index]);
        },
        child: Container(
          child: Column(
            children: [
              Card(
                elevation: 3,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: offeredList[index]['image'] != null && offeredList[index]['image']['url'] !=null  ? 
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      offeredList[index]['image']['url'], height: Get.height/5, width: Get.width,fit: BoxFit.cover
                    ),
                  ),
                )
                :FittedBox(
                  child: Icon(Icons.image,size: Get.height/5,)
                )
              ),
              Container(
                child: Text(
                  offeredList[index]['text_ads']['en'],
                  style: TextStyle(color: Colors.grey),
                )
              )
            ],
          ),
        ),
      );
    }
  );
}
Widget allUsers(offeredList) {
  return Container(
      child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 0.70,
          crossAxisSpacing: 0.70,
          childAspectRatio: Get.width /
              (Get.height >= 800
                  ? Get.height * 0.45
                  : Get.height <= 800
                  ? lang == 'en'
                  ? Get.height * 0.5
                  : Get.height * 0.46
                  : 0),
          children: List.generate(offeredList.length, (c) {
            return GestureDetector(
              onTap: () {
                Get.to(MyOfferDetailMain(), arguments: offeredList[c]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(00),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                child: Container(
                  // margin:EdgeInsetsDirectional.only(bottom:20),
                  height: Get.height * 0.18,
                  width: Get.height * 0.83,
                  child: offeredList[c]['image'] != null &&
                      offeredList[c]['image']['url'] != null
                      ? FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      offeredList[c]['image']['url'],
                    ),
                  )
                      : FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            );
          })));
}