import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/all_category_controller.dart';
import 'package:success_stations/controller/favorite_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/drawer_screen.dart';

class FavouritePage extends StatefulWidget {
  _FavouritePageState createState() => _FavouritePageState();
}
class _FavouritePageState extends State<FavouritePage> {
  RangeValues _currentRangeValues = const RangeValues(1,100);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(AddBasedController());
  var listtype = 'list';
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
        ),
        child: AppDrawer(),
      ),
      body: Column(
        children: [
          topWidget(),           
          Expanded(
            child: 
            GetBuilder<FavoriteController>(
              init: FavoriteController(),
              builder: (val){
                return val.fvr8DataList !=null ? 
                listtype == 'list' ? myAddsList(val.fvr8DataList['data']) : myAddGridView(val.fvr8DataList['data']): ListView(
                  children:[
                    Container()
                  ]
                );
              }
            )
            ) 
        ],
      ),
    );
  }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
              icon: Image.asset(grid),
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
  
  
  Widget myAddsList(listFavourite) {
    print("favroutie list api ..... $listFavourite");
    //  print("favroutie list api ..... ${listFavourite[i]['user_name']}");
    return ListView.builder(
      itemCount: listFavourite.length,
      itemBuilder: (BuildContext context,i) {
        print("prinrted value of thee favr9kkkk ..... ${listFavourite.length}");
        return GestureDetector(
          onTap: () {
            Get.to(AdViewScreen());
          },
          child: Card(
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
                        padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  listFavourite[i]['user_name']['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:FontWeight.bold
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Row(
                                  children: [
                                  Icon(Icons.location_on, color:Colors.grey),
                                  Container(
                                    child: Text(
                                      listFavourite[i]['user_name']['address'],
                                      style: TextStyle(
                                        color: Colors.grey[300]
                                      ),
                                    ),
                                  )
                                  ],
                                ),
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
                          listFavourite[i]['listing'] !=null ? 
                          Container(
                            padding: EdgeInsets.only(right:5),
                            child:  listFavourite[i]['listing']['is_favorite'] == true ? Image.asset(AppImages.redHeart, height: 20): null 
                          ): Container(),
                          Container(
                            child: Image.asset(AppImages.call, height: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            ),
        );
        },
    );
  }
var ind = 0 ;
  myAddGridView(listFavourite) {
    print("datalist value...................data list value..... $listFavourite");
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listFavourite.length, 
          (index) {
            return Container(
              width: Get.width < 420 ? Get.width /3.6 : Get.width /9.0,
              margin: EdgeInsets.only(left:15),
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
                            // width: Get.width < 420 ? Get.width/1.4: Get.width/2.3,
                            // height: Get.height /8.0,
                            child: Image.asset(AppImages.profileBg,fit: BoxFit.fill)
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text( 
                            listFavourite[index]['user_name']['name'],
                          )
                        ), 
                        Expanded(
                          flex: 2,
                          child:  Row(
                            children: [
                              Icon(Icons.location_on, color:Colors.grey),
                              Container(
                                child: Text(
                                 listFavourite[index]['user_name']['address'],
                                  style: TextStyle(
                                    color: Colors.grey[300]
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // SizedBox(height:20)
                        // Expanded(
                        //   flex : 2,
                        //   child:  Row(
                        //     children: [
                        //       Icon(Icons.person, color:Colors.grey[400],),
                        //       Container(
                        //         // margin:EdgeInsets.only(left:29),
                        //         child: Text(
                                  
                        //           // dataListValue[index]['user']['name']!=null ? dataListValue[index]['user']['name']: '',
                        //           style: TextStyle(
                        //             color: Colors.grey[300]
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   width: Get.width/2.3,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(top:6,left: 10),
                        //         child: Icon(Icons.person, color:Colors.grey[400],)
                        //       ),
                        //       SizedBox(width:5),
                        //       Container(
                        //         margin: EdgeInsets.only(top:6),
                        //         child: Text(dataListValue[index]['user']['name'] !=null ? dataListValue[index]['user']['name']:'',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                        //       ),
                        //       // Spacer(flex: 2),
                        //       // Container(
                        //       //   margin: EdgeInsets.only(right:6),
                        //       //   child: Text("SAR 99",textAlign: TextAlign.end,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400)),
                        //       // )
                        //     ],
                        //   ),
                        // ),              
                      ],
                    ),
                  ),
                 
                );
             }
            )
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

  Widget addsCategoryWidget(listingCategoriesData){
    print("my adds Page.......................,,,,,,,...$listingCategoriesData");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:MediaQuery.of(context).size.height/ 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listingCategoriesData.length,
            itemBuilder: (context, index) {
              if(ind == 0){
                controller.addedByIdAddes(listingCategoriesData[0]['id']);

              }
              
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        print("rrrrrrrrrrrr redixxx${listingCategoriesData[index]['id']}");
                        setState(() {
                          ind = ++ind;
                          selectedIndex = index;
                          controller.addedByIdAddes(listingCategoriesData[index]['id']);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                           border: Border.all(color: Colors.blue),
                          color: selectedIndex == index ? selectedColor : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: listingCategoriesData != null ? Text(
                          listingCategoriesData[index]['category_name'],
                          style: TextStyle(
                            color: selectedIndex == index ? Colors.white : Colors.blue,
                            fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, 
                          ),
                        ):Container()
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