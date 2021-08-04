import 'package:flutter/material.dart';
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
           Expanded(
          child: listtype == 'map' ? googleMap() : mapGridView()
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

Widget googleMap(){
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      zoom: 15,
      target: LatLng(51.507351,-0.127758),
    ),
  );
}
Widget mapGridView(){
  return Center(child:Text("junaid"));
}