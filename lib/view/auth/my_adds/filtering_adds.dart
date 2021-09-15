import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/rating_controller.dart';
import 'package:success_stations/controller/user_drafted_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class FilteredAdds extends StatefulWidget {
  _FilteredPageState createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredAdds> {
  final getData = Get.put(DraftAdsController());
  final adbAsedContr = Get.put(AddBasedController());
  final frindCont = Get.put(FriendsController());
final controller = Get.put(AddBasedController());
  final friCont = Get.put(FriendsController());
  final filterControlller = Get.put(AddBasedController());
  final ratingFilteringController = Get.put(RatingController());
  var lang;
  bool liked = false;
  var userId;
  GetStorage box = GetStorage();
  var data;
  var splitedPrice;
  @override
  void initState() {
    // adbAsedContr.addedAllAds();
    data = Get.arguments;
    controller.addedAllAds();
    lang = box.read('lang_code');
    print("...<><><><><><///<><><><>///.....$data");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "FILTERED RESULTS",
          ),
          backgroundColor: AppColors.appBarBackGroundColor,
        ),
        body: GetBuilder<AddBasedController>(
            init: AddBasedController(),
            builder: (value) {
              return value.adsFilterCreate != null &&
                      value.adsFilterCreate['data'] != null&&data=='grid'
                      
                  ? draftedGridlist(value.adsFilterCreate['data'])
                  : value.adsFilterCreate != null &&
                      value.adsFilterCreate['data'] != null&&data=='list'?
                      draftedlist(value.adsFilterCreate['data'])
                  :adbAsedContr.resultInvalid.isTrue &&
                          value.adsFilterCreate['success'] == false
                      ? Container(
                          margin: EdgeInsets.only(top: Get.height * 0.00),
                          child: Center(
                            child: Text(adbAsedContr.adsFilterCreate['errors'],
                                style: TextStyle(fontSize: 25)),
                          ))
                      : Container();
            }));
  }

  var catAddID;

  Widget draftedlist(filteredAdds) {
    return ListView.builder(
      itemCount: filteredAdds.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(AdViewScreen(), arguments: filteredAdds[index]['id']);
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
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            height: Get.height / 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                child: filteredAdds[index]['image'].length != 0
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          filteredAdds[index]['image'][0]['url'],
                                          width: Get.width / 5,
                                          height: Get.width / 3,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(
                                        width: Get.width / 5,
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                        ),
                                      ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child:
                                    filteredAdds[index]['title']['en'] != null
                                        ? Text(
                                            filteredAdds[index]['title']['en'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container()),
                            Row(
                              children: [
                                
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: filteredAdds[index]['is_rated'] ==
                                            false
                                        ? RatingBar.builder(
                                            initialRating: filteredAdds[index]
                                                    ['rating']
                                                .toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 22.5,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(
                                                  'rating on tap ........$rating');
                                              var ratingjson = {
                                                'ads_id': filteredAdds[index]
                                                    ['id'],
                                                'rate': rating
                                              };
                                              print(
                                                  '.....................Rating data on Tap .........$ratingjson');
                                              ratingFilteringController
                                                  .ratings(ratingjson);
                                            },
                                          )
                                        : RatingBar.builder(
                                            initialRating: filteredAdds[index]
                                                    ['rating']
                                                .toDouble(),
                                            ignoreGestures: true,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 22.5,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          )),
                                     
                              ],
                            ),
                            
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.grey),
                                  Container(
                                    child: Text(
                                      filteredAdds[index]['contact_name'] !=
                                              null
                                          ? filteredAdds[index]['contact_name']
                                          : '',
                                      style: TextStyle(color: Colors.grey[300]),
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
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            radius: 20,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: filteredAdds[index]['category']
                                                ['image'] !=
                                            null &&
                                        filteredAdds[index]['category']['image']
                                                ['url'] !=
                                            null
                                    ? Image.network(
                                        filteredAdds[index]['category']['image']
                                            ['url'],
                                        fit: BoxFit.fill,
                                        height: 40)
                                    : Image.asset(
                                        AppImages.person,
                                        color: Colors.grey[400],
                                        height: 40,
                                      )
                                // Image.asset(
                                //   AppImages.profile,
                                // ),
                                ),
                          )),
                      Container(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              var json = {'ads_id': filteredAdds[index]['id']};
                              liked = !liked;
                              filteredAdds[index]['is_favorite'] == false
                                  ? frindCont.profileAdsToFav(json, userId)
                                  : frindCont.profileAdsRemove(json, userId);
                              adbAsedContr.addedByIdAddes(
                                  filteredAdds[index]['id'], null);
                            },
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child:
                                    filteredAdds[index]['is_favorite'] == true
                                        ? Image.asset(AppImages.redHeart,
                                            height: 20)
                                        : Image.asset(AppImages.blueHeart,
                                            height: 20)),
                          ),
                          GestureDetector(
                              onTap: () {
                                launch(
                                    "tel:${filteredAdds[index]['telephone']}");
                              },
                              child: Image.asset(AppImages.call, height: 20)),
                        ],
                      ))
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


var ind = 0;
 var catID;
  final ratingcont = Get.put(RatingController());
 Widget draftedGridlist(filteredAdds) {
    return Container(
      margin: lang=='en'? EdgeInsets.only(left:20,right: 20,top: 10): EdgeInsets.only(left:20,right: 20,top: 10),
      //width: Get.width ,
      //width: Get.width / 1.10,
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(filteredAdds.length, (index) {
            catID=filteredAdds[index]['id'];
            var price = filteredAdds[index]['price'].toString();
            splitedPrice = price.split('.');
            return Container(
                decoration: new BoxDecoration(),
                width: Get.width < 420 ? Get.width / 7.0 : Get.width / 7,
                //margin: EdgeInsets.only(left: 10),
                // height: Get.height < 420 ? Get.height / 3.7 : Get.height / 9.0,
                child: GestureDetector(
                  onTap: (){
            Get.to(AdViewScreen(), arguments: filteredAdds[index]['id']);
          },
                  
                  child: Container(
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Container(
                                width: Get.width < 420
                                    ? Get.width / 1.4
                                    : Get.width / 2.3,
                                height: Get.height / 12.0,
                                //height: Get.height / 8.0,
                                child: filteredAdds[index]['image'].length != 0
                                    ? Stack(
                         alignment:AlignmentDirectional.bottomEnd,
                          children: [
                            Image.network(
                              filteredAdds[index]['image'][0]['url'],
                              width: Get.width,
                              // height: 1--,
                              fit: BoxFit.cover
                            ),
                            Container(
                               padding: EdgeInsets.only(right: 10,bottom: 10),
                              child: GestureDetector(
                            onTap: () {
                              var json = {'ads_id': filteredAdds[index]['id']};
                              liked = !liked;
                              filteredAdds[index]['is_favorite'] == false
                                  ? frindCont.profileAdsToFav(json, userId)
                                  : frindCont.profileAdsRemove(json, userId);
                              adbAsedContr.addedByIdAddes( filteredAdds[index]['id'], null);
                              print(json);
                            },
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child:
                                    filteredAdds[index]['is_favorite'] == true
                                        ? Image.asset(AppImages.redHeart,
                                            height: 20)
                                        : Image.asset(AppImages.blueHeart,
                                            height: 20)),
                          ),
                            ),
                          ],
                        )
                                    : Stack(
                         alignment:AlignmentDirectional.bottomEnd,
                          children: [
                            Center(
                              child: Icon(
                                Icons.image,
                                // width: Get.width,
                                // height: 1--,
                                // fit: BoxFit.cover
                              ),
                            ),
                            Container(
                               padding: EdgeInsets.only(right: 10,bottom: 10),
                              child: GestureDetector(
                            onTap: () {
                              var json = {'ads_id': filteredAdds[index]['id']};
                              liked = !liked;
                              filteredAdds[index]['is_favorite'] == false
                                  ? frindCont.profileAdsToFav(json, userId)
                                  : frindCont.profileAdsRemove(json, userId);
                              adbAsedContr.addedByIdAddes(
                                  filteredAdds[index]['id'], null);
                            },
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child:
                                    filteredAdds[index]['is_favorite'] == true
                                        ? Image.asset(AppImages.redHeart,
                                            height: 20)
                                        : Image.asset(AppImages.blueHeart,
                                            height: 20)),
                          ),
                            ),
                          ],
                        )
                                      
                                      ),
                          ),
                          Container(
                            // alignment: Alignment.topLeft,
                            alignment: lang == 'en'
                                  ? Alignment.center
                                  : Alignment.center,
                            child: Text(
                                filteredAdds[index]['title']['en'] != null
                                    ? filteredAdds[index]['title']['en']
                                    : '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 5,left: 10),
                                  child: filteredAdds[index]['is_rated'] ==false
                                  ? RatingBar.builder(
                                    initialRating: filteredAdds[index]['rating'].toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 14,
                                    itemBuilder:(context, _) => Icon(Icons.star,color: Colors.amber,),
                                    onRatingUpdate: (rating) {
                                      print('rating on tap ........$rating');
                                      var ratingjson = {
                                        'ads_id': filteredAdds[index]['id'],
                                        'rate': rating
                                      };
                                      print('.....................Rating data on Tap .........$ratingjson');
                                      ratingcont.ratings(ratingjson);
                                      // ratingcont.getratings(allDataAdds[index]['id']);
                                    },
                                  )
                                  : RatingBar.builder(
                                    initialRating: filteredAdds[index]['rating'].toDouble(),
                                    ignoreGestures: true,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 14,
                                    itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                    onRatingUpdate: (rating) {
                                      // ratingcont.getratings(allDataAdds[index]['id']);
                                    },
                                  )
                                ),
                                Container(
                              padding: EdgeInsets.only(right:15),
                              child: 
                              filteredAdds[index]['phone']!= null ?
                              GestureDetector(
                                onTap: (){
                                  print("hehe");
                                   launch("tel:${filteredAdds[index]['phone']}");
                                },
                                child: Image.asset(AppImages.call, height: 20)):Container()
                            ),
                            ],
                          ),
                            
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: lang == 'en'
                                    ? EdgeInsets.only(left: 9)
                                    : EdgeInsets.only(right: 9),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.grey[400],
                                  ),
                                  Container(
                                    // margin:EdgeInsets.only(left:29),
                                    child: Text(
                                            filteredAdds[index]['contact_name'] !=
                                                  null
                                          ? filteredAdds[index]['contact_name']
                                          : '',
                                      style: TextStyle(color: Colors.grey[300]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          filteredAdds[index]['price'] != null ? Container(
                            margin: EdgeInsets.only(top:10,left: 10,right: 10),
                            child: Text(" SAR ${splitedPrice[0]}",
                            style: TextStyle(color: AppColors.appBarBackGroundColor,fontSize: 13),),
                          ):Container()
                        ],
                      ),
                    ),
                  ),
                ));
          })),
    );
  }
}