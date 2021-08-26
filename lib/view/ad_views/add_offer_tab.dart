import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/styling/images.dart';

class AdOffers extends StatefulWidget {
  const AdOffers({ Key? key }) : super(key: key);

  @override
  _AdOffersState createState() => _AdOffersState();
}

class _AdOffersState extends State<AdOffers> {
  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<UserOfferController>( // specify type as Controller
  init: UserOfferController(), // intialize with the Controller
  builder: (value){ 
    print(value.offerDattaTypeCategory);
    
    return 
    value.offerDattaTypeCategory != null ?
    gridView(value.offerDattaTypeCategory['data']):Center(child: CircularProgressIndicator());// value is an instance of Controller.
  }
    );
    
  }
}


Widget gridView(offeredList){
  int offer = 1;
  return  GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              
              child:offeredList[index]['image_ads'] != null ?  ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                   width: Get.width/2.5,
                  height: Get.height/5.5,
                  child: Image.network(offeredList[index]['image_ads'])
                ),
              ):Container(
                height: 120,
                color: Colors.red,
              ),
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