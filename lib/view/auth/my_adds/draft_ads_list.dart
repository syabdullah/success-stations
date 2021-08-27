import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/user_drafted_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/view/add_posting_screen.dart';

class DraftAds extends StatefulWidget {
  const DraftAds({ Key? key }) : super(key: key);

  @override
  _DraftAdsState createState() => _DraftAdsState();
}

class _DraftAdsState extends State<DraftAds> {
  final getData= Get.put(DraftAdsController());
  var lang;
  var userId;
  GetStorage box = GetStorage();
   @override
  void initState() {
    super.initState();
    getData.getDraftedAds();
    lang = box.read('lang_code');
    userId = box.read('user_id');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Drafted Ads",),
        backgroundColor: AppColors.appBarBackGroundColor,),
        body: GetBuilder<DraftAdsController>( // specify type as Controller
          init: DraftAdsController(), // intialize with the Controller
          // print(getData.userData);
          builder: (value) { 
           return value.isLoading == true ?  Center(child: CircularProgressIndicator()): value.userData['success'] == true ? draftedlist(value.userData['data']) : value.userData['success'] == false ? Container(
             child: Center(child: Text(value.userData['errors'],style: TextStyle(fontWeight: FontWeight.bold),)),
           ) : Center(child: CircularProgressIndicator());
           }
          )
        );
  }

Widget draftedlist(allDataAdds){
    return ListView.builder(
      itemCount: allDataAdds.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            // Get.to(AddPostingScreen(), arguments: allDataAdds[index]);
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
                            height: Get.height / 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  child: allDataAdds[index]['image'].length != 0
                                      ? Image.network(
                                          allDataAdds[index]['image'][0]['url'],
                                          width: Get.width / 4,
                                          fit: BoxFit.fill,
                                        )
                                      : Container(width: Get.width / 4,
                                      child: Icon(Icons.image,size: 50,),
                                      )
                                  //  Image.asset(
                                  //   AppImages.profileBg,
                                  //   width: Get.width/4
                                  // ),
                                  ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                allDataAdds[index]['title'][lang].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Expanded(
                            //   flex : 2,
                            //   child:  Row(
                            //     children: [
                            //       Icon(Icons.location_on, color:Colors.grey),
                            //       Container(
                            //         margin:EdgeInsets.only(left:29),
                            //         child: Text(
                            //           allDataAdds[index]['user']['address']!=null ? allDataAdds[index]['user']['address']: '',
                            //           style: TextStyle(
                            //             color: Colors.grey[300]
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                                      // ),
                           
                              
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.grey),
                                  Container(
                                    width: Get.width/4,
                                    // margin:EdgeInsets.only(left:29),
                                    child: Text(
                                      allDataAdds[index]['contact_name'] != null
                                          ? allDataAdds[index]['contact_name']
                                          : '',
                                      style: TextStyle(color: Colors.grey[300]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                            // SizedBox(height: 8),
                            // Expanded(
                            //   flex:3,
                            //   child: Container(
                            //     margin: EdgeInsets.only(left:10),
                            //     child: Row(
                            //       children: [
                            //         Icon(Icons.person, color:Colors.grey),
                            //         Text(
                            //           allDataAdds[index]['user']['name'],
                            //           style: TextStyle(
                            //             color: Colors.grey[300]
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            
                          ],
                        ),
                      ),
                      // ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      getData.getDraftedAdsOublished(allDataAdds[index]['id']);
                    },
                    child: Container(
                      color : AppColors.appBarBackGroundColor,
                      height: 30,
                      width: Get.width/4.2,
                      margin: EdgeInsets.only(right: 15),
                      child: Center(child: Text("Publish",style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
}
}