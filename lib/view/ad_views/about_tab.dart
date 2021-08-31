import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/last_ads_controller.dart';
import 'package:success_stations/controller/last_location_controller.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({ Key? key }) : super(key: key);

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
    final userProfile = Get.put(UserProfileController());
    final lastads = Get.put(LastAdsController());
      final userOffers = Get.put(UserOfferController());
      final lastLoc = Get.put(LastLocationController());
   var id;
@override
  void initState() {
    id = Get.arguments;
    print(id);
    userProfile.getUseradProfile(id);
    lastads.userOfferList(id);
    userOffers.userOfferList(id);
    lastLoc.userlocationList(id);
    super.initState();
  }    
  // @override
  // void dispose() {
  //  id = Get.arguments;
  //   print(id);
  //   userProfile.getUseradProfile(id);
  //   lastads.userOfferList(id);
  //   userOffers.userOfferList(id);
  //   lastLoc.userlocationList(id);
  //   super.dispose();

  // }
  
  int offer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: ListView(
          children: [
             GetBuilder<UserProfileController>( // specify type as Controller
             init: UserProfileController(), // intialize with the Controller
             builder: (value) { 
             return 
             value.userData2 != null ?
             detail(value.userData2['data']):Center(child: CircularProgressIndicator());
            //  allUsers(value.userData['data']): Center(child: CircularProgressIndicator());
             } // value is an instance of Controller.
          ),
            // detail(),
             Text("${'lastads'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
            GetBuilder<LastAdsController>(
              init: LastAdsController(),
              builder: (value){
                return 
                value.lastuserads != null ?
                lastAds(value.lastuserads['data']): Center(child: CircularProgressIndicator());
              }),
              
             Text("${'lastoffers'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: AppColors.inputTextColor),
              ),
               GetBuilder<UserOfferController>( // specify type as Controller
                init: UserOfferController(), // intialize with the Controller
                builder: (value){ 
                  print(value.offerDattaTypeCategory);
                  
                  return 
                  value.offerDattaTypeCategory != null ?
                  lastAds2(value.offerDattaTypeCategory['data']):Center(child: CircularProgressIndicator());// value is an instance of Controller.
                }
                  ),
          //  SizedBox(height: 10,),
             Text("${'lastlocation'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color:AppColors.inputTextColor),
              ),
              GetBuilder<LastLocationController>( // specify type as Controller
                init: LastLocationController(), // intialize with the Controller
                builder: (value){ 
                  print(value.lastLocation);
                  return value.isLoading == true ? Center(child: CircularProgressIndicator()):
                  value.lastLocation !=null &&   value.lastLocation['success']== true ?
                   lastLocations(value.lastLocation['data'])
                   :lastLoc.resultInvalid.isTrue && value.lastLocation['success'] == false?
                   Container(
                     child:Text(lastLoc.lastLocation['errors'])):Container();
                  
                }
                  ),
              
         ],
         ),
      ),
    );
  }
}

Widget detail(userData2){
  return Column(
    children: [
      Card(
        child: Container(
          padding: EdgeInsets.only(left:20),
          width: Get.width,
          margin: EdgeInsets.only(right: 10,top: 10,),
          child: Container(
            margin: EdgeInsets.all(7),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'details'.tr}:",
                style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(height:5),
              userData2['about'] != null ?
              Text(userData2['about'],
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),) : Container()
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
                  Text("Name",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  userData2['name'] == null ? Container():
                  Text(userData2['name'],style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                    Text("${'mobile'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  userData2['mobile'] != null ?
                  Text(userData2['mobile'],style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),):Container(),
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
                  userData2['email'] != null ?
                  Text(userData2['email'],style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),):Container(),
                  SizedBox(height: 15),
                  Text("${'address'.tr}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  userData2['address'] == null ? Container() : 
                  Text(userData2['address'],style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
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
Widget lastAds2(offerDattaTypeCategory){
  return Container(
    margin: EdgeInsets.only(top:10),
    height: Get.height/4,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: offerDattaTypeCategory.length,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Column(
          children: [
            Card(
              elevation: 3,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
                
              child:offerDattaTypeCategory[index]['image_ads'] != null ?  Container(
                
                child: Container(
                  width: Get.width/2.4,
                  height: Get.height/5.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(offerDattaTypeCategory[index]['image_ads']['url'],fit: BoxFit.cover,),
                  ),
                ),
              ):Container(
                 width: Get.width/2.3,
                height: Get.height/5.0,
                child: Icon(Icons.image))
            ),
            offerDattaTypeCategory[index]['text_ads']['en'] != null ?
            Container(
              child: Text(offerDattaTypeCategory[index]['text_ads']['en'],style: TextStyle(color: Colors.grey),
            )
            ): Container()
            ],
        );
      }
    ),
  );
}
 var imageGived;
Widget lastAds(lastuserad){
  return Container(
    margin: EdgeInsets.symmetric(vertical:10),
    height: Get.height/4,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lastuserad.length,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        if(lastuserad !=null && lastuserad[index]['image'] !=null){
          for(int c = 0; c<lastuserad[index]['image'].length;  c++){
           imageGived = lastuserad[index]['image'][c]['url'];
        }

        }
        
        return GestureDetector(
          onTap: (){
          
            Get.to(AdViewScreen(),arguments:lastuserad[index]["id"]);
              print(lastuserad[index]["id"]);
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lastuserad[index]["image"] != null ?
                ClipRRect(
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                  child: Container(
                    width: Get.width/2.3,
                    height: Get.height/7.5,
                    child: lastuserad[index]["image"]!= null && imageGived != null ?Image.network(imageGived,fit: BoxFit.cover,) : Container()
                  ),
                ): Container(
                  width: Get.width/2,
                  child: Icon(Icons.image,size: Get.height/6,)),
                lastuserad[index]['title'] != null ?
               Container(
                margin: EdgeInsets.only(left:10,top: 2),
                child: Text(lastuserad[index]['title']['en'].toString(),
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
               ):Container(),
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
                      lastuserad[index]['city'] != null ?
                      Text(lastuserad[index]['city']['city'],
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                       ): Container()
                     ]
                  ),
               lastuserad[index]['price']!= null ?
                  Text("SAR ${lastuserad[index]['price']}",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                  ): Container()
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
                     lastuserad[index]['contact_name'] != null ?
                      Text(lastuserad[index]['contact_name'],
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                      ): Container()
                    ]
                  ),
                ],
              ),
             ),
           ],
               ),
             ),
        );
    }
   ),
 );
}
Widget lastLocations(lastLocation){
 
  return Container(
     
    margin: EdgeInsets.symmetric(vertical:10),
    height: Get.height/5.5,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:4,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        
        return 
        
         Container(
          // margin: EdgeInsets.only(left:10),
         width: 250,
          height: 100,
          child: Card(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   children: [
                     Container(
                       margin: EdgeInsets.only(left:15),
                       child: Image.asset(AppImages.location,color: Colors.blue,)),
                     Padding(
                       padding: const EdgeInsets.only(top:10.0,left: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               lastLocation['data'][index]['location'] != null ?
                               Container(
                                 width: Get.width/3,
                                 child: Text(lastLocation['data'][index]['location'],textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                             ),
                               ): Container(),
                             ],
                           ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //  children: [
                            //    lastLocation[index]['formated_address'] != null ?
                            //    Text(lastLocation[index]['formated_address'],
                            //       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                            //                             )
                            //                             : Container(),
                            //  ],
                          // ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              Text("city: ",  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10)),
                              lastLocation['data'][index] != null && lastLocation['data'][index]['locality'] !=null?
                              Text(lastLocation['data'][index]['locality'],
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                              ): Container(),
                              SizedBox(width: 5,),
                             
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              Text("Country: " ,  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10)),
                              lastLocation['data'][index]["country_name"] != null ?
                              Text(lastLocation['data'][index]["country_name"],
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                              ): Container(),
                            ],
                          ),
                          
             ],
                 ),
                        
                       ),
                     
                   ],
                 )
               ],
             ),
             
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
                 
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
                 
            //       SizedBox(width: 2,),
            //       lastLocation[index]['location'] != null ?
            //       Text(lastLocation[index]['location'],
            //         style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),
            //        ): Container(),
            //        Spacer(flex:2),
                
            //      ]
            //     ),
            //     
               
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