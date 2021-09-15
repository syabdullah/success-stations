
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/favorite_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/rating_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/button.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouritePage extends StatefulWidget {
  _FavouritePageState createState() => _FavouritePageState();
}
class _FavouritePageState extends State<FavouritePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 final friCont = Get.put(FriendsController());
 
  final remoControllerFinal = Get.put(FriendsController());
   final fContr = Get.put (FavoriteController());
  var listingIdRemoved;
    var imageAds;
 final ratingcont = Get.put(RatingController());
  final controller = Get.put(AddBasedController());
  var listtype = 'grid';
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  var id, imageUploaded, fvrtListId;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.blue;
  GetStorage box = GetStorage();
  bool isButtonPressed = false;

  allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
 
 @override
  void initState() {
    super.initState(); 
    fContr.favoriteList();

    id = box.read('user_id');
  }

  removeFvr8z(){
    setState(() {
      var reJson = {
      'ads_id': listingIdRemoved

    };
    remoControllerFinal.profileAdsRemove(reJson, null);
    
    });
  }
  var bye;
  removeFvr8zGrid(){
    setState(() {
      var rJson = {
      'ads_id': bye
    };
    remoControllerFinal.profileAdsRemove(rJson, null);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch,1),
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
                return val.isLoading == true  ? CircularProgressIndicator(): val.fvr8DataList !=null &&  val.fvr8DataList['success'] == true ?   Column(
                  children: listtype == 'list' ? myAddsList(val.fvr8DataList['data'])
                  : myAddGridView(val.fvr8DataList['data']) ,
                ): fContr.resultInvalid.isTrue && val.fvr8DataList['success'] == false ?
                Container(
                  margin: EdgeInsets.only(top: Get.height/ 4),
                  child: Center(
                    child: Text(
                    fContr.fvr8DataList['errors'], style:TextStyle(fontSize: 25)),
                  )
                ):Container();        
                
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
            Container(
              margin: EdgeInsets.only(top: 20),
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      listtype = 'grid';
                  isButtonPressed = !isButtonPressed;
                  listIconColor = Colors.grey;
                  grid = AppImages.grid;
                    });
                  },
                  child: Image.asset(AppImages.gridOf,height: 25,width:30,color:  listtype=='list' ? Colors.grey:listtype=='grid'?AppColors.appBarBackGroundColor :AppColors.appBarBackGroundColor),
                ),
              ),
            // IconButton(
            //   color: isButtonPressed ? Colors.blue : Colors.grey,
            //   onPressed: (){
            //     setState(() {
            //       listtype = 'grid';
            //       isButtonPressed = !isButtonPressed;
            //       listIconColor = Colors.grey;
            //       grid = AppImages.grid;
            //     });             
            //   },
            //   icon: Image.asset(grid),
            // ),
            SizedBox(width: 5,),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                        listtype = 'list';
                    listIconColor = Colors.blue;
                    grid = AppImages.gridOf;
                    });
                  },
                  child: Image.asset(AppImages.listing,height: 25,width:30,color: listtype=='grid' ?Colors.grey: listtype=='list' ?AppColors.appBarBackGroundColor :Colors.grey,),
                ),
              ),
            // Container(
            //   margin: EdgeInsets.only(bottom:15),
            //   child: IconButton(
            //     onPressed: (){
            //       setState(() {
            //         listtype = 'list';
            //         listIconColor = Colors.blue;
            //         grid = AppImages.gridOf;
            //       });
            //     },
            //     icon: Container(
            //       padding: EdgeInsets.only(top:10),
            //       child: Image.asset(AppImages.listing, color: listIconColor,height: 20)
            //     )
            //   ),
            // ),
            SizedBox(height: 30,width: 15,)
          ],
        )
      ],
    );
  }
  
  List<Widget> myAddsList(listFavourite) {
    List<Widget> favrties = [];
    if(listFavourite.length !=null || listFavourite !=null){
      for(int c = 0 ; c < listFavourite.length; c++ ){
        if(listFavourite[c]['listing'] !=null && listFavourite[c]['listing']['image'].length !=null){
          listingIdRemoved = listFavourite[c]['listing']['id'];
          for(int array = 0; array < listFavourite[c]['listing']['image'].length; array++ ){
            imageAds =listFavourite[c]['listing']['image'][array]['url'];
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
                            height: Get.height/2,
                            width: Get.width/4,
                            child: listFavourite[c]['listing']['image'] !=null && imageAds !=null ?   Image.network(
                             imageAds
                              
                            ):FittedBox(fit:BoxFit.contain,
                              child: Icon(Icons.person, color: Colors.grey[400])
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              listFavourite[c]['user_name']!=null ?
                              Container(
                                margin:EdgeInsets.only(left:8),
                                child: Text(
                                 allWordsCapitilize( listFavourite[c]['user_name']['name'],),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:FontWeight.bold
                                  ),
                                ),
                              ): Container(),
                               Container(
                                        child: listFavourite[c]['listing']['is_rated'] == false
                                        ? RatingBar.builder(
                                          initialRating:listFavourite[c]['user_name']['rating'].toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 14.5,
                                          itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            print('rating on tap ........$rating');
                                            var ratingjson = {
                                              'ads_id': listFavourite[c]['id'],
                                              'rate': rating
                                            };
                                            print('.....................Rating data on Tap .........$ratingjson');
                                            ratingcont.ratings(ratingjson);
                                            // ratingcont.getratings(allDataAdds[index]['id']);
                                          },
                                        )
                                        : RatingBar.builder(
                                          initialRating:listFavourite[c]['user_name']['rating'].toDouble(),
                                          ignoreGestures: true,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 14.5,
                                          itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            // ratingcont.getratings(allDataAdds[index]['id']);
                                          },
                                        )
                                      ),
                              listFavourite[c]['user_name']!=null ?
                              Expanded(
                                child:  
                                listFavourite[c]['user_name']['address'] !=null ?
                                Row(
                                  children: [
                                  Icon(Icons.location_on, color:Colors.grey),
                                  Container(
                                    child:  Text(
                                      listFavourite[c]['user_name']['address'],
                                      style: TextStyle(
                                        color: Colors.grey[300]
                                      ),
                                    )
                                  )
                                  ],
                                ):Container()
                              ): Container(),
                              // Text("heheh")
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                   
                    SizedBox(height:20),
                    Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10, right: 10),
                        //   child: ClipOval(
                        //     child: listFavourite[c]['user_name'] !=null && listFavourite[c]['user_name']['image'] !=null ?Image.network(
                        //       listFavourite[c]['user_name']['image'],
                        //       width: 50,
                        //       height: 50,
                        //       fit: BoxFit.cover,
                                  
                        //     ):CircleAvatar(backgroundColor:Colors.grey[100])
                        //   )
                        // ),
                        SizedBox(height:30),
                        Row(
                          children: [
                            listFavourite[c]['listing'] !=null ? 
                              Container(
                                child: listFavourite[c]['listing']['is_favorite'] == true ?
                                GestureDetector(
                                  onTap: (){
                                    removeFvr8z();
                                  },
                                  child: Image.asset(AppImages.redHeart,height:30)
                                ): null,
                            ): Container(),
                            Container(
                              padding: EdgeInsets.only(right:15),
                              child: GestureDetector(
                                onTap: (){
                                  print("hehe");
                                   launch("tel:${listFavourite[c]['listing']['phone']}");
                                },
                                child: Image.asset(AppImages.call, height: 20)),
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
    // }
    return favrties;
  }
  var ind = 0 ;
  var gridImages;
  List<Widget> myAddGridView(listFavourite) {
    
    List<Widget> faviii = [];
    faviii.add(
      Container(
        height:  Get.height < 420 ? Get.height /3.4 : Get.height ,
        child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          listFavourite.length, 
          (index) {
            if(listFavourite[index] !=null && listFavourite[index]['listing'] !=null ){
              for(int c =0; c < listFavourite[index]['listing']['image'].length; c++){
                gridImages= listFavourite[index]['listing']['image'][c]['url'];
              }
            }
            return listFavourite[index]['listing']  !=null ? Container(
              margin: EdgeInsets.only(left:15,right: 15),
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
                            width: Get.width/0.7,
                            height: Get.height/10,
                            //hehe
                            child: listFavourite[index]['listing']['image'] !=null && gridImages != null ? 
                            Stack(
                             alignment:AlignmentDirectional.bottomEnd,
                              children: [
                                Image.network(gridImages,width: Get.width,fit: BoxFit.cover,),
                                 listFavourite[index]['listing'] !=null ? 
                              Container(
                                padding: EdgeInsets.only(right: 10,bottom: 2),
                                child: listFavourite[index]['listing']['is_favorite'] == true ?
                                GestureDetector(
                                  onTap: (){
                                     bye = listFavourite[index]['listing']['id'];
                                    removeFvr8zGrid();
                                  },
                                  child: Image.asset(AppImages.redHeart,height:30)
                                ): null,
                            ): Container(),
                              ],
                            ):
                            Stack(
                              alignment:AlignmentDirectional.bottomEnd,
                              children: [
                                Center(child: Icon(Icons.person, color: Colors.grey[400],size: 42,)),
                                  listFavourite[index]['listing'] !=null ? 
                              Container(
                                padding: EdgeInsets.only(right: 10,bottom: 2),
                                child: listFavourite[index]['listing']['is_favorite'] == true ?
                                GestureDetector(
                                  onTap: (){
                                    bye = listFavourite[index]['listing']['id'];
                                    removeFvr8zGrid();
                                  },
                                  child: Image.asset(AppImages.redHeart,height:30)
                                ): null,
                            ): Container(),
                              ],
                            ) 
                          ),
                        ),
                        Center(
                          child: Container(
                             child: listFavourite[index]['user_name']['name']  !=null ? Text( 
                             allWordsCapitilize(listFavourite[index]['user_name']['name'],) 
                            ): Container()
                          ),
                        ),
                           Container(
                             //haha
                           margin: EdgeInsets.only(left:10,right: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: listFavourite[index]['listing']['is_rated'] == false
                                        ? RatingBar.builder(
                                          initialRating:listFavourite[index]['user_name']['rating'].toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 14.5,
                                          itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            print('rating on tap ........$rating');
                                            var ratingjson = {
                                              'ads_id': listFavourite[index]['id'],
                                              'rate': rating
                                            };
                                            print('.....................Rating data on Tap .........$ratingjson');
                                            ratingcont.ratings(ratingjson);
                                            // ratingcont.getratings(allDataAdds[index]['id']);
                                          },
                                        )
                                        : RatingBar.builder(
                                          initialRating:listFavourite[index]['user_name']['rating'].toDouble(),
                                          ignoreGestures: true,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 14.5,
                                          itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                          onRatingUpdate: (rating) {
                                            // ratingcont.getratings(allDataAdds[index]['id']);
                                          },
                                        )
                                      ),
                                //       Container(
                                //         // width: Get.width/4,
                                //         // height: Get.height/5.5,
                                //         child: Row(
                                //           children: [
                                //             GestureDetector(
                                //               onTap: () {
                                //                 var json = {
                                //                   'ads_id': dataListValue[index]['id']
                                //                 };
                                //                 liked = !liked;
                                //                 dataListValue[index]['is_favorite'] ==false
                                //                 ? friCont.profileAdsToFav(json, userId)
                                //                 : friCont.profileAdsRemove(json, userId);
                                //                 controller.addedByIdAddes(catID, null);
                                //               },
                                //               child: Container(
                                //                 padding: EdgeInsets.only(right: 5),
                                //                 child: dataListValue[index]['is_favorite'] ==false
                                //                 ? Image.asset(AppImages.blueHeart,height: 20)
                                //                 : Image.asset(AppImages.redHeart,height: 20)
                                //               ),
                                //             ),
                                //             Image.asset(AppImages.call, height: 20),
                                //     ],
                                //   )
                                // )
                                        GestureDetector(
                                          onTap: (){launch("tel:${listFavourite[index]['listing']['phone']}");},
                                          child: Container(
                                            padding: EdgeInsets.only(right:5),
                                            child: Image.asset(AppImages.call, height: 20),
                                          ),
                                        ),
                                          ],
                                        ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: 
                                   listFavourite[index]['created_by']['address'] !=null ?
                                   Row(
                                    children: [
                                      Icon(Icons.location_on, color:Colors.grey),
                                      Container(
                                        child: Text(
                                          allWordsCapitilize(listFavourite[index]['created_by']['address']),
                                          style: TextStyle(
                                            color: Colors.grey[300]
                                          ),
                                        )
                                      )
                                    ],
                                  ):Container()
                                ), 
                                listFavourite[index]['listing']['price']  !=null ? 
                                Container(
                                  margin: EdgeInsets.only(left:10,right: 10),
                                  child: Text("SAR ${listFavourite[index]['listing']['price']}",style: TextStyle(color: AppColors.appBarBackGroundColor),)):Container()                 
                              ],
                            ),
                          ),
                        ):Container();
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
                controller.addedByIdAddes(listingCategoriesData[0]['id'],id);

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
                          controller.addedByIdAddes(listingCategoriesData[index]['id'],id);
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