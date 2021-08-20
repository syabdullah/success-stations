import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/favorite_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';

class FavouritePage extends StatefulWidget {
  _FavouritePageState createState() => _FavouritePageState();
}
class _FavouritePageState extends State<FavouritePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 final friCont = Get.put(FriendsController());
 
 
  final controller = Get.put(AddBasedController());
  var listtype = 'list';
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  var id, imageUploaded;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    
     id = Get.arguments;
    print("../././....--id pf the favortttt--------$id");
    // _controller = TabController(length: 2,vsync: this); 
  }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            topWidget(),           
            GetBuilder<FavoriteController>(
              init: FavoriteController(),
              builder: (val) {
                return 
                val.fvr8DataList !=null ? Column(
                  children: listtype == 'list' ? myAddsList(val.fvr8DataList): myAddGridView(val.fvr8DataList) ,
                ): ListView(
                  children: [
                    Container()

                  ],
                );
              },
            ) 
          ],
        ),
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
                  padding: EdgeInsets.only(top:10),
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
  
  List<Widget> myAddsList(listFavourite) {
    List<Widget> favrties = [];
    print("favroutie list api ..... $listFavourite");
    if(listFavourite['data'].length !=null  || listFavourite['data'] !=null){
      for(int c = 0 ; c < listFavourite['data'].length; c++ ){
        if(listFavourite['data'][c]['listing'] !=null){
          for(int ima = 0; ima < listFavourite['data'][c]['listing']['image'].length; ima++){
            imageUploaded = listFavourite['data'][c]['listing']['image'][ima]['url'];
          }
          favrties.add(
            Card(
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
                          padding: const EdgeInsets.only(top: 20),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              listFavourite['data'][c]['user_name']!=null ?
                              Container(
                                child: Text(
                                  listFavourite['data'][c]['user_name']['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:FontWeight.bold
                                  ),
                                ),
                              ): Container(),
                              listFavourite['data'][c]['user_name']!=null ?
                              Expanded(
                                child:  Row(
                                  children: [
                                  Icon(Icons.location_on, color:Colors.grey),
                                  Container(
                                    child: Text(
                                      listFavourite['data'][c]['user_name']['address'],
                                      style: TextStyle(
                                        color: Colors.grey[300]
                                      ),
                                    ),
                                  )
                                  ],
                                ),
                              ): Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:20),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: ClipOval(
                            child: Image.network(
                              imageUploaded,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                                  
                            )
                          ),
                        ),
                        SizedBox(height:10),
                        Row(
                          children: [
                            listFavourite['data'][c]['listing'] !=null ? 
                            GestureDetector(
                              onTap: (){
                                var json = {
                                  'ads_id' : listFavourite['data'][c]['id']
                                };
                                print("jsn darar on tao ,,,,,,,,$json");
                              },
                              child: Container(
                                child:  listFavourite['data'][c]['listing']['is_favorite'] == true ? Image.asset(AppImages.redHeart,height:30): null 
                              ),
                            ): Container(),
                            Container(
                              padding: EdgeInsets.only(right:15),
                              child: Image.asset(AppImages.call, height: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          );
        }
      }
    }
    return favrties;
  }
  var ind = 0 ;
  List<Widget> myAddGridView(listFavourite) {
    List<Widget> faviii = [];
    faviii.add(
      Container(
        height:  Get.height < 420 ? Get.height /3.6 : Get.height /1.0,
        child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listFavourite['data'].length, 
          (index) {
            return Container(
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
                            width: Get.width/1.0,
                            height: Get.height/5.2,
                            child: Image.asset(AppImages.profileBg)
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text( 
                            listFavourite['data'][index]['user_name']['name'],
                          )
                        ), 
                        Expanded(
                          flex: 2,
                          child:  Row(
                            children: [
                              Icon(Icons.location_on, color:Colors.grey),
                              Container(
                                child: Text(
                                 listFavourite['data'][index]['user_name']['address'],
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
                );
              }
            )
          ),
        )
      );
      return faviii;
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