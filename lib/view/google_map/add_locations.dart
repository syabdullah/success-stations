import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({ Key? key }) : super(key: key);

  @override
  _AddLocationsState createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {
  final locCont = Get.put(LocationController());

  TextEditingController fullNameController = TextEditingController();
  final mapCon = Get.put(LocationController());
  String? add = '';
  var id;
    @override
  void initState() {
    super.initState();
    id = Get.arguments;
    
  }
  

// void setPermissions() async{
//    Map<PermissionGroup, PermissionStatus> permissions = 
//    await PermissionHandler().requestPermissions([PermissionGroup.location]);
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Stack(
          children: [
            Container(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(child: googleMap()),
                ],
              ),
            ),
          //  Padding(
          //    padding: const EdgeInsets.only(left:15.0,top:35),
          //    child: GestureDetector(
          //      child: Icon(Icons.arrow_back),
          //      onTap: (){
          //        Get.back();
          //      },),
          //  ),
          ],
          
        ),
      ),
    );
  }
Widget googleMap(){
  return Container(
    height: Get.height,
    child: PlacePicker(   
      apiKey: "AIzaSyCPLXiudqcih9E93EAmcB2Bs5MF-oxcO2g",
      initialPosition: LatLng(51.507351,-0.127758),
          useCurrentLocation: true,
          usePlaceDetailSearch: true,
          selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
            return isSearchBarFocused
            ? Container()
            // Use FloatingCard or just create your own Widget.
            : FloatingCard(
                bottomPosition: 5.5,    // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                height: 150,
                borderRadius: BorderRadius.circular(12.0),
                child: 
                // state == SearchingState.Searching ? 
                //                 Center(child: CircularProgressIndicator()) : 
                Column(
                  children: [
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: selectedPlace != null ? Text(selectedPlace.formattedAddress.toString()): Text('')
                    ),
                    SizedBox(height:15),
                    selectedPlace != null ?
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cancelButton(),
                        saveButton(selectedPlace)
                      ],
                    ): Container()
                  ],
                ),
              );
            },
    ),
  );
  //  Container(
  //   height: Get.height,
  //   child: GoogleMap(
  //     initialCameraPosition: CameraPosition(
  //       zoom: 15,
  //       target: LatLng(51.507351,-0.127758),
  //     ),
  //   ),
  // );
}
Widget saveButton(data) {
  // if(data != null) 
  var lnglat =  data!.geometry!.location;
  var splitLngLat = lnglat.toString().split(',');
  var lng = splitLngLat[0].replaceAll('(','');
  var lat = splitLngLat[1].replaceAll(')','');
  var s = data!.adrAddress.replaceAll('</span>','');
  var street = s.toString().replaceAll('<span class=','');
  final f = street.toString().replaceAll('>','');
   var strAdr;
   var city;
   var region;
   var postCode;
   var countryName;
   var sp = f.split(',');
   for(int i=0; i< sp.length; i++) {
     if(sp[i].contains('street-address')){
       strAdr = sp[i].replaceAll('"street-address"', '');
     }
     if(sp[i].contains('locality')){
       city = sp[i].replaceAll('"locality"', '');
      var spl = city.split('"');
      city = spl[0];
     }
     
     if(sp[i].contains('postal-code') && city != null){
       postCode = sp[i].replaceAll('"postal-code"', '');
       var pc;
       if(postCode.contains('"locality"')){
         pc = postCode.replaceAll('"locality"', '');
          if(pc.contains(city)){
            postCode = pc.replaceAll(city,'');
          }
       }
     }
     if(sp[i].contains('region')){
       var re;
       region = sp[i].replaceAll('"region"', '');
      //  if(postCode)
       if(region.contains('"postal-code"')) {
         re = region.replaceAll('"postal-code"',',');
         re = re.split(',');
          region = re[0];
          postCode = re[1];
       }
       
     }
     if(sp[i].contains('country-name')){
       countryName = sp[i].replaceAll('"country-name"', '');
     }
   
   }
  //  var streetAdr = 
    return Container(
       height: 50,
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.white,
        textStyle: TextStyle(
        fontSize: 13,
       
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          var jsonLoc = {
            "location":data.geometry!.location.toString(),
            "long":lng,
            "lat":lat,
            "formated_address":data!.formattedAddress,
            "place":data.placeId,
            "street_address":strAdr,
            "locality":city,
            "country_name" : countryName,
            "region" : region,
            "postal_code":postCode,
            "view_port":data.geometry!.viewport.toString(),
            "country_id":1,
            "city_id":1,
            "region_id":1,
          };
           id != null ? locCont.editLocationToDB(id,jsonLoc) :  locCont.saveLocationToDB(jsonLoc);
         },
        child: Text( id != null ? 'Update' : 'SAVE',style: TextStyle( color: Colors.blue,),),
      ),
    );
  
  }
  Widget cancelButton() {
    return Container(
       height: 50,
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        textStyle: TextStyle(
        fontSize: 13,
       
        fontWeight: FontWeight.bold)),
        onPressed: () { 
          Get.back();
         },
        child: Text('CANCEL',style: TextStyle( color: Colors.white,),),
      ),
    );
  }
}
  