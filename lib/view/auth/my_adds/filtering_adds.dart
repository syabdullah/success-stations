import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/user_drafted_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';

class FilteredAdds extends StatefulWidget {
  _FilteredPageState createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredAdds> {
  final getData= Get.put(DraftAdsController());
  final controller = Get.put(AddBasedController());
  final friCont = Get.put(FriendsController());
  var lang;
  var userId;
  GetStorage box = GetStorage();
  @override
  void initState() {
    controller.addedAllAds();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("FILTERED RESULTS",),
      backgroundColor: AppColors.appBarBackGroundColor,),
      body: GetBuilder<AddBasedController> ( 
        init: AddBasedController(),
        builder: (value) { 
          return  value.adsFilterCreate !=null  && value.adsFilterCreate['data'] !=null ? 
          draftedlist(value.adsFilterCreate['data'] ): Container();
        }
      )
    );
  }
 var catID;

  Widget draftedlist(filteredAdds) {
   
    return ListView.builder(
      itemCount: filteredAdds.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          // onTap: () {
          //   Get.to(AdViewScreen(), arguments: allDataAdds[index]['id']);
          // },
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
                          height: Get.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              child: filteredAdds[index]['image'].length != 0
                              ? Image.network(
                                filteredAdds[index]['image'][0]['url'],
                                width: Get.width / 4,
                                fit: BoxFit.fill,
                              ): Container(width: Get.width / 4,
                              child: Icon(Icons.image,size: 50,),
                              )
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
                              child: filteredAdds[index]['title']['en'] !=null ? Text(
                                filteredAdds[index]['title']['en'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              ):Container()
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top:5),
                                  child:  filteredAdds[index]['is_rated'] == false ?  
                                  RatingBar.builder(
                                    initialRating: filteredAdds[index]['rating'].toDouble(),
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
                                      print('rating on tap ........$rating');
                                      var ratingjson = {
                                        'ads_id' : filteredAdds[index]['id'],
                                        'rate': rating
                                      };
                                      print('.....................Rating data on Tap .........$ratingjson');
                                      filteredAdds.ratings(ratingjson );           
                                    },
                                  ): RatingBar.builder(
                                    initialRating: filteredAdds[index]['rating'].toDouble(),
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
                                  )
                                )
                              ],
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.grey),
                                  Container(
                                    child: Text(
                                      filteredAdds[index]['contact_name'] != null ? filteredAdds[index]['contact_name']: '',
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
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.person)
                        )
                      ),
                      Container(
                        child:  Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                var json = {
                                  'ads_id': filteredAdds[index]['id']
                                };
                                // liked = !liked;
                                filteredAdds[index]['is_favorite'] == false ? friCont.profileAdsToFav(json, userId)  : friCont.profileAdsRemove(json, userId); 
                                
                                controller.addedByIdAddes(catID,null);
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: filteredAdds[index]['is_favorite'] == true ? Image.asset(AppImages.redHeart, height: 20)
                                : Image.asset(AppImages.redHeart, height: 20)),
                            ),
                            Image.asset(AppImages.call, height: 20),
                              ],
                            )
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

//  Widget draftedlist(allDataAdds){
//     return ListView.builder(
//       itemCount: allDataAdds.length,
//       itemBuilder: (BuildContext context, index) {
//         return Card(
//           child: Container(
//             height: 100,
//             child: Row(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                       Center(
//                         child: Container(
//                           height: Get.height / 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: GestureDetector(
//                               child: allDataAdds[index]['image'].length != 0
//                                 ? Image.network(
//                                   allDataAdds[index]['image'][0]['url'],
//                                   width: Get.width / 4,
//                                   fit: BoxFit.fill,
//                                 )
//                                 : Container(width: Get.width / 4,
//                                 child: Icon(Icons.image,size: 50,),
//                               )
//                             ),
//                           )
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           children: [
//                             Container(
//                               child: allDataAdds[index]['title'] !=null ? 
//                               Text(
//                                 allDataAdds[index]['title']['en'],
//                                 style: TextStyle(
//                                   color:Colors.black, fontWeight: FontWeight.bold
//                                 )
//                               ): Container()
//                             ),
//                             // Row(
//                             //   children:[
//                                 Container(
//                                   margin: EdgeInsets.only(top:5), 
//                                   child:  RatingBar.builder(
//                                     initialRating: allDataAdds[index]['rating'].toDouble(),
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemSize: 22.5,
//                                     itemBuilder: (context, _) => Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     onRatingUpdate: (rating) { },
//                                   )
//                                 ),
//                             //   ]
//                             // )
//                             Expanded(
//                               flex: 2,
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.person, color: Colors.grey),
//                                   Container(
//                                     child: Text(
//                                       allDataAdds[index]['contact_name'] != null
//                                       ? allDataAdds[index]['contact_name']
//                                       : '',
//                                       style: TextStyle(color: Colors.grey[300]),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ), 
                      
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding( 
//                       padding: const EdgeInsets.all(10.0),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.grey[200],
//                         child:Icon(Icons.person),
//                       )
//                     ),
//                     Container(
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(right:5),
//                             child:allDataAdds[index]['is_favorite'] == false ?
//                             Image.asset(AppImages.blueHeart, height: 20)  :
//                             Image.asset(AppImages.redHeart, height: 20)

//                           ),
//                            Image.asset(AppImages.call, height: 20),

//                       ],)
//                     ,)

//                 ],)
//               ],
//             ),
//           ),
//         );
//       },
//     );
// }
}