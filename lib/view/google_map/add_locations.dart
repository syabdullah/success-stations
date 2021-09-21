import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:success_stations/controller/ad_posting_controller.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:dio/dio.dart' as dio;
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/utils/app_headers.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({ Key? key }) : super(key: key);

  @override
  _AddLocationsState createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {
  final locCont = Get.put(LocationController());
  TextEditingController fullNameController = TextEditingController();
  final mapCon = Get.put(LocationController());
  final formKey = new GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late LatLng _latLng = LatLng(51.5160322, 51.516032199999984);
  XFile? pickedFile;
  late String image;
  var editImage;
  var fileName;
  String? add = '';
  var uploadedImage;
  var id;
  var position;
    @override
  void initState() {
    super.initState();   
    _modalBottomSheetMenu();
    id = Get.arguments;
    
  }
   _getUserLocation() async {
    position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latLng = LatLng(position.latitude, position.longitude);
      print("///.............-------.............>$_latLng");
    });
  }
 Future getImage() async {
    await ApiHeaders().getData();
   pickedFile =   await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;      
        fileName = pickedFile!.path.split('/').last;  
      } else {
        // print('No image selected.');
      }
    });
    try {
      dio.FormData formData = dio.FormData.fromMap({          
        "file": await dio.MultipartFile.fromFile(pickedFile!.path, filename:fileName),            
      });
      Get.find<AdPostingController>().uploadAdImage(formData);      
       uploadedImage  = Get.find<AdPostingController>().adUpload['name'];
    } catch (e) {
    }
     
  }
  @override
  Widget build(BuildContext context) {
    //  _showModal();
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
      initialPosition: _latLng,
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
          fontWeight: FontWeight.bold)
        ),
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
  void _modalBottomSheetMenu() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        context: context,
        builder: (builder) {
          return FractionallySizedBox(
            child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {             
            return
              Wrap(
              children: [
                Container(
                  height:Get.height/1.6,
                  child: ListView(
                    children: [
                      Container(                      
                        margin:EdgeInsets.only(top: 20, left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[   
                            Text(
                              'Add new location'.tr ,style:  TextStyle(fontSize: 20, color: AppColors.appBarBackGroundColor)
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap:() {
                                      print("../././..........");
                                      _getUserLocation();
                                    }, 
                                    child: Icon(Icons.location_disabled_outlined,color: AppColors.appBarBackGroundColor,)
                                  )
                                ),
                                Text(
                                  'Get current Location'.tr ,style:  TextStyle(fontSize: 20, color: AppColors.appBarBackGroundColor)
                                ),
                                
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Form(
                                key: formKey,
                                child: Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: ('Location Name'),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                      )
                                    ),
                                    onSubmitted: (val) {
                                      formKey.currentState!.save();                          
                                    },
                                  ),
                                ),
                              )
                            ), 
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0) //                 <--- border radius here
                                  ),
                              ),
                              child:  ButtonTheme(
                                alignedDropdown: true,
                                child: Container(
                                  width: Get.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text(
                                        // selectedtype != null ? selectedtype : 'type'.tr, 
                                        '',
                                        style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                                      ),
                                      dropdownColor: AppColors.inPutFieldColor,
                                      icon: Icon(Icons.arrow_drop_down),
                                      items: ['a','a','a'].map((coun) {
                                        // print(".//./././././.....$coun");
                                        return DropdownMenuItem(
                                          value: coun,
                                          child:Text(coun)
                                        );
                                      }).toList(),
                                        onChanged: (val) {
                                        var adsubCategory;
                                        setState(() {
                                          adsubCategory = val as Map;
                                          // selectedtype = adsubCategory['type'][lang];
                                          // print(selectedtype);
                                          //  typeId =adsubCategory['id'];
                                          //  print(typeId);
                                          
                                        });
                                      },
                                    )
                                  ),
                                )
                              )
                            ), 
                            Container(
                              margin: EdgeInsets.only(top:10),
                              child: DottedBorder(
                                dashPattern: [10,6],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    height: Get.height/7.0,
                                    width: Get.width/1.1,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: fileName != null ? Image.file(File(image),fit: BoxFit.fitWidth,width: Get.width/1.1,height: Get.height/4.7,):  editImage != null ? Image.network(editImage,fit: BoxFit.fill,width: Get.width/1.1,height: Get.height/4.7,) : Image.asset(AppImages.uploadImage,height: 90,)),
                                    ),
                                  ),
                                ),
                              ),
                            ),                        
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      );
        }
      );
    });
  }
  
}
  