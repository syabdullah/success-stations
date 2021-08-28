import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/location_controller.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/google_map/add_locations.dart';

class MyLocations extends StatefulWidget {
  const MyLocations({ Key? key }) : super(key: key);

  @override
  _MyLocationsState createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final locationCon = Get.put(LocationController());
    GetStorage box = GetStorage();
    var id;
  @override
  void initState() {
    super.initState();
     id = box.read('user_id');
    locationCon.getMyLocationToDB(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      backgroundColor:Colors.blue,title: Text('MY LOCATION'),centerTitle: true,
      leading: IconButton(onPressed: () => _scaffoldKey.currentState!.openDrawer(), icon: Icon(Icons.arrow_back_ios)),
    ),  
    
    drawer: Theme(
        data: Theme.of(context).copyWith(
        ),
        child: AppDrawer(),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                  Container(
                     margin: EdgeInsets.only(left:10),
                    height: 70,
                    child: GestureDetector(
                      onTap:(){
                        Get.to(AddLocations());
                      },
                      child: Row(
                        children: [
                          Container(
                            margin:EdgeInsets.only(left:20, top: 30),
                            child: Image.asset(AppImages.plusImage, height:24)
                          ),
                          SizedBox(width:10),
                          Container(
                            margin:EdgeInsets.only(left:20, top: 30),
                            child: Text("addNewLocation".tr)
                          )
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<LocationController>(
                    init: LocationController(),
                    builder:(val) { 
                      return val.locData != null &&  val.locData['data'].length != 0  ?  Expanded(
                        child: myAddsList(val.locData['data'])): Container(
                          child: Center(child: Text("No Location added yet!",style: TextStyle(fontWeight: FontWeight.bold),)),
                        );
                    }
                  )
              ],
            )),
        ],
      ),
    );
  }
  
   Widget myAddsList(data) {
     print("......................-----..$data");
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: data != null ?  data.length:0,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Card(
          child: Container(
            // height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        child: Padding(
                          padding:
                          const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: data[index]['user_name']['media'].length != 0 ?
                            Image.network(data[index]['user_name']['media'][0]['url'],height: 60,) :
                            Container(
                              child: Image.asset(AppImages.location),
                              width: Get.width/6)

                            //  Image.asset(
                            //   AppImages.profileBg
                            // ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['user_name']['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight:FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 7),
                          Container(
                            width: Get.width/3.0,
                            child: 
                                // Image.asset(AppImages.location, height:15),
                                ReadMoreText(data[index]['formated_address'] != null ? data[index]['formated_address']:'',
                                trimLines: 2,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[400],
                                  ),
                                ),
                            //   ],
                            // ),
                          ),
                          // SizedBox(height: 8),
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Image.asset(AppImages.location, height:15),
                          //       Text(
                          //         "Al-Hajri",
                          //         style: TextStyle(
                          //           color: Colors.grey[300]
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          locationCon.deleteLocationToDB(data[index]['id'],id);
                        },
                        child: Container(
                          padding: EdgeInsets.only(right:5),
                          child: Image.asset(AppImages.delete, height: 30)
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(AddLocations(),arguments:data[index]['id']);
                        },
                        child: Container(
                          child: Image.asset(AppImages.edit, height: 30))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          );
        },
    );
  }
}
