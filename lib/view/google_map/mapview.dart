
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/controller/user_fav_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_views/ad_viewmain.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:success_stations/view/drawer_screen.dart';

class CustomInfoWindowExample extends StatefulWidget {
  @override
  _CustomInfoWindowExampleState createState() =>
      _CustomInfoWindowExampleState();
}

class _CustomInfoWindowExampleState extends State<CustomInfoWindowExample> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
         final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final mapCon = Get.put(LocationController());
final adfavUser = Get.put(UserFavController());
  late LatLng _latLng = LatLng(51.5160322, 51.516032199999984);
  final double _zoom = 15.0;
  int _makrr_id_counter = 1;
     var listtype = 'map'; 
      //  Marker _markers = [];
         List<Marker> _markers = [];
  var adtofavJson,remtofavJson;
   var route;
  var grid = AppImages.gridOf;
  Color listIconColor = Colors.blue; 
  GetStorage box = GetStorage();
  bool visible = false;
  bool isButtonPressed = false;
    @override
  void initState() {
    super.initState();
    _getUserLocation();
    var id = box.read('user_id');
    route = Get.arguments;
      mapCon.getAllLocationToDB();
    }   
  

  _getUserLocation() async {
    position  = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latLng =  LatLng(position.latitude, position.longitude);
      print("///.............-------.............>$_latLng");
    });
  }
  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }
 void setMarkers(LatLng point, data) {
    final String markersId = 'marker_id_$_makrr_id_counter';
    _makrr_id_counter++;
    print(".................-==--==-=--==-=--=-=");
      _markers.add(
        Marker(markerId: MarkerId(markersId),
        position: point,
        onTap: () {
          setState(() {
            visible = !visible;
          });        
          double rat = double.parse(data['user_name']['rating'].toString());       
          _customInfoWindowController.addInfoWindow!(            
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(AdViewTab(),arguments: data['user_name']['id']);
                      print(data['user_name']['id']);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Container(
                        // padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            data['user_name']['image'] != null ?
                            Container(
                              width: Get.width/5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15),bottom:Radius.circular(15) ),
                                child:  Image.network(data['user_name']['image']['url'])),
                            )
                               : Container(
                                 height: Get.height/3,
                                 width: Get.width/5.5,
                                 color: Colors.grey[100],
                                margin: EdgeInsets.all(20 ),
                                child: Icon(Icons.image,size: 60)
                              ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10,left: 15),
                                      child: RatingBar.builder(
                                        initialRating: rat ,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        allowHalfRating: true,
                                        // tapOnlyMode: false,
                                        itemCount: 5,
                                        itemSize: 19.5,
                                        // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: 
                                        (rating) {
                                          print(rating);
                                        },  
                                      ),
                                    ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10,left:10),
                                        child: Text("(${data['user_name']['rating_count'].toString()})",
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,),
                                        ),
                                      ),
                                  ],
                                ),
                               
                                Container(
                                  width: Get.width/4,
                                  margin: EdgeInsets.only(top: 10,left:15),
                                  child: Text(
                                    data['user_name']['name'],
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                                        // Theme.of(context).textTheme.headline6!.copyWith(
                                        //       color: Colors.black,
                                        //     ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: data['user_name']['is_user_favourite'] == true ? Image.asset(AppImages.redHeart,height: 30,):
                              Image.asset(AppImages.blueHeart,height: 30,)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.blue,
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            point,
          );
        }
        )
      );
    //  });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:  
      GetBuilder<LocationController>(
        init: LocationController(),
        builder: (val){
          _markers.clear();         
          if(val.allLoc != null)
           for(int i=0; i < val.allLoc['data']['data'].length; i++) {
            if(val.allLoc['data']['data'][i]['location'] != null){
              setMarkers(LatLng(val.allLoc['data']['data'][i]['long'],val.allLoc['data']['data'][i]['long']),val.allLoc['data']['data'][i]);
              _latLng =LatLng(val.allLoc['data']['data'][i]['long'],val.allLoc['data']['data'][i]['long']);
            }
          }
          print("--------------------------------------$_latLng");
          return  Stack(
            children: [
              listtype == 'map' ? 
              Stack(
                children: <Widget>[
                  val.allLoc != null ? 
                  googleMap(_latLng):Container(),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    height: Get.height/6,
                    width: Get.width/1.2,
                    offset: 50,
                  ),
                ],
              ):
              GetBuilder<LocationController>( // specify type as Controller
              init: LocationController(), // intialize with the Controller
              builder: (value) {            
                return 
                value.allLoc != null ?
                allUsers(value.allLoc['data']): Center(child: CircularProgressIndicator());
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
        );
        }
      ),
    );
  }
 
  
   Widget topWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        
        child: Row(
          children: [
            IconButton(
              color: isButtonPressed ? Colors.blue : Colors.grey,
                onPressed: () {
                  setState(() {
                    listtype = 'grid';
                    isButtonPressed = !isButtonPressed;
                    listIconColor = Colors.grey;
                    grid = AppImages.grid;
                  });
                },
                icon: Image.asset(grid)),
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      listtype = 'map';
                      listIconColor = Colors.blue;
                      grid = AppImages.gridOf;
                    });
                  },
                  icon: Icon(
                    Icons.map,
                    color: listIconColor,
                    size: 45,
                  )),
            ),
            SizedBox(
              height: 30,
              width: 15,
            )
          ],
        ),
      ),
    );
  }
  Widget allUsers(userData){
   print(":';';';';';';';'%%%%%%------${userData['data'].length}");
    return GridView.builder(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
      primary: false,
      // padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: Get.width /
            (Get.height >= 800
                ? Get.height / 1.65
                : Get.height <= 800
                    ? Get.height / 1.60
                    : 0),
      ),
      itemCount: userData['data'].length,
      itemBuilder: (BuildContext context, int index) {
         print(":';';';';';';';'%%%%%%------${userData['data'][index]}");
        return GestureDetector(
          onTap: () {
            Get.to(AdViewTab(), arguments: userData['data'][index]['user_name']['id']);
            //var cc=userData[index]['id']);
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Container(
                        width: Get.width / 2.2,
                        height: Get.height / 5.2,
                        child: userData['data'][index]['user_name']['image'] != null
                            ? Image.network(userData['data'][index]['user_name']['image']['url'],fit: BoxFit.fill,)
                            : Icon(Icons.image)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 15),
                    child: Text(
                      userData['data'][index]['user_name']['name'].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        //
                        children: [
                          Container(
                            //  margin: EdgeInsets.only(left:20),
                            child: RatingBar.builder(
                              ignoreGestures: true,
                              initialRating:
                                  userData['data'][index]['user_name']['rating'].toDouble(),
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
                                //  var ratingjson = {
                                //    'ads_id' : userData[index]['id'],
                                //    'rate': rating
                                //  };
                                //  ratingcont.ratings(ratingjson );
                                //  ratingcont.getratings(userData[index]['id']);
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "(${userData['data'][index]['user_name']['rating_count'].toString()})",
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),                     
                      GestureDetector(
                        onTap: (){
                          adtofavJson = {
                              'user_id': userData['data'][index]['user_name']['id']
                          };
                          remtofavJson = {
                           'user_id': userData['data'][index]['user_name']['id']
                          };
                          userData['data'][index]['user_name']['is_user_favourite'] == false ?
                          adfavUser.profileAdsToFav(adtofavJson):
                          adfavUser.profileRemToFav(remtofavJson);
                          print(adtofavJson);
                        },
                        child: 
                        userData['data'][index]['user_name']['is_user_favourite'] == false ?
                        Image.asset(AppImages.blueHeart,height: 18,) : Image.asset(AppImages.heart)
                      ) 
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
      
}

void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}
Widget googleMap(kInitialPosition){ 
  return Container(
    height: Get.height,
    child: 
    GoogleMap(
      onTap: (position) {
        setState(() {
          
        });
       
      },
      onCameraMove: (position) {
        _customInfoWindowController.onCameraMove!();
      },
      onMapCreated: (GoogleMapController controller) async {
        _customInfoWindowController.googleMapController = controller;
      },
      
      initialCameraPosition: CameraPosition(
        target: kInitialPosition,
        // zoom: _zoom,
      ),
      markers: _markers.toSet(),
    ),
    );
}
}



// class MapView extends StatefulWidget {
//   const MapView({ Key? key }) : super(key: key);

//   @override
//   _MapViewState createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   static final kInitialPosition = LatLng(-33.8567844, 151.213108);
//     final banner = Get.put(BannerController());
//     List<Marker> customMarkers = [];
//     int _makrr_id_counter = 1;
//     GoogleMapController? mapController;
//     Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//     MarkerId? selectedMarker;
//     CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();
// static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   void setMarkers(LatLng point) {
//     final String markersId = 'marker_id_$_makrr_id_counter';
//     _makrr_id_counter++;
//     setState(() {
//       customMarkers.add(
//         Marker(markerId: MarkerId(markersId),
//         // infoWindow: InfoWindow(
          
//         // ),
//         onTap: () {
//           print(".././/././");
//           setState(() {
//           _customInfoWindowController.addInfoWindow!(
//             Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.account_circle,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             "I am here",
//                             style:
//                                 Theme.of(context).textTheme.headline6!.copyWith(
//                                       color: Colors.white,
//                                     ),
//                           )
//                         ],
//                       ),
//                     ),
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 // Triangle.isosceles(
//                 //   edge: Edge.BOTTOM,
//                 //   child: Container(
//                 //     color: Colors.blue,
//                 //     width: 20.0,
//                 //     height: 10.0,
//                 //   ),
//                 // ),
//               ],
//             ),
//             kInitialPosition,
//           );
//            });
//         },
//         position:point
//       ));
//     });
//   }
//   @override
//   void initState() {
//     banner.bannerController();
//     super.initState();
//   }
 
//   var listtype = 'map'; 
//   var grid = AppImages.gridOf;
//   Color listIconColor = Colors.grey; 
  
//    Widget topWidget() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         color: Colors.white,
//         child: Row(
//           children: [
//             IconButton(
//               onPressed: (){
//                 setState(() {
//                   listtype = 'grid';
//                   listIconColor = Colors.grey;
//                   grid = AppImages.grid;
//                 });             
//               },
//               icon: Image.asset(grid)
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10,),
//               child: IconButton(
//                 onPressed: (){
//                   setState(() {
//                     listtype = 'map';
//                     listIconColor = AppColors.appBarBackGroundColor;
//                     grid = AppImages.gridOf;
//                   });
//                 },
//                 icon: Icon(Icons.map,color: listIconColor,size: 45,)
//               ),
//             ),
//             SizedBox(height: 30,width: 15,)
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(Get.height);
//     return
//     //  Scaffold(
//     //   body:
//        Stack(
//         children: [
//           //  listtype == 'map' ? 
//            googleMap(kInitialPosition),
//             CustomInfoWindow(
//                 controller: _customInfoWindowController,
//                 height: 75,
//                 width: 150,
//                 offset: 50,
//               ),
//           //  :
//           //  GetBuilder<AllUsersController>( // specify type as Controller
//           // init: AllUsersController(), // intialize with the Controller
//           // builder: (value) { 
           
//           //    return 
//           //    value.userData != null ?
//           //    allUsers(value.userData['data']): Center(child: CircularProgressIndicator());
//           //    } // value is an instance of Controller.
//           // ),
//           Container(
//             child: Row(
//               children: [
//                 topWidget()
//               ],
//             ),
//           )
//         ],
//       );
//     // );
//   }






// Widget allUsers(userData){
//   return GridView.builder(
//         padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
//         primary: false,
//         // padding: const EdgeInsets.all(0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisSpacing: 10, mainAxisSpacing: 20, crossAxisCount: 2,
//         childAspectRatio: Get.width /
//         (Get.height >= 800 ? Get.height/ 1.50 :Get.height <= 800 ? Get.height/ 1.80 :0),
//         ),
//         itemCount: userData.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
             
//               Get.to(AdViewTab(),arguments: userData[index]['id']);
//             },
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
//                   child: Container(
//                     width: Get.width/2.2,
//                       height: Get.height/5,
//                     child:userData[index]['image'] != null ? Image.network(userData[index]['image']['url']): Icon(Icons.image)
//                   ),
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                 // RatingBar.builder(
//                 //   initialRating: 3,
//                 //   minRating: 1,
//                 //   direction: Axis.horizontal,
//                 //   allowHalfRating: true,
//                 //   itemCount: 5,
//                 //   itemSize: 13.5,
//                 //   // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
//                 //   itemBuilder: (context, _) => Icon(
//                 //     Icons.star,
//                 //     color: Colors.amber,
//                 //   ),
//                 //   onRatingUpdate: (rating) {
//                 //     print(rating);
//                 //   },
//                 // ),
//                 // SizedBox(width: 2,),
//                 // Text("(657)",
//                 //   style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
//                 //  ),
//                ]
//               ),
//                     Center(
//                       child: Text(userData[index]['name'].toString(),
//                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
//                       ),
//                     ),
             
                
//          ],
//        ),
//      ),
//           );
//           }
//   );
// }
// //   return Container(
// //     margin: EdgeInsets.only(top:90,left: 15,right: 15),
// //     height: Get.height,
// //     child: GridView.builder(
// //         primary: false,
// //         padding: const EdgeInsets.all(0),
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisSpacing: 6, mainAxisSpacing: 8, crossAxisCount: 2),
// //         itemCount: 6,
// //         itemBuilder: (BuildContext context, int index) {
// //           return Stack(
// //             children: [
// //               Card(
// //                 color: Colors.red,
// //                 elevation: 3,
// //                 shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15.0),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   ClipRRect(
// //                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
// //                     child: Container(
// //                       width: Get.width/2.3,
// //                         height: Get.height/6.5,
// //                       child: Image.asset(AppImages.profileBg,fit: BoxFit.cover,)
// //                     ),
// //                   ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                   RatingBar.builder(
// //                     initialRating: 3,
// //                     minRating: 1,
// //                     direction: Axis.horizontal,
// //                     allowHalfRating: true,
// //                     itemCount: 5,
// //                     itemSize: 13.5,
// //                     // itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
// //                     itemBuilder: (context, _) => Icon(
// //                       Icons.star,
// //                       color: Colors.amber,
// //                     ),
// //                     onRatingUpdate: (rating) {
// //                       print(rating);
// //                     },
// //                   ),
// //                   SizedBox(width: 2,),
// //                   Text("(657)",
// //                     style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
// //                    ),

// //                    PopupMenuButton<int>(
// //                   icon: Icon(Icons.more_vert),
// //                   onSelected: (int item) => handleClick(item),
// //                   itemBuilder: (context) => [
// //                     PopupMenuItem<int>(value: 0, child: Text('Logout')),
// //                     PopupMenuItem<int>(value: 1, child: Text('Settings')),
// //                   ],
// //                 ),
// //                  ]
// //                 ),
// //                 Container(
// //                    margin: EdgeInsets.only(left:10),
// //                   width: Get.width/3,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Row(children: [
// //                         Text("Zealot Ulotpia",
// //                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
// //                         ),
// //                       ]
// //                     ),
// //                     Image.asset(AppImages.heart)
// //                   ],
// //                 ),
// //                ),
// //                   SizedBox(height: 15,)
// //          ],
// //        ),
// //      ),
// //             ],
// //           );
// //     }
// //    ),
// //  );

// void handleClick(int item) {
//   switch (item) {
//     case 0:
//       break;
//     case 1:
//       break;
//   }
// }
// }
