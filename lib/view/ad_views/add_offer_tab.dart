import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/images.dart';

class AdOffers extends StatefulWidget {
  const AdOffers({ Key? key }) : super(key: key);

  @override
  _AdOffersState createState() => _AdOffersState();
}

class _AdOffersState extends State<AdOffers> {
  @override
  Widget build(BuildContext context) {
    return gridView();
  }
}


Widget gridView(){
  int offer = 1;
  return  GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 1, mainAxisSpacing: 1, crossAxisCount: 2),
        itemCount: 6,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                   width: Get.width/2.5,
                  height: Get.height/5.5,
                  child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                ),
              ),
            ),
            Container(
              child: Text("Offer ${offer++}",style: TextStyle(color: Colors.grey),
            )
            )
            ],
       
    ),
  );
}
  );
}