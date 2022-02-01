
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/app_bar_filtered_controller.dart';
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
  final ratingcont = Get.put(RatingController());
  final controller = Get.put(AddBasedController());
  var  selectedIndex = 0, grid = AppImages.gridOf,id,lang, listingIdRemoved, bye,imageAds, ind = 0 ,gridImages,splitedPrice;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.blue;
  GetStorage box = GetStorage();
  bool isButtonPressed = false;
bool itemshow = true;
   int select = 0;
List<String> headings = [
  "item     |     ",
  "Service Provider     |     ",
  "promotions"
];
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
    lang = box.read('lang_code');
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
    return DefaultTabController(
      length: 3,  // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        key: _scaffoldKey,
        appBar: AppBar(
          // leadingWidth: 76,
          backgroundColor:Colors.white,
          // title: Container(
          //   // margin: EdgeInsets.only(top: 12),
          //     child: Text(
          //       "My Fevorite",
          //       style: TextStyle(
          //
          //           fontSize: 18,color: Colors.black,fontFamily: "Source_Sans_Pro",fontWeight: FontWeight.w400),
          //     )),
          centerTitle: true,
          leading: Container(
              margin: EdgeInsets.only( left: 7),
              child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(AppImages.imagearrow1,
                        color: Colors.black, height: 22),
                  ))),
          actions: [
         Center(
           child: Padding(
             padding: const EdgeInsets.only(right: 15),
             child: Container(
              // margin: EdgeInsets.only(top: 12),
                child: Text(
                  "My Favorite",
                  style: TextStyle(

                      fontSize: 18,color: Colors.black,fontFamily: "Source_Sans_Pro",fontWeight: FontWeight.w400),
                )),
           ),
         ),
            // GestureDetector(
            //   onTap: () {
            //   },
            //   child: Center(
            //     child: Container(
            //       // margin: EdgeInsets.only( left: 15,),
            //         child: Image.asset(AppImages.plusImage,
            //             color: Colors.black, height: 30)),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     // Get.to(AddLocations());
            //   },
            //   child: Center(
            //     child: Container(
            //         margin: EdgeInsets.only( right:10),
            //         child: Image.asset(AppImages.setting,
            //             color: Colors.black, height: 35)),
            //   ),
            // ),
          ],),
        // appBar:  PreferredSize( preferredSize: Size.fromHeight(60.0),
        //   child: favAdds(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch,1)
        // ),
        drawer: Theme(
          data: Theme.of(context).copyWith( ),
          child: AppDrawer(),
        ),
        body:

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: Get.height/28,

                child: TabBar(
                 indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,


                  isScrollable: true,
                  tabs: [
                    Tab(

                      child: Text("item",style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,))
                    ),
                    Tab(
                      child: Text("Service Provider",style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,)
                    ),),
                    Tab(
                      child: Text("promotions",style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,)),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height-150,

              child: TabBarView(
                children: [
                  items(),
                  Service(),
                  Center(
                    child: Icon(Icons.alarm),
                  )
                ],
              ),
            ),
          ],
        ),



        // Column(
        //   children: [
        //     SizedBox(
        //       height: Get.height/25,
        //       width:Get.width,
        //
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 65,top: 10),
        //         child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //           itemCount: 3,
        //             itemBuilder: (ctx ,index){
        //               bool checked =
        //                   index == select;
        //
        //
        //               return Expanded(
        //               child: InkWell(
        //                 onTap: () {
        //
        //                   setState(() {
        //                     show = true;
        //                     select  =
        //                       index;
        //
        //                   });
        //
        //
        //               },
        //                 child: Text(headings[index],
        //
        //                 style: TextStyle(
        //
        //                     fontSize: 15,fontWeight:checked?FontWeight.bold:FontWeight.normal)),
        //               ),
        //             );
        //             }),
        //       ),
        //     ),
        //
        //     show==true?items():Container()
        //   ],
        // ),
      ),
    );


  }


  Widget items(){
    return   SizedBox(
      child: GetBuilder<GridListCategory>(
          init:GridListCategory(),
          builder: (valueu) {
            return  SingleChildScrollView(
              child: Column(
                children: [

                  GetBuilder<FavoriteController>(
                    init: FavoriteController(),
                    builder: (val) {
                      return val.fvr8DataList !=null &&  val.fvr8DataList['data'] != null && val.fvr8DataList['success'] == true  ?
                      Column(
                        children: valueu.dataType == 'list' ? myAddsList(val.fvr8DataList['data']
                        ):myAddsList(val.fvr8DataList['data']),
                        // myAddGridView(val.fvr8DataList['data']) ,
                      ):
                      Container(
                          height: Get.height/1.5,
                          child:Center(
                            child: Text(
                                "fav".tr,
                                style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            ),
                          )
                      );
                    },
                  )
                ],
              ),
            );
          }
      ),
    );
  }
  Widget Service(){
    return   SizedBox(
      child: GetBuilder<GridListCategory>(
          init:GridListCategory(),
          builder: (valueu) {
            return  SingleChildScrollView(
              child: Column(
                children: [

                  GetBuilder<FavoriteController>(
                    init: FavoriteController(),
                    builder: (val) {
                      return val.fvr8DataList !=null &&  val.fvr8DataList['data'] != null && val.fvr8DataList['success'] == true  ?
                      Column(
                        children: valueu.dataType == 'list' ? myserviceList(val.fvr8DataList['data']
                        ):myserviceList(val.fvr8DataList['data']),
                        // myAddGridView(val.fvr8DataList['data']) ,
                      ):
                      Container(
                          height: Get.height/1.5,
                          child:Center(
                            child: Text(
                                "fav".tr,
                                style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            ),
                          )
                      );
                    },
                  )
                ],
              ),
            );
          }
      ),
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
            Padding(
              padding: const EdgeInsets.only(right: 5,left: 5,top: 10),
              child: Container(
                 height: 120,
decoration: BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.grey)
),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: Container(
                              height: Get.height / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  child: listFavourite[c]['listing']['image'] !=null &&  imageAds !=null
                                  ? ClipRRect(
                                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.network(
                                     imageAds,
                                      width: Get.width / 6,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                  : FittedBox(fit:BoxFit.contain,
                                  child: Icon(Icons.person, color: Colors.grey[400])
                                )
                                ),
                              )
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   child:
                                //   Text(
                                //     listFavou[c]['text_ads'][lang]!=null ?
                                //     listFavou[c]['text_ads'][lang].toString():
                                //     listFavou[c]['text_ads'][lang]==null?
                                //     listFavou[c]['text_ads']['en'].toString():'',
                                //      style: TextStyle(
                                //       color: Colors.grey[700],
                                //       fontWeight: FontWeight.bold
                                //     ),
                                //   )
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                      child:
                                      Text(
                                        "Teaching the brain to read book\n at a special price from",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Source_Sans_Pro",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                        ),
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                      child:
                                      Text(
                                        "55.22 " +"SAR" ,
                                        style: TextStyle(
                                            fontFamily: "Source_Sans_Pro",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                      child:
                                      Text(
                                        "New",
                                        style: TextStyle(
                                            fontFamily: "Source_Sans_Pro",
                                            color: Colors.lightGreen,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                  ),
                                ),


                              ]
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child:  Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       listFavourite[c]['user_name']!=null ?
                        //       Container(
                        //         margin:EdgeInsets.only(left:8),
                        //         child: Text(
                        //          allWordsCapitilize( listFavourite[c]['user_name']['name'],),
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight:FontWeight.bold
                        //           ),
                        //         ),
                        //       ): Container(),
                        //        Container(
                        //         child: listFavourite[c]['listing']['is_rated'] == false
                        //         ? RatingBar.builder(
                        //           initialRating:listFavourite[c]['user_name']['rating'].toDouble(),
                        //           minRating: 1,
                        //           direction: Axis.horizontal,
                        //           allowHalfRating: true,
                        //           itemCount: 5,
                        //           itemSize: 14.5,
                        //           itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                        //           onRatingUpdate: (rating) {
                        //             var ratingjson = {
                        //               'ads_id': listFavourite[c]['id'],
                        //               'rate': rating
                        //             };
                        //             ratingcont.ratings(ratingjson);
                        //           },
                        //         )
                        //         : RatingBar.builder(
                        //           initialRating:listFavourite[c]['user_name']['rating'].toDouble(),
                        //           ignoreGestures: true,
                        //           minRating: 1,
                        //           direction: Axis.horizontal,
                        //           allowHalfRating: true,
                        //           itemCount: 5,
                        //           itemSize: 14.5,
                        //           itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                        //           onRatingUpdate: (rating) {
                        //           },
                        //         )
                        //       ),
                        //       listFavourite[c]['user_name']!=null ?
                        //       Expanded(
                        //         child:
                        //         listFavourite[c]['user_name']['address'] !=null ?
                        //         Row(
                        //           children: [
                        //           Icon(Icons.location_on, color:Colors.grey),
                        //           Container(
                        //             width: 100,
                        //             child:  Text(
                        //               listFavourite[c]['user_name']['address'],
                        //                overflow: TextOverflow.ellipsis,
                        //               style: TextStyle(
                        //                 color: Colors.grey[300]
                        //               ),
                        //             )
                        //           )
                        //           ],
                        //         ):Container()
                        //       ): Container(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height:20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height:30),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              listFavourite[c]['listing'] !=null ?
                                Container(
                                  child: listFavourite[c]['listing']['is_favorite'] == true ?
                                  GestureDetector(
                                    onTap: (){
                                      removeFvr8z();
                                    },
                                    child: Image.asset(AppImages.call,height:22)
                                  ): null,
                              ): Container(),
                              SizedBox(width: 10,),
                              Container(
                                padding: EdgeInsets.only(right:15),
                                child: GestureDetector(
                                  onTap: (){
                                    launch("tel:${listFavourite[c]['listing']['phone']}");
                                  },
                                  child: Image.asset(AppImages.redHeart, height: 22)
                                ),
                              ),
                            ],
                          ),
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

  List<Widget> myserviceList(listFavourite) {
    List<Widget> favrties = [];
    if(listFavourite.length !=null || listFavourite !=null){
      for(int c = 0 ; c < listFavourite.length; c++ ){
        if(listFavourite[c]['listing'] !=null && listFavourite[c]['listing']['image'].length !=null){
          listingIdRemoved = listFavourite[c]['listing']['id'];
          for(int array = 0; array < listFavourite[c]['listing']['image'].length; array++ ){
            imageAds =listFavourite[c]['listing']['image'][array]['url'];
          }
          favrties.add(
              Padding(
                padding: const EdgeInsets.only(right: 5,left: 5,top: 10),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Row(
                        children: [
                          SizedBox(width:15),
                          Container(
                            child: listFavourite[c]['listing']['is_favorite'] == true ?
                            GestureDetector(
                                onTap: (){

                                },
                                child:Image.asset(AppImages.demo_logo,height:50,)
                            ): null,
                          ),
                          SizedBox(width:10),
                          Container(
                            child: listFavourite[c]['listing']['is_favorite'] == true ?
                            GestureDetector(
                                onTap: (){

                                },
                                child:Text("jarir bookstore",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.grey))
                            ): null,
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                listFavourite[c]['listing'] !=null ?
                                Container(
                                  child: listFavourite[c]['listing']['is_favorite'] == true ?
                                  GestureDetector(
                                      onTap: (){
                                        removeFvr8z();
                                      },
                                      child: Image.asset(AppImages.call,height:30)
                                  ): null,
                                ): Container(),
                                SizedBox(width: 10,),
                                Container(
                                  padding: EdgeInsets.only(right:15),
                                  child: GestureDetector(
                                      onTap: (){
                                        launch("tel:${listFavourite[c]['listing']['phone']}");
                                      },
                                      child: Image.asset(AppImages.redHeart, height: 30)
                                  ),
                                ),
                              ],
                            ),
                          ),
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


  List<Widget> myAddGridView(listFavourite) {
    var newData = [];
    for (int i = 0; i < listFavourite.length; i++) {
      if(listFavourite[i] !=null && listFavourite[i]['listing'] !=null ){
        newData.add(listFavourite[i]); 
      }   
    }
    List<Widget> faviii = [];
    newData.length == 0 ? faviii.add (
    Container(
      height: Get.height/1.5,
      child:Center(
        child: Text(
          "fav".tr,
          style:TextStyle(fontSize: 16, fontWeight: FontWeight.normal, )
        ),
      )
    )
  ): faviii.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal:5),
        margin: EdgeInsets.only(top: 5),
        height: Get.height/1,
        child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio:  ( lang == 'en' ?  
        lang == 'en' ? Get.width / 1.01 / Get.height / 0.49:Get.width / 1.10 / Get.height / 0.55: 
        Get.width / 1.01 / Get.height / 0.49),
        children: List.generate(
          newData.length, (index) { 
            var price = newData[index]['listing']['price'].toString();
            splitedPrice = price.split('.');            
            if(newData[index]['listing'] !=null && newData[index]['listing']['image'] != null ){
              for(int c =0; c < newData[index]['listing']['image'].length; c++){
                gridImages= newData[index]['listing']['image'][c]['url'];
              }
            }
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ), 
              child: Column(
                children: [
                  newData[index]['listing'] !=null && gridImages != null ? 
                    Stack(
                      alignment:AlignmentDirectional.topStart,
                      children: [
                        Image.network(
                          gridImages,width: Get.width,fit: BoxFit.cover,
                          height: 130
                        ),
                        newData[index]['listing'] !=null ? 
                        Container(
                          padding: EdgeInsets.only(right: 10,bottom: 2),
                          child: newData[index]['listing']['is_favorite'] == true ?
                          GestureDetector(
                            onTap: (){
                              bye = newData[index]['listing']['id'];
                              removeFvr8zGrid();
                            },
                            child: Image.asset(AppImages.redHeart,height:30)
                          ): null,
                        ): Container(),
                      ],
                    )
                    :
                    Stack(
                      alignment:AlignmentDirectional.topStart,
                      children: [
                        Image.asset(AppImages.bgImage,height: 130,width: Get.width,fit: BoxFit.cover
                      ),
                      newData[index]['listing'] !=null ? 
                      Container(
                        padding: EdgeInsets.only(right: 10,bottom: 2),
                        child: newData[index]['listing']['is_favorite'] == true ?
                        GestureDetector(
                          onTap: (){
                            bye = newData[index]['listing']['id'];
                            removeFvr8zGrid();
                          },
                          child: Image.asset(AppImages.redHeart,height:30)
                        ): null,
                      ): Container(),
                    ],
                  ),
                  newData[index]['listing']  !=null ?
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: newData[index]['listing']['is_rated'] == false
                    ? RatingBar.builder(
                      initialRating:newData[index]['user_name']['rating'].toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 14.5,
                      itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                      onRatingUpdate: (rating) {
                        var ratingjson = {
                          'ads_id': newData[index]['id'],
                          'rate': rating
                        };
                        ratingcont.ratings(ratingjson);
                      },
                    )
                    : RatingBar.builder(
                      initialRating:newData[index]['user_name']['rating'].toDouble(),
                      ignoreGestures: true,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 14.5,
                      itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                      onRatingUpdate: (rating) {
                      },
                    )
                  ):Container(),
                  Center(
                    child: Container(
                      child: newData[index]['user_name']['name']  !=null ?
                      Text( 
                        allWordsCapitilize(newData[index]['user_name']['name'],) 
                      ): Container()
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        newData[index]['listing']['price'] !=null
                        ? "${splitedPrice[0]}" : '',
                        style: TextStyle(color: AppColors.appBarBackGroundColor),
                      ),
                      Text(
                       ' SAR',
                        style: TextStyle(color: AppColors.appBarBackGroundColor,fontSize: 7),
                      ),
                    ],
                  ),         
                ]
              ),
            );    
          }
        )
      ),
    ),
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

Widget addsCategoryWidget(listingCategoriesData){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height:MediaQuery.of(context).size.height/9.22,
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

  void navigateToGoogleLogin() {}
  var allCheck = false;
  Color allColor = Colors.grey;
  bool textAllcheck = false;
  bool havingCategorybool = false;
  final addsGet = Get.put(MyAddsController());
  Widget addCategoryWidget(havingAdds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: havingAdds.length,
            itemBuilder: (context, index) {
              if (index != 0) {
                allCheck = true;
              } else {
                allCheck = false;
              }
              return Row(
                children: [
                  allCheck == false
                      ? Container(
                    width: 70,
                    // margin: lang == 'en'
                    // ? EdgeInsets.only(left: 12.0)
                    // : EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          havingCategorybool = false;
                          textAllcheck = false;
                          selectedIndex = index;
                          allColor = Colors.grey;
                          addsGet.myAddsCategory();
                        });
                      },
                      child: Container(
                        margin: lang == 'en'
                            ? EdgeInsets.only(left: 6)
                            : EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          border: Border.all(
                              color: Colors.grey),
                          color: allColor,
                        ),
                        // padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "all".tr,
                            style: TextStyle(
                              color: textAllcheck == false
                                  ? Colors.white
                                  : AppColors.grey,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                  Container(
                    margin: lang == 'en'
                        ? EdgeInsets.only(left: 12.0)
                        : EdgeInsets.only(right: 6.0),
                    decoration: BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          havingCategorybool = true;
                          ind = ++ind;
                          selectedIndex = index;
                          allColor = Colors.white;
                          textAllcheck = true;
                          id = havingAdds[index]['id'];
                          controller.addedByIdAddes(
                              havingAdds[index]['id'], null);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            border: Border.all(
                                color: AppColors.grey),
                            color: selectedIndex == index &&
                                id == havingAdds[index]['id'] &&
                                textAllcheck == true
                                ? AppColors.grey
                                : Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            havingAdds[index]['category'][lang] != null
                                ? havingAdds[index]['category'][lang]
                                : havingAdds[index]['category'][lang] == null
                                ? havingAdds[index]['category']['en']
                                : '',
                            style: TextStyle(
                              color: selectedIndex == index &&
                                  id == havingAdds[index]['id'] &&
                                  textAllcheck == true
                                  ? Colors.white
                                  : AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          )),
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