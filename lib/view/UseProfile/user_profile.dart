import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/user_profile_controller.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/view/bottom_bar.dart';

class UserProfile extends StatefulWidget {
  _UserProfileState createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> with AutomaticKeepAliveClientMixin<UserProfile> {
  final dataUser = Get.put(UserProfileController());
  final banner = Get.put(BannerController());
  bool liked = false;
  var id ;
  @override
  void initState() {
    super.initState();
    
    //  id = Get.arguments;
    // print("../././....----------$id");
    // friCont.friendDetails(id);
    // friCont.profileAds(id);
    // _controller = TabController(length: 2,vsync: this); 
  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print(Get.width);
    print(Get.height);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: GetBuilder<UserProfileController>( 
          init: UserProfileController(),
          builder:(val) {
            
            print(val.userData);
            return 
            val.userData!= null ? Column(
              children: [
               profileDetail(val.userData['data']),
               general(val.userData['data'])
              ],
            ):CircularProgressIndicator();
            
          }
            ),
        // body: Column(
        //   children: [
        //     profileDetail(),
        //     general()

        //   ],
        // ),
        // GetBuilder<FriendsController>(
        //   init: FriendsController(),
        //   builder:(val) { 
        //     return val.friendProfileData == null || val.userAds == null ? SingleChildScrollView( 
              // child:
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              // child: viewCardLoading(context))) 
              
            //   :  Column(
            //   children: [        
            //     profileDetail(val.friendProfileData['data']),
            //     tabs(),
            //     general(val.friendProfileData['data'],val.userAds['data']),
            //   ],
            // );
          // }
        // ),
      // ),
    ));}
  // } 

  Widget profileDetail(userData) { 
    return Stack(
      children: [         
        Container(
          height: Get.height/2.5,
          width: Get.width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30)),
            child: Image.asset(AppImages.profileBg,fit: BoxFit.fill)
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:30),
          child: Row(
            children: [
              IconButton(
                onPressed:() {
                  
                  Get.offAll(BottomTabs());
                  banner.bannerController();
                },
                icon: Icon(Icons.arrow_back,color: Colors.white)
              ),
              // Center(
              //   widthFactor: 3,
              //   child: Container(
              //     child: Text("JUNAID",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
              //   ),
              // )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left:10.0,right:10.0,top:Get.height/8.5),
                child: CircleAvatar(
                              backgroundColor: Colors.white54,
                              radius: 40.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child:Image.network(
                                  'https://picsum.photos/250?image=9',
                                ),
                              )
                            )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              child: Text(userData["name"].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
             Container(
               margin: EdgeInsets.only(top:6),
              child: Text(userData['mobile'].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(top:6),
            //       child: Image.asset(AppImages.location,height: 15)
            //     ),
            //     SizedBox(width:5),
            //     Container(
            //       margin: EdgeInsets.only(top:6),
            //       child: Text("Codility Solutions",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }

  // Widget tabs() {
  //   return  Wrap(
  //     children: [
  //       FractionalTranslation(
  //         translation:  const Offset(0.5, -0.5),
  //         child: 
  //         Container(
  //           // margin: EdgeInsets.only(left: 250),
  //           child: Container(
  //             height: Get.height/9*0.5,
  //             width:Get.width/3.2,
  //             decoration: BoxDecoration(
  //               color: AppColors.appBarBackGroundColor,
  //               borderRadius: BorderRadius.circular(50)
  //             ),
  //             child: Center(child: Text("Friends",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
  //           ),
  //         ),
  //       ),
  //       FractionalTranslation(
  //         translation:  const Offset(0.7, -0.5),
  //         child: 
  //         GestureDetector(
  //           // margin: EdgeInsets.only(left: 250),
  //           child: Container(
  //             height: Get.height/9*0.5,
  //             width:Get.width/3.2,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(50),
  //                border: Border.all(
  //                   color: AppColors.appBarBackGroundColor,
  //                   width: 2,
  //                 )

  //             ),
  //             child: Center(child: Text("Message",style: TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold))),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 30,
  //         child: 
  //            TabBar(
  //              indicatorColor: AppColors.appBarBackGroundColor,
  //              indicatorWeight: 5.0,
  //             tabs: [
  //               Tab(
  //                 child: Text("General",style: TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold)),
  //               ),
  //               Tab(
  //                 child:Text("Ads",style:TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold)),
  //               ),
  //             ],
  //           ),
          
  //       ),
  //     ],
  //   );
  // }
  Widget general(userData) {
    return Expanded(
      child: ListView(
        children: [
          Card(
            elevation: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:20,left: 10),
                          child: Text(AppString.name,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15,top: 5),
                          child: Text(userData["name"].toString(),style: TextStyle(fontWeight: FontWeight.w600)),
                        ), 
                        Container(
                          
                          margin: EdgeInsets.only(top:25),
                          child: Text(AppString.mobile,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom:20,left: 15,top: 5),
                          child: Text(userData["mobile"].toString(),style: TextStyle(fontWeight: FontWeight.w600)),
                        ),               
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:25),
                          child: Text(AppString.email,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(right: 15,top:5),
                        //   child: Text(userData['email'],style: TextStyle(fontWeight: FontWeight.w600)),
                        // ), 
                        Container(
                          margin: EdgeInsets.only(top:20),
                          child: Text(AppString.address,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        userData["address"] != null ?
                        Container(
                            margin: EdgeInsets.only(bottom:20,top: 5),
                          child: Text(userData["address"].toString(),style: TextStyle(fontWeight: FontWeight.w600)),
                        ): Container()     
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:20,left: 10),
                          child: Text(AppString.college,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        userData['college']['name'] != null  ?
                        Container(
                          margin: EdgeInsets.only(left: 15,top: 5),
                          child: Text( userData['college']['name'].toString() ,style: TextStyle(fontWeight: FontWeight.w600)),
                        ):Container(),
                        Container(
                          
                          margin: EdgeInsets.only(top:25),
                          child: Text(AppString.degree,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                         userData["degree"] != null ?
                        Container(
                            margin: EdgeInsets.only(bottom:20,left: 15,top: 5),
                          child: Text(userData["degree"],style: TextStyle(fontWeight: FontWeight.w600)),
                        ): Container()            
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:25),
                          child: Text(AppString.university,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15,top:5),
                          child: Text(userData['university']!= null ? userData['university']['name'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                        ), 
                        Container(
                          margin: EdgeInsets.only(top:20),
                          child: Text(AppString.smester,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                        ),
                        userData["degree"] != null ?
                        Container(
                            margin: EdgeInsets.only(bottom:20,top: 5),
                          child: Text(userData["degree"],style: TextStyle(fontWeight: FontWeight.w600)),
                        ):Container()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
                  child: Text("About",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey))
                ),
                userData["degree"] != null ?
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
                  child: Text(userData["degree"]  )
                ): Container()
              ],
            ),
          )
        ],
      ),
    ); 
  }

//   Widget ads(adsData) {
//     return Expanded(
//       child: ListView.builder(
//             itemCount: adsData != null ? adsData.length:0,
//             itemBuilder: (BuildContext,index) {
//               return adsData != null ? GestureDetector(
//                 onTap: (){
                  
//                 },
//                 child: Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 70,
//                         margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(AppImages.profileBg,height: 80,fit: BoxFit.fitHeight,)
//                         )
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: Get.width/3,
//                             child: Text(adsData[index]['text_ads'],style: TextStyle(fontWeight: FontWeight.bold),),
//                           ),
//                           Row(
//                             children: [
//                               Image.asset(AppImages.location,height: 15,),
//                               SizedBox(width:5),
//                               Container(
//                                 child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Image.asset(AppImages.location,height: 15,),
//                               Icon(Icons.person,color: Colors.grey),
//                               SizedBox(width:5),
//                               Container(
//                                 child: Text("codility solutions"),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Align(
//                         widthFactor: Get.width < 400 ? 2.2: 3.0,
//                         alignment: Alignment.topRight,
//                         child: Column(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,height:50)
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: (){
//                                     var json = {
//                                       'ads_id' : adsData[index]['id']
//                                     };
//                                     // setState(() {
//                                       liked = !liked;
//                                     // });
//                                    adsData[index]['is_favorite'] == false ?  .profileAdsToFavfriCont(json,id) : friCont.profileAdsRemove(json,id);
//                                   },
//                                 child: adsData[index]['is_favorite'] == true ? Image.asset(AppImages.redHeart,height: 25,) :  Image.asset(AppImages.blueHeart,height: 25,) 
//                                 ),
//                                 SizedBox(width:5),
//                                 GestureDetector(
//                                   onTap: (){
//                                     launch.call("tel:12345678912");
//                                   },
//                                 child: Image.asset(AppImages.call,height: 25,)
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ): Container(
//                 child: Text("No Ads "),
//               );

//             },
//           ) , 
    
//     );
//   }
}