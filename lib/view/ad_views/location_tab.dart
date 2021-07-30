import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_field.dart';
import 'package:success_stations/styling/text_style.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({ Key? key }) : super(key: key);

  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
   TextEditingController textEditingController = TextEditingController();
    RangeValues _currentRangeValues = const RangeValues(1,100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filter(),
          locationList(),
        ],
      )
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor:Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
        return  Container(
          // height: MediaQuery.of(context).size.height * 0.50,
          child: Container(
            margin:EdgeInsets.only(top: 20, left: 40,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[   
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.filters ,style:  TextStyle(fontSize: 20, color: Colors.black)
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
                            "Nearby ",style:  TextStyle(fontSize: 15, color: Colors.blue)
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
                    labelText: 'City',  
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
                  "Distance ",style:  TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold)
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
                          child: Center(child: Text(AppString.resetButton, style: TextStyle(color: AppColors.inputTextColor )))
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
                          child: Center(child: Text("Apply", style: TextStyle(color:Colors.white)))
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
        );
    }
        );}
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
           child: Text(AppString.filter,
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
void bye(){
  
}
}

Widget locationList() {
    return Container(
      height: Get.height,
      child: ListView.builder(
        itemCount: 10,
        // ignore: non_constant_identifier_names
        itemBuilder: (BuildContext,index) {
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
                                child: Image.asset(
                                  AppImages.profileBg
                                ),
                              ),
                            ),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Text(
                                  '(567)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight:FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Text("Zealot Utopia",
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20),
                  PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (int item) => handleClick(item),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Text('Logout')),
                      PopupMenuItem<int>(value: 1, child: Text('Settings')),
                    ],
                  ),
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

