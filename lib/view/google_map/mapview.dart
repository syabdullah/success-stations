import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:success_stations/controller/all_users_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_views/ad_viewmain.dart';

class MapView extends StatefulWidget {
  const MapView({ Key? key }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
     final banner = Get.put(BannerController());
  @override
  void initState() {
    banner.bannerController();
    super.initState();
  }
  var listtype = 'map'; 
  var grid = AppImages.gridOf;
  Color listIconColor = Colors.grey; 
  
   Widget topWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  listtype = 'grid';
                  listIconColor = Colors.grey;
                  grid = AppImages.grid;
                });             
              },
              icon: Image.asset(grid)
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10,),
              child: IconButton(
                onPressed: (){
                  setState(() {
                    listtype = 'map';
                    listIconColor = AppColors.appBarBackGroundColor;
                    grid = AppImages.gridOf;
                  });
                },
                icon: Icon(Icons.map,color: listIconColor,size: 45,)
              ),
            ),
            SizedBox(height: 30,width: 15,)
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(Get.height);
    return Scaffold(
      body: Stack(
        children: [
           listtype == 'map' ? googleMap(kInitialPosition) :
           GetBuilder<AllUsersController>( // specify type as Controller
          init: AllUsersController(), // intialize with the Controller
          builder: (value) { 
           
             return 
             value.userData != null ?
             allUsers(value.userData['data']): Center(child: CircularProgressIndicator());
             } // value is an instance of Controller.
          ),
          Container(
            child: Row(
              children: [
                topWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
} 

Widget googleMap(kInitialPosition){
  
  return Container(
    height: Get.height,
    child: PlacePicker(
      apiKey: "AIzaSyDS0wbOsjYPi6CaKvbs13USS5CUOc2D91c",
      initialPosition: kInitialPosition,
          useCurrentLocation: true,
          usePlaceDetailSearch: true,
          onPlacePicked: (result) {
            print(result.geometry!.location);
            // selectedPlace = result;
            // Navigator.of(context).pop();
            // setState(() {});
          },
      // initialCameraPosition: CameraPosition(
      //   zoom: 15,
      //   target: LatLng(51.507351,-0.127758),
      // ),
    ),
  );
}



Widget allUsers(userData){

  return GridView.builder(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
        primary: false,
        // padding: const EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10, mainAxisSpacing: 20, crossAxisCount: 2,
        childAspectRatio: Get.width /
        (Get.height >= 800 ? Get.height/ 1.50 :Get.height <= 800 ? Get.height/ 1.80 :0),
        ),
        itemCount: userData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
             
              Get.to(AdViewTab(),arguments: userData[index]['id']);
            },
            child: Card(
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
                    width: Get.width/2.2,
                      height: Get.height/5,
                    child:userData[index]['image'] != null ? Image.network(userData[index]['image']['url']): Icon(Icons.image)
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                // RatingBar.builder(
                //   initialRating: 3,
                //   minRating: 1,
                //   direction: Axis.horizontal,
                //   allowHalfRating: true,
                //   itemCount: 5,
                //   itemSize: 13.5,
                //   // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                //   itemBuilder: (context, _) => Icon(
                //     Icons.star,
                //     color: Colors.amber,
                //   ),
                //   onRatingUpdate: (rating) {
                //     print(rating);
                //   },
                // ),
                // SizedBox(width: 2,),
                // Text("(657)",
                //   style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                //  ),
               ]
              ),
                    Center(
                      child: Text(userData[index]['name'].toString(),
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                      ),
                    ),
             
                
         ],
       ),
     ),
          );
          }
  );
}
//   return Container(
//     margin: EdgeInsets.only(top:90,left: 15,right: 15),
//     height: Get.height,
//     child: GridView.builder(
//         primary: false,
//         padding: const EdgeInsets.all(0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisSpacing: 6, mainAxisSpacing: 8, crossAxisCount: 2),
//         itemCount: 6,
//         itemBuilder: (BuildContext context, int index) {
//           return Stack(
//             children: [
//               Card(
//                 color: Colors.red,
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
//                     child: Container(
//                       width: Get.width/2.3,
//                         height: Get.height/6.5,
//                       child: Image.asset(AppImages.profileBg,fit: BoxFit.cover,)
//                     ),
//                   ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                   RatingBar.builder(
//                     initialRating: 3,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemSize: 13.5,
//                     // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                     },
//                   ),
//                   SizedBox(width: 2,),
//                   Text("(657)",
//                     style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
//                    ),

//                    PopupMenuButton<int>(
//                   icon: Icon(Icons.more_vert),
//                   onSelected: (int item) => handleClick(item),
//                   itemBuilder: (context) => [
//                     PopupMenuItem<int>(value: 0, child: Text('Logout')),
//                     PopupMenuItem<int>(value: 1, child: Text('Settings')),
//                   ],
//                 ),
//                  ]
//                 ),
//                 Container(
//                    margin: EdgeInsets.only(left:10),
//                   width: Get.width/3,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(children: [
//                         Text("Zealot Ulotpia",
//                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
//                         ),
//                       ]
//                     ),
//                     Image.asset(AppImages.heart)
//                   ],
//                 ),
//                ),
//                   SizedBox(height: 15,)
//          ],
//        ),
//      ),
//             ],
//           );
//     }
//    ),
//  );

void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}