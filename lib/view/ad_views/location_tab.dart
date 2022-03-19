import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/google_map/add_locations.dart';

import '../../main.dart';
import '../shimmer.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({ Key? key }) : super(key: key);

  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
   TextEditingController textEditingController = TextEditingController();
    RangeValues _currentRangeValues = const RangeValues(5,500);
    final formKey = new GlobalKey<FormState>();
      final lastLoc = Get.put(LocationController());
      var id;
      var dis,lat,long;
      var city;
      var currentPostion;
      var position;
      var decideRouter;
      var cityArray = [] ;
      var array = [] ;
      var userId;
      var end;
     bool textfeild = true;
     var color = Colors.grey[100];
      GetStorage box = GetStorage();
      void initState() {
         _getUserLocation();
          userId = box.read('user_id');
        id = Get.arguments;
        lastLoc.userlocationList(id);
        super.initState();
      }   
  void _getUserLocation() async {
    position  = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    // });
  }

  @override
  Widget build(BuildContext context) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      filter(),
        GetBuilder<LocationController>( 
          init: LocationController(), 
          builder: (value){ 
            return value.lastLocation !=null &&  value.lastLocation['data']!=null   ?
            myAddsList(value.lastLocation['data']):
             Center(
              heightFactor: 15,
                child: Text( "noLoaction".tr, 
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color:AppColors.black)
              )
            );
           
          }
        ),
      ],
    );
  }
  
  void _showModal() {
     _getUserLocation();
    showModalBottomSheet(
      context: context,
      backgroundColor:Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
      ),
      builder: (context) {
        
        return FractionallySizedBox(
          child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
            
          return  Wrap(
            children: [
              Container(
                 height:Get.height/1.6,
                child: ListView(
                  children: [
                    Container(
                      
                      margin:EdgeInsets.only(top: 20, left: 40,right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[   
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'filter'.tr ,style:  TextStyle(fontSize: 20, color: Colors.black)
                              ),
                              Container(
                                // margin:EdgeInsets.only(right:30),
                                child: InkWell(
                                  onTap:()=> Get.back(),
                                  child: Icon(Icons.close))
                              )
                            ],
                          ),
                          SizedBox(height:10),
                          Container(
                            height: 30,
                            width: Get.width/4,
                            decoration: BoxDecoration(
                              color:color,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: GestureDetector(
                              onTap: decideRouter == 'city' ? null :  () {
                                setState((){
                                  decideRouter = 'near';
                                  color = AppColors.whitedColor;
                                }); 
                              },
                              child: Container(
                                margin: EdgeInsets.only(left:10),
                                child: Row(
                                  children: [
                                    Image.asset(AppImages.nearby,height: 15,color:AppColors.whitedColor),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Nearby".tr,style:  TextStyle(fontSize: 15, color: AppColors.whitedColor)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 15,),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Form(
                                key: formKey,
                                child: Container(
                            //       padding: EdgeInsets.only(
                            // bottom: MediaQuery.of(context).viewInsets),
                                  child: TextField(
                                     enabled: textfeild,
                                    decoration: InputDecoration(
                                      labelText: ('City'),
                                      labelStyle: TextStyle(color: AppColors.whitedColor),
                                      // labelStyle: TextStyle(color: AppColors.basicColor),
                                      prefixIcon: Icon(Icons.search,color: AppColors.whitedColor,),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.whitedColor)
                                      )
                                    ),
                                    onSubmitted: (val) {
                                       formKey.currentState!.save();
                                      setState((){
                                        decideRouter = 'city';
                                        array.add(val);
                                        cityArray.add('city[]=$val');
                                      });                          
                                    },
                                  ),
                                ),
                              )
                            ), 
                          Container(
                              // height: 50,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                              for(var item in array) 
                              GestureDetector(
                                onTap: () {
                                  setState((){
                                    decideRouter = 'nearby';
                                  });
                                },
                                child: Container(                          
                                  decoration: BoxDecoration(
                                     color: AppColors.whitedColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  // width: Get.width/4,
                                 padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  margin: EdgeInsets.only(left: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [                             
                                      Container(
                                        child: Text(item,style: TextStyle(color: AppColors.whitedColor)),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            var ind = 1;
                                            ind = array.indexOf(item);
                                             array.remove(item);
                                            cityArray.removeAt(ind);
                                            
                                          });
                                        },
                                        child: Container(
                                          child: Icon(Icons.clear,color: AppColors.whitedColor,size:15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                                ]
                              ),
                            ),
                          // SizedBox(height: 20),
                          Text(
                            'Distance',style:  TextStyle(fontSize: 20, color: Colors.black)
                            ),
                            Text(
                            "${_currentRangeValues.start.round().toString()} miles",style:  TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal)
                            ),
                             SizedBox(height: 10),
                            RangeSlider(
                              activeColor: AppColors.whitedColor,
                              values: _currentRangeValues,
                              min: 5,
                              max: 500,
                              // divisions: 5,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (values) {
                                setState(() {
                                  end = values.start;
                                  _currentRangeValues = values;
                                });
                              },
                            ),
                            
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top:20),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.grey[100],
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(child: Text('reset'.tr, style: TextStyle(color: AppColors.whitedColor )))
                                  ),
                                  onPressed: () {
                                    array.clear();
                                    cityArray.clear();
                                     Get.back();
                                    lastLoc.userlocationList(id);
                                  }
                                ),                        
                              ),
                              Container(
                                margin: EdgeInsets.only(top:20),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: AppColors.whitedColor,
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(child: Text("apply".tr, style: TextStyle(color:Colors.white)))
                                  ),
                                  onPressed: () {
                                   if(decideRouter == 'city') {
                                     var cityFinal = cityArray.toString();
                                     var cityFinalData = cityFinal.substring(1, cityFinal.length - 1);
                                        lastLoc.getUSerLocationByCity(cityFinalData,id);
                                  }else if(decideRouter == 'near'){
                                         lastLoc.getUserLocationNearBy(id,end, position.latitude, position.longitude);
                                        //  Get.to(CustomInfoWindowExample(),arguments: [decideRouter,end, position.latitude, position.longitude]);
                                      }
                                     Get.back();
                                  }
                                ),
                              ),
                            ],
                          )
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
  
}
  
  Widget filter(){
  return GestureDetector(
    
    onTap: (){
      setState(() {
        _showModal();
        print("hehe");
      });
    },
      
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[300],
      ),
      width: lang=='ar' ?Get.width/4:Get.width/5,
      
      margin: EdgeInsets.only(left:10),
      padding: const EdgeInsets.all(8.0),
      child: Row(
       children: [ 
         GestureDetector(
             onTap: (){
            setState(() {
              _showModal();
              print("hehe");
            });
          },
           child: Image.asset(AppImages.filter,height: 15,)),
         SizedBox(width: 5),
         GestureDetector(
                      onTap: (){
              setState(() {
                print("hehe");
                _showModal();
              });
            },
           child: Text('filter'.tr,
             style: AppTextStyles.appTextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color:AppColors.darkgrey
            )
           ),
         )
         ],
      ),
    ),
  );
}

}

Widget locationList(lastLocation) {
  print("length of the ....${lastLocation.length}");
    return  Container(
      height:Get.height/1.7,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
         padding: EdgeInsets.only(bottom: 1),
         itemCount: lastLocation.length,
         itemBuilder: (BuildContext context ,index) {
         
          return Card(
             child: Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       Center(
                         child: Container(
                           color: Colors.grey[100],
                           width: Get.width/3.6,
                           child: Padding(
                             padding:
                             const EdgeInsets.all(10.0),
                             child: GestureDetector(
                               child:lastLocation[index]['image'] !=null&&  lastLocation[index]['image']['url']!= null ?
                               ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                                 child: Container(
                                   height: Get.height/7.5,
                                   child: lastLocation[index]['image']['url'] !=null ?
                                   Image.network(lastLocation[index]['image']['url'], fit: BoxFit.cover,): Container()
                                 ),
                               ): Container(
                                   child: Image.asset(AppImages.location,height: 117,),
                               ),
                                         ),
                           )
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:.0,left: 10),
                         child: Column(
                           crossAxisAlignment:CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                            
                              lastLocation[index]['location'] != null ?
                                Container(
                                  width: Get.width/1.5,
                                  child: Text(lastLocation[index]['location'],textAlign: TextAlign.left,
                                     style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),
                                   ),
                                )
                               : Container(),
                                lastLocation[index]['formated_address'] != null ?
                                Container(
                                  width: Get.width/1.5,
                                  child: Text(lastLocation[index]['formated_address'],textAlign: TextAlign.left,
                                     style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),
                                   ),
                                )
                               : Container(),
                                SizedBox(height: 4),
                             Row(
                               children: [
                                 Text("services".tr,style: TextStyle(fontSize:14,color:AppColors.whitedColor)),
                                 lastLocation[index]['services'] !=null ?
                               Text(": ${lastLocation[index]['services']['servics_name']}",
                               style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),
                               ): Container(),
                               SizedBox(width: 3,),
                              
                               ],
                             ),
                             SizedBox(height: 4),
                                lastLocation[index]['country_name']!= null ? 
                           Row(
                             children: [
                               Container(
                                 child: Text(
                                   "country".tr,
                                   style: TextStyle(fontSize:14,color:AppColors.whitedColor)
                                 ),
                               ),
                               Container(
                                 width: Get.width / 3.3,
                                 child: Text(
                                   ": ${lastLocation[index]['country_name']}",
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 12
                                   ),
                                 ),
                               )
                             ],
                           ): Container()
                           ],
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height:20),
                 
                 ],
               ),
             ),
             );
           },
       ),
    );
  }
Widget myAddsList(lastLocation) {
  return ListView.builder(
    // padding: EdgeInsets.only(left:10),
    itemCount: lastLocation.length,
    // data != null ? data.length : 0,
    itemBuilder: (BuildContext context, index) {
      print("sanket" + lastLocation[index]['formated_address']);
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: lang == "ar"
                              ? EdgeInsets.only(top: 3, bottom: 3, right: 3)
                              : EdgeInsets.only(
                              top: 3, bottom: 3, left: 3, right: 0),
                          child: Center(
                            child: Container(
                              child: GestureDetector(
                                  child: lastLocation[index]['image'] != null &&
                                      lastLocation[index]['image']['url'] != null
                                      ? Image.network(
                                    lastLocation[index]['image']['url'],
                                    width: Get.width / 4.4,
                                    height: Get.height * 0.08,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                      child: Image.asset(AppImages.locationimg),
                                      width: Get.width / 6)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: lang == "ar"
                              ? EdgeInsets.only(right: Get.width * 0.04)
                              : EdgeInsets.only(left: Get.width * 0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: lang == "ar"
                                    ? EdgeInsets.only(
                                    right: Get.width * 0.01,
                                    top: Get.width * 0.01)
                                    : EdgeInsets.only(
                                    left: Get.width * 0.01,
                                    top: Get.width * 0.01),
                                child: Container(
                                    child: Text(
                                      lastLocation[index]['location'],
                                      style: TextStyle(
                                          fontFamily: "Source_Sans_Pro",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                              SizedBox(height: Get.height * 0.005),
                              Container(
                                width: Get.width/2,
                                child: ReadMoreText(
                                  lastLocation[index]['formated_address'] != null
                                      ? lastLocation[index]['formated_address']
                                      : '',
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show More',

                                  trimExpandedText: 'Show less',
                                  textAlign: TextAlign.left,
                                  colorClickableText:
                                  AppColors.whitedColor,
                                  style: TextStyle(
                                      fontFamily: "Source_Sans_Pro",
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )));
    },
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

