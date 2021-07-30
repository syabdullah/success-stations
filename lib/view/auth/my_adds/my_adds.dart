import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/view/drawer_screen.dart';

class MyAdds extends StatefulWidget {
  _MyAddsState createState() => _MyAddsState();
}
class _MyAddsState extends State<MyAdds> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> litems = ['Categoryt A', 'Categoryt 1', 'Categoryt 2','Categoryt 3', 'Categoryt 4', 'Categoryt 5'];
  var listtype = 'list';
  bool _value = false;
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch),
       ),
       drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child: AppDrawer(),
      ),
      body: Column(
        children: [
          topWidget(),
            headingUpsell(),
          Expanded(
            child: listtype == 'list' ? myAddsList() : myAddGridView()
          ),
        ],
      ),
    );
  }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left:10),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15) ,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Image.asset(AppImages.filter,height: 15),
                  SizedBox(width:5),
                  Text( 
                    "Filter",style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:10),
              child: Image.asset(AppImages.plusImage, height:24)
            )
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  listtype = 'grid';
                  listIconColor = Colors.grey;
                  grid = AppImages.grid;
                });             
              },
              icon: 
              // Container(
                // height: 100,
                Image.asset(grid),
            ),
            Container(
              margin: EdgeInsets.only(bottom:15),
              child: IconButton(
                onPressed: (){
                  setState(() {
                    listtype = 'list';
                    listIconColor = AppColors.appBarBackGroundColor;
                    grid = AppImages.gridOf;
                  });
                },
                icon: Container(
                  padding:  EdgeInsets.only(top:10),
                  child: Image.asset(AppImages.listing, color: listIconColor,height: 20)
                )
              ),
            ),
            SizedBox(height: 30,width: 15,)
          ],
        )
      ],
    );
  }

  Widget myAddsList() {
    return ListView.builder(
      itemCount: 10,
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
                            child: Image.asset(
                              AppImages.profileBg
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
                          Text(
                            'Title number 1',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight:FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 7),
                          Row(
                            children: [
                              Image.asset(AppImages.location, height:15),
                              Text("Jaddah",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(AppImages.location, height:15),
                                Text(
                                  "Al-Hajri",
                                  style: TextStyle(
                                    color: Colors.grey[300]
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: 
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.person)
                        ) 
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right:5),
                          child: Image.asset(AppImages.blueHeart, height: 20)
                        ),
                        Image.asset(AppImages.call, height: 20),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          );
        },
    );
  }

  myAddGridView() {
    return Container(
       width: Get.width / 1.10,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return
          //  Expanded(
            Container(
              width: Get.width < 420 ? Get.width / 7.0 : Get.width /7,
              margin: EdgeInsets.only(left:15),
              // height: Get.height < 420 ? Get.height/3.6: Get.height/8.2,
                  child:  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          child: Container(
                            width: Get.width < 420 ? Get.width/1.4: Get.width/2.3,
                            height: Get.height /8.0,
                            child: Image.asset(AppImages.profileBg,fit: BoxFit.fill)
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top:6,left: 10),
                          child: Text('Sheeza Tariq',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: Get.width/2.3,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top:6,left: 10),
                                child: Image.asset(AppImages.location,height: 15)
                              ),
                              SizedBox(width:5),
                              Container(
                                margin: EdgeInsets.only(top:6),
                                child: Text("location",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                              ),
                              Spacer(flex: 2),
                              Container(
                                margin: EdgeInsets.only(right:6),
                                child: Text("SAR 99",textAlign: TextAlign.end,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ), 
                        Container(
                          width: Get.width/2.3,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top:6,left: 10),
                                child: Image.asset(AppImages.location,height: 15)
                              ),
                              SizedBox(width:5),
                              Container(
                                margin: EdgeInsets.only(top:6),
                                child: Text("location",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                              ),
                              Spacer(flex: 2),
                              Container(
                                margin: EdgeInsets.only(right:6),
                                child: Text("SAR 99",textAlign: TextAlign.end,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),  
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       // margin: EdgeInsets.only(top:6,left: 5),
                        //       child: Icon(Icons.person,color:Colors.grey),
                        //       // child: Image.asset(AppImages.location,height: 15)
                        //     ),
                        //     // SizedBox(width:5),
                        //     Container(
                        //       margin: EdgeInsets.only(top:6),
                        //       child: Text("Username",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                        //     ),
                        //     Spacer(flex: 1),
                        //     Transform.scale(
                        //       scale: 0.35,
                        //       child: Switch(
                        //         value: _value,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             _value = value;
                        //           });
                        //         },
                        //         activeColor: Colors.blue,
                        //         activeTrackColor: Colors.grey,
                        //         inactiveThumbColor: Colors.pink,
                        //         inactiveTrackColor: Colors.red
                        //       ),
                        //     )
                        //   ],
                        // ),               
                      ],
                    ),
                  )
                // }
              // ),
            );
      // );
         })
         ),
    );
       
  }


  Widget submitButton({buttonText, fontSize, callback, bgcolor, textColor, fontFamily, fontWeight,height,width,borderColor}) {
    return AppButton(
      buttonText: buttonText, 
      callback: callback,
      bgcolor: bgcolor,
      textColor: textColor,
      fontFamily: fontFamily ,
      fontWeight: fontWeight ,
      fontSize: fontSize,    
      borderColor: borderColor,
      height: height,
      width: width, 
    );
  }
  
  void navigateToGoogleLogin() {
  }

  Widget headingUpsell(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:MediaQuery.of(context).size.height/ 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: litems.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                           border: Border.all(color: Colors.blue),
                          color: selectedIndex == index ? selectedColor   : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey                          ,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          litems[index],
                          style: TextStyle(
                            color: selectedIndex == index ? Colors.white : Colors.black,
                            fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "SF Pro Text", fontStyle:FontStyle.normal, 
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}