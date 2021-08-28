import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/text_field.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({ Key? key }) : super(key: key);

  @override
  _AddLocationsState createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {
  final locCont = Get.put(LocationController());

  TextEditingController fullNameController = TextEditingController();
  String? add = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // bottomSheet: Container(
    //   height:Get.height/4.5,
    //   width: Get.width,
    //   decoration: BoxDecoration(
    //     color: Colors.blue,
    //     borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Center(
    //        child: Text("_________",style: TextStyle(color: Colors.white),)
    //       ),
    //       Container(
    //         child: Text(
    //           add.toString()
    //         ),
    //       ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('editlocation'.tr,style: TextStyle(color: Colors.white,fontSize: 20),),
          // ),
          // Padding( padding: const EdgeInsets.all(8.0),
          // child: Row(
          //   children: [
          //     Icon(Icons.gps_fixed,color: Colors.white,),
          //     SizedBox(width: 10,),
          //     Text('getCurrent'.tr,style: TextStyle(color: Colors.white,fontSize: 15),),
          //   ],
          // )),
          // SizedBox(height: 5,),
          //  Container(
          //   margin:EdgeInsets.symmetric(horizontal: 20),
          //   width: Get.width * 0.9,
          //   child: CustomTextFiled(
          //     isObscure: false,
          //     hintText: "street".tr,
          //     hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          //     hintColor: AppColors.inputTextColor,
          //     onChanged: (value) {  },
          //     onSaved: (String? newValue) { 

          //      }, 
          //     onFieldSubmitted: (value) {  }, 
          //     // isObscure: true,
          //     textController: fullNameController ,
          //     validator: (value) {  
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some text';
          //       }
          //     },
          //     errorText: 'Please Enter Full Name',  
          //   ),
          // ),
          // SizedBox(height: 5,),
          // Container(
          //   margin:EdgeInsets.symmetric(horizontal: 20),
          //   width: Get.width * 0.9,
          //   child: CustomTextFiled(
          //     isObscure: false,
          //     hintText: "city".tr,
          //     hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          //     hintColor: AppColors.inputTextColor,
          //     onChanged: (value) {  },
          //     onSaved: (String? newValue) {  }, 
          //     onFieldSubmitted: (value) {  }, 
          //     // isObscure: true,
          //     textController: fullNameController ,
          //     validator: (value) {  
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some text';
          //       }
          //     },
          //     errorText: 'Please Enter Full Name',  
          //   ),
          // ),
          // SizedBox(height: 5,),
          // Container(
          //   margin:EdgeInsets.symmetric(horizontal: 20),
          //   width: Get.width * 0.9,
          //   child: CustomTextFiled(
          //     isObscure: false,
          //     hintText: "district".tr,
          //     hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
          //     hintColor: AppColors.inputTextColor,
          //     onChanged: (value) {  },
          //     onSaved: (String? newValue) {  }, 
          //     onFieldSubmitted: (value) {  }, 
          //     // isObscure: true,
          //     textController: fullNameController ,
          //     validator: (value) {  
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some text';
          //       }
          //     },
          //     errorText: 'Please Enter Full Name',  
          //   ),
          // ),
      //     SizedBox(height: 10,),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         cancelButton(),
      //         saveButton()
      //       ],
      //     ),
      //      SizedBox(height: 10,),
      //   ],
      // ),
      //   ),
      body:Stack(
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
                      child: Text(selectedPlace!.formattedAddress.toString()),
                    ),
                    SizedBox(height:15),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cancelButton(),
                        saveButton(selectedPlace)
                      ],
                    ),
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
  var lnglat = data!.geometry!.location;
  var splitLngLat = lnglat.toString().split(',');
  var lng = splitLngLat[0].replaceAll('(','');
  var lat = splitLngLat[1].replaceAll(')','');
  print("............$lng----------111$lat");
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
    //  print("....PPPPPP......${sp[i]}");
     if(sp[i].contains('street-address')){
       strAdr = sp[i].replaceAll('"street-address"', '');
      //  print("....PPPPPP.....----.$strAdr");
     }
     if(sp[i].contains('locality')){
       city = sp[i].replaceAll('"locality"', '');
      //  print("....PPPPPP.....ccccc----.$city");
     }
     if(sp[i].contains('region')){
       region = sp[i].replaceAll('"region"', '');
      //  print("....PPPPPP..-----${sp[i]}...crrrrrr----.$region");
     }
     if(sp[i].contains('postal-code')){
       postCode = sp[i].replaceAll('"postal-code"', '');
      //  print("....PPPPPP.....cpppppp----.$postCode");
     }
     if(sp[i].contains('country-name')){
       countryName = sp[i].replaceAll('"country-name"', '');
      //  print("....PPPPPP.....cpppppp0000----.$countryName");
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
            "postal_code":postCode,
            "view_port":data.geometry!.viewport.toString(),
            "country_id":1,
            "city_id":1,
            "region_id":1,
          };
          locCont.saveLocationToDB(jsonLoc);
         },
        child: Text('SAVE',style: TextStyle( color: Colors.blue,),),
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