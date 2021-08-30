import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:success_stations/controller/last_location_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({ Key? key }) : super(key: key);

  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
   TextEditingController textEditingController = TextEditingController();
    RangeValues _currentRangeValues = const RangeValues(1,100);
       final lastLoc = Get.put(LastLocationController());
        var id;

    void initState() {
    id = Get.arguments;
    print(id);
    lastLoc.userlocationList(id);
    print(id);
    super.initState();
  }   
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filter(),
             GetBuilder<LastLocationController>( // specify type as Controller
                  init: LastLocationController(), // intialize with the Controller
                  builder: (value){ 
                    print(value.lastLocation);
                    return value.isLoading == true ? Center(child: CircularProgressIndicator()):
                    value.lastLocation !=null &&   value.lastLocation['success']== true ?
                     locationList(value.lastLocation['data'])
                     :lastLoc.resultInvalid.isTrue && value.lastLocation['success'] == false?
                     Container(
                       child:Text(lastLoc.lastLocation['errors'])):Container();
                    
                  }
                    ),
           
          ],
          ),
        ],
      ),
    );
  }
  


  void _showModal() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor:Colors.white,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
        return  AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
          child: Container(
            //  height:Get.height/2,
            child: Container(
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
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left:10),
                        child: Row(
                          children: [
                            Image.asset(AppImages.nearby,height: 15,color:Colors.blue),
                            SizedBox(width: 5,),
                            Text(
                              "Nearby".tr,style:  TextStyle(fontSize: 15, color: Colors.blue)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'city'.tr,  
                       prefixIcon: Icon(Icons.search),
                      // hintText: 'Enter Your Name',  
                    ),  
                  ),  
                  SizedBox(height: 10),
                  FittedBox(
                    child: Container(
                      
                      height: 30,
                      // width: Get.width/4.5,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(left:5),
                          child: Row(
                            children: [
                              Text(
                                "Lahore",softWrap: true,
                                style:  TextStyle(fontSize: 15, color: Colors.blue)
                              ),
                              Container(
                                // height: 4,
                                child: Icon(Icons.close,color: Colors.blue,size: 15,))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'distance.tr',style:  TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold)
                    ),
                    Text(
                    "10 miles",style:  TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.normal)
                    ),
                    RangeSlider(
                      values: _currentRangeValues,
                      min: 1,
                      max: 100,
                      // divisions: 5,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          print("start : ${values.start}, end: ${values.end}");
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
                            child: Center(child: Text('reset'.tr, style: TextStyle(color: AppColors.inputTextColor )))
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                            // Get.to(SignIn());
                          }
                        ),
                        
                      ),
                      Container(
                        margin: EdgeInsets.only(top:20),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Container(
                            width: Get.width / 4,
                            child: Center(child: Text("apply".tr, style: TextStyle(color:Colors.white)))
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                            // Get.to(SignIn());
                          }
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
    }
  );
  }
 );
  
}
  
  Widget filter(){
  return InkWell(
    onTap: (){_showModal();},
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[300],
      ),
      width: Get.width/5,
      
      margin: EdgeInsets.only(left:10),
      padding: const EdgeInsets.all(8.0),
      child: Row(
       children: [ 
         InkWell(
            onTap: (){_showModal();},
           child: Image.asset(AppImages.filter,height: 15,)),
         SizedBox(width: 5),
         InkWell(
            onTap: (){_showModal();},
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
    // double c_width = MediaQuery.of(context).size.width*0.8;
    return Container(
      height: Get.height,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: lastLocation['data'].length,
        // ignore: non_constant_identifier_names
        itemBuilder: (BuildContext,index) {
        
          print("${lastLocation['data'][index]['location']}");
          return Card(
            child: Container(
              height: 100,
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
                              child: ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                child:Image.asset(AppImages.location,color: Colors.blue,),
                              ),
                            ),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                              
                                 lastLocation['data'][index]['location'] != null ?
                               Text(lastLocation['data'][index]['location'],overflow: TextOverflow.clip,maxLines: 6,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                             ): Container(),
                              ],
                            ),
                            SizedBox(height: 3),
                             lastLocation['data'][index]['formated_address'] != null ?
                               Container(
                                 width: Get.width/2,
                                 child: Text(lastLocation['data'][index]['formated_address'],textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                                                          ),
                               )
                              : Container()
                            ,Row(
                              children: [
                                lastLocation['data'][index]['locality'] !=null?
                              Text(lastLocation['data'][index]['locality'],
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 8),
                              ): Container(),
                              SizedBox(width: 3,),
                               lastLocation['data'][index]['country_name'] != null ?
                              Text(lastLocation['data'][index]["country_name"],
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                              ): Container(),
                              ],
                            ),
                            SizedBox(height: 8),
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20),
                 
                  
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: 
                  //       CircleAvatar(
                  //         backgroundColor: Colors.grey[200],
                  //         child: Icon(Icons.person)
                  //         ) 
                  //     ),
                  //     Row(
                  //       children: [
                  //         Container(
                  //           padding: EdgeInsets.only(right:5),
                  //           child: Image.asset(AppImages.blueHeart, height: 20)
                  //         ),
                  //         Image.asset(AppImages.call, height: 20),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            );
          },
      ),
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

