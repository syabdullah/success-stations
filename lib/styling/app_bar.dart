import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/controller/services_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:success_stations/view/friends/friend_filter.dart';

final mapCon = Get.put(LocationController());
final formKey = new GlobalKey<FormState>();
var dis,lat,long;
var city;
var currentPostion; 
var position;
var decideRouter;
var array = [] ;
var namearray = [] ;
var color = Colors.grey[100];
bool textfeild = true;
var selectedService;
var  service_id;
GetStorage box = GetStorage();
var cityArray = [];
var userId = box.read('user_id');
  void _getUserLocation() async {
    position  = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    // });
  }
  Widget appbar(GlobalKey<ScaffoldState> globalKey,context ,image,searchImage,index) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: Container(
        margin:EdgeInsets.only(top:2),
        child: 
        index == 1 ?
        IconButton(
          iconSize: 28,
          icon: Image.asset(AppImages.newfilter,color: Colors.white,),
          onPressed: () => Get.bottomSheet(FriendFilter()),
        )
        :
        IconButton(
          iconSize: 28,
          icon: Image.asset(AppImages.menuBurger,height: 20,),
          onPressed: () => globalKey.currentState!.openDrawer()
        ),
      ),
      title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ), 
      actions: [
        index == 4 ? 
        GestureDetector(
          onTap: index == 4 ?  () {
            filtrationModel(context);
          } : null,
          child: Padding(
            padding: const EdgeInsets.only(top:12.0,right: 10,),
            // child: Image.asset("
            //  AppImages.appBarSearch",color: Colors.white,width: 25.w,
            // ),
            child: Image.asset(
             AppImages.appBarSearch,color: Colors.white,width: 25.w,
            ),
          ),
        ): Container()
        
      ],
      
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

Widget sAppbar(context ,icon,image,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
      // Padding(
        // padding: const EdgeInsets.only(top:10.0),
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: IconButton(
            icon: Icon(icon,
            color: AppColors.backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      //
      //  ),
    title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ),
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }

Widget newAppbar(context ,text,image,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      // centerTitle: true,
      leading: 
      // Padding(
        // padding: const EdgeInsets.only(top:10.0),
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: GestureDetector(
            onTap: (){Get.back();},
            child: Container(
              padding: EdgeInsets.only(left:15,right: 5),
              child: Text(
               text,textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.underline,fontSize: 16),
               
              ),
            ),
          ),
        ),
      //
      //  ),
    title: Padding(
       padding: const EdgeInsets.only(top:10.0),
        child: Image.asset(image, height: 40),
      ),
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  Widget stringAppbars(context ,icon,string) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
        Container(
          margin: EdgeInsets.only(top:5),
          child: IconButton(
            icon: Icon(icon,
            color: AppColors.backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      //
      //  ),
      title: Container(
        margin: EdgeInsets.only(top:10),
        child: Center(
          child: Text(
            string
          )
        ),
      ), 
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  Widget stringAppbar(context ,icon,string ,searchImage,) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading: 
        Container(
          margin: EdgeInsets.only(top:5),
          child: IconButton(
            icon: Icon(icon,
            color: AppColors.backArrow),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      //
      //  ),
      title: Container(
        margin: EdgeInsets.only(top:10),
        child: Center(
          child: Text(
            string
          )
        ),
      ), 
      actions: [
        string != 'choose_language_drop'.tr ?
        Padding(
          padding: const EdgeInsets.only(right: 10,),
          child:  Image.asset(
           AppImages.appBarSearch,color: Colors.white,width: 25.w,
          ),
        ): Container()
      ],
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
  Widget stringbar(context, string) {
    return AppBar(
      // automaticallyImplyLeading: false,
      centerTitle: true,
      leading:
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp,
          color: AppColors.backArrow),
         onPressed: () => Get.back()
        ),
      title: Text(string), 
      
      backgroundColor: AppColors.appBarBackGroundColor,
    );
  }
    RangeValues _currentRangeValues = const RangeValues(5, 500);
    var start;
  var end;
  var locationName;
  var service;
  filtrationModel(context) async {
    var size = MediaQuery.of(context).size;
   showModalBottomSheet(  
     isScrollControlled: true,
     context: context,   
     shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
        ),
      ),
      backgroundColor: Colors.white,
       builder:(BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          return Wrap(
            children: [
              Container(
                height: Get.height/1.6,
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left:30),
                                  child: Text('filter'.tr,
                                    style: TextStyle(
                                      fontSize: 20, color: Colors.black
                                    )
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(right:20),
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close)
                                  )
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                               color: color,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            width: Get.width/4,
                           padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(top: 20,left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(Icons.location_on,color:AppColors.appBarBackGroundColor),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState((){
                                      color = Colors.blue[100];
                                      textfeild = !textfeild;
                                    });
                                     _getUserLocation();
                                  },
                                  child: Container(
                                    child: Text("Nearby".tr,style: TextStyle(color: AppColors.appBarBackGroundColor)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        enabled: textfeild,
                                        labelText: ('city'.tr),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                        )
                                      ),
                                      onTap: (){
                                        // setState((){
                                          
                                        // });
                                      },
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
                                   Container(
                                     margin: EdgeInsets.only(top: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        enabled: textfeild,
                                        labelText: ('locationName'.tr),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                        )
                                      ),
                                      onTap: (){
                                      },
                                      onSubmitted: (val) {
                                        formKey.currentState!.save();
                                        setState((){
                                          decideRouter = 'name';
                                          namearray.add(val);
                                          cityArray.length == 0  ?
                                          locationName = 'name=$val':
                                          locationName  = '&name=$val';
                                        });                        
                                      },
                                    ),
                                  ),
                                  GetBuilder<ServicesController>( // specify type as Controller
                                    init: ServicesController(), // 
                                    builder: (value) {
                                      return Container(
                                        margin: EdgeInsets.only(top:10),
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
                                                  selectedService != null ? selectedService : 'selectService'.tr, 
                                                  style: TextStyle(fontSize: 13, color: AppColors.inputTextColor)
                                                ),
                                                dropdownColor: AppColors.inPutFieldColor,
                                                icon: Icon(Icons.arrow_drop_down),
                                                items: value.servicesListdata.map((coun) {
                                                  return DropdownMenuItem(
                                                    value: coun,
                                                    child:Text(coun['servics_name'])
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  var adsubCategory;
                                                  setState(() {
                                                    decideRouter = 'name';
                                                    adsubCategory = val as Map;
                                                    selectedService = adsubCategory['servics_name'];
                                                    service_id = adsubCategory['id'];
                                                    locationName != null  ?
                                                    locationName = '$locationName&service_id=$service_id':
                                                    locationName = 'service_id=$service_id';
                                                  });
                                                },
                                              )
                                            ),
                                          )
                                        )
                                      );
                                    }
                                  ),
                                ],
                              ),
                            )
                          ),
                          // Container(
                          //   height: 50,
                          //   child: ListView(
                          //     scrollDirection: Axis.horizontal,
                          //     children: [
                          //   for(var item in array) 
                          //   GestureDetector(
                          //     onTap: () {
                          //       setState((){
                          //         decideRouter = 'nearby';
                          //       });
                          //     },
                          //     child: Container(                          
                          //       decoration: BoxDecoration(
                          //          color: Colors.blue[100],
                          //         borderRadius: BorderRadius.circular(20)
                          //       ),
                          //       // width: Get.width/4,
                          //      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          //       margin: EdgeInsets.only(top: 10,left: 30),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [                             
                          //           Container(
                          //             child: Text(item,style: TextStyle(color: AppColors.appBarBackGroundColor)),
                          //           ),
                          //           GestureDetector(
                          //             onTap: (){
                          //               setState((){
                          //                   var ind = 1;
                          //                   ind = array.indexOf(item);
                          //                    array.remove(item);
                          //                   cityArray.removeAt(ind);
                                           
                          //               });                              
                          //             },
                          //             child: Container(
                          //               child: Icon(Icons.clear,color: AppColors.appBarBackGroundColor,size:15),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          //     ]
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Distance',style:  TextStyle(fontSize: 20, color: Colors.black,)
                              ),
                          ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                              "${_currentRangeValues.start.round().toString()} miles",style:  TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal)
                              ),
                            ),
                          Container(
                            child: RangeSlider(
                              activeColor: AppColors.appBarBackGroundColor,
                              values: _currentRangeValues,
                              min: 5.00,
                              max: 500.00,
                              // divisions: 5,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (values) {
                                setState(() {
                                  _currentRangeValues = values;
                                    start = _currentRangeValues.start.round().toString();
                                    end = _currentRangeValues.end.round().toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 20),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.grey[100],
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(
                                      child: Text('reset'.tr,
                                        style: TextStyle(
                                          color: AppColors.inputTextColor
                                            )
                                          )
                                        )
                                      ),
                                  onPressed: () {
                                    array.clear();
                                    cityArray.clear();
                                    locationName = null;
                                    Get.back();
                                    Get.find<LocationController>().getAllLocationToDB();
                                    // Get.to(SignIn());
                                  }
                                ),
                              ),
                              Container(
                                child: RaisedButton(
                                  color:AppColors.appBarBackGroundColor,
                                  child: Container(
                                    width: Get.width / 4,
                                    child: Center(
                                      child: Text("apply".tr,
                                        style: TextStyle( color: Colors.white)
                                      )
                                    )
                                  ),
                                  onPressed: (){
                                    var cityFinalData;
                                    if(decideRouter == 'city' || decideRouter == 'name' ) {
                                      print("==/=/==/=/==//=====---------$locationName");
                                      if(cityArray.length != 0) {
                                        var cityFinal = cityArray.toString();
                                        cityFinalData = cityFinal.substring(1, cityFinal.length - 1);
                                      }else {
                                        cityFinalData = null;
                                      }
                                      Get.find<LocationController>().getAllLocationByCity(cityFinalData,locationName);
                                    }else if(decideRouter == 'near'){
                                      Get.find<LocationController>().getAllLocationNearBy(end, position.latitude, position.longitude);
                                    }
                                   Get.back();
                                  },
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]
          );
          });
   
       }
   );
  }