import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/bottom_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';

class MapView extends StatefulWidget {
  const MapView({ Key? key }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
    //  bottomNavigationBar: CustomBottomBar(),
      // appBar: 
      // PreferredSize( preferredSize: Size.fromHeight(70.0),
      //    child:appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch)),
      //    drawer: Theme(
      //   data: Theme.of(context).copyWith(
      //     // canvasColor: AppColors.botomTiles
      //   ),
      //   child: AppDrawer(),
      // ),
      body: Stack(
        children: [
           listtype == 'map' ? googleMap() : lastLocations(),

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

Widget googleMap(){
  return Container(
    height: Get.height,
    child: GoogleMap(
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(51.507351,-0.127758),
      ),
    ),
  );
}


Widget lastLocations(){

  return GridView.builder(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
        primary: false,
        // padding: const EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10, mainAxisSpacing: 20, crossAxisCount: 2,
          childAspectRatio: Get.width /
              (Get.height/ 1.4),
        ),

        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/adViewTab');
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
                    child: Image.asset(AppImages.profileBg,fit: BoxFit.cover,)
                  ),
                ),
              Row(
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
              Row(
                children: [
                  Container(
                     margin: EdgeInsets.only(left:10),
                    width: Get.width/3,
                    child:
                        Text("Zealot Ulotpia",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                        ),
             ),
                  Image.asset(AppImages.heart)
                ],
              ),
                SizedBox(height: 15,)
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