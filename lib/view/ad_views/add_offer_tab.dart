import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/images.dart';

class AdOffers extends StatefulWidget {
  const AdOffers({ Key? key }) : super(key: key);

  @override
  _AdOffersState createState() => _AdOffersState();
}

class _AdOffersState extends State<AdOffers> {
   final userProfile = Get.put(UserProfileController());
   final userOffers = Get.put(UserOfferController());
   var id;
@override
  void initState() {
    id = Get.arguments;
    userProfile.getUseradProfile(id);
    userOffers.userOfferList(id);
    super.initState();
  }    
  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<UserOfferController>( // specify type as Controller
  init: UserOfferController(), // intialize with the Controller
  builder: (value){ 
    
    return 
    value.offerDattaTypeCategory != null ?
    gridView(value.offerDattaTypeCategory['data']):Center(child: CircularProgressIndicator());// value is an instance of Controller.
  }
    );
    
  }
}


Widget gridView(offeredList){
  return  GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: Get.width /
        (Get.height >= 800 ? Get.height/ 1.50 :Get.height <= 800 ? Get.height/ 1.80 :0),
            crossAxisSpacing: 1, mainAxisSpacing: 1, crossAxisCount: 2),
        itemCount: offeredList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
    // margin: EdgeInsets.symmetric(vertical:15),
    // height: Get.height/5.5,
    child: Column(
          children: [
            Card(
              elevation: 3,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              
              child:offeredList[index]['image_ads'] != null ?  Container(
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(offeredList[index]['image_ads']['url'],height: Get.height/5,width: Get.width,fit: BoxFit.cover,),
                ),
              ):FittedBox(child: Icon(Icons.image,size: Get.height/5,))
            ),
            Container(
              child: Text(offeredList[index]['text_ads']['en'],style: TextStyle(color: Colors.grey),
            )
            )
            ],
       
    ),
  );
}
  );
}