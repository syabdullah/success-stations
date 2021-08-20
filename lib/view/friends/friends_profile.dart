import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/utils/skalton.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendProfile extends StatefulWidget {
  _FriendProfileState createState() => _FriendProfileState();
}
class _FriendProfileState extends State<FriendProfile> with AutomaticKeepAliveClientMixin<FriendProfile> {
 late TabController _controller;
  int _selectedIndex = 0;
  final friCont = Get.put(FriendsController());
  bool liked = false;
  var id ;
  @override
  void initState() {
    super.initState();
    
     id = Get.arguments;
    print("../././....----------$id");
    friCont.friendDetails(id);
    friCont.profileAds(id);
    // _controller = TabController(length: 2,vsync: this); 
  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print(Get.width);
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: GetBuilder<FriendsController>(
          init: FriendsController(),
          builder:(val) { 
            // print(val.friendProfileData['data']);
            return val.friendProfileData == null || val.userAds == null ? SingleChildScrollView( 
              child:Container(
                margin: EdgeInsets.only(top: 20),
              child: viewCardLoading(context))) :  Column(
              children: [        
                profileDetail(val.friendProfileData['data']),
                tabs(),
                general(val.friendProfileData['data'],val.userAds['data']),
              ],
            );
          }
        ),
      ),
    );
  } 

  Widget profileDetail(data) { 
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
                  Get.back();
                },
                icon: Icon(Icons.arrow_back,color: Colors.white)
              ),
              Center(
                widthFactor: 3,
                child: Container(
                  child: Text("PROFILE",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left:10.0,right:10.0,top:Get.height/6.5),
                child: CircleAvatar(
                  backgroundColor: Colors.red[100],
                  child: Image.asset(AppImages.call,height: 25,)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              child: Text(data['name'],style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
             Container(
               margin: EdgeInsets.only(top:6),
              child: Text("Mobile Developer",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
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

  Widget tabs() {
    return  Wrap(
      children: [
        FractionalTranslation(
          translation:  const Offset(0.5, -0.5),
          child: 
          Container(
            // margin: EdgeInsets.only(left: 250),
            child: Container(
              height: Get.height/9*0.5,
              width:Get.width/3.2,
              decoration: BoxDecoration(
                color: AppColors.appBarBackGroundColor,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(child: Text("Friends",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
            ),
          ),
        ),
        FractionalTranslation(
          translation:  const Offset(0.7, -0.5),
          child: 
          GestureDetector(
            // margin: EdgeInsets.only(left: 250),
            child: Container(
              height: Get.height/9*0.5,
              width:Get.width/3.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                 border: Border.all(
                    color: AppColors.appBarBackGroundColor,
                    width: 2,
                  )

              ),
              child: Center(child: Text("Message",style: TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold))),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: 
             TabBar(
               indicatorColor: AppColors.appBarBackGroundColor,
               indicatorWeight: 5.0,
              tabs: [
                Tab(
                  child: Text("General",style: TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child:Text("Ads",style:TextStyle(color: AppColors.appBarBackGroundColor,fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          
        ),
      ],
    );
  }
  Widget general(data,adsData) {
    return Expanded(
      child: TabBarView(
        children: [
          ListView(
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
                              child: Text(data['name'],style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              
                              margin: EdgeInsets.only(top:25),
                              child: Text(AppString.mobile,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,left: 15,top: 5),
                              child: Text(data['mobile'] != null ? data['mobile'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
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
                            Container(
                              margin: EdgeInsets.only(right: 15,top:5),
                              child: Text(data['email'],style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              margin: EdgeInsets.only(top:20),
                              child: Text(AppString.address,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,top: 5),
                              child: Text("343658795432",style: TextStyle(fontWeight: FontWeight.w600)),
                            ),               
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
                            Container(
                              margin: EdgeInsets.only(left: 15,top: 5),
                              child: Text(data['college'] != null  ? data['college']['college'] :'' ,style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              
                              margin: EdgeInsets.only(top:25),
                              child: Text(AppString.degree,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,left: 15,top: 5),
                              child: Text(data['degree'] != null ? data['degree'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ),               
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
                              child: Text(data['university'] != null ? data['university']['name'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              margin: EdgeInsets.only(top:20),
                              child: Text(AppString.smester,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,top: 5),
                              child: Text(data['semester'] != null ? data['semester'].toString() : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ),               
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
                      child: Text(data['about'] != null ? data['about'] : '' )
                    )
                  ],
                ),
              )
            ],
          ),
          ads(adsData)
        ],
      ),
    ); 
  }

  Widget ads(adsData) {
    return Expanded(
      child: ListView.builder(
            itemCount: adsData != null ? adsData.length:0,
            itemBuilder: (BuildContext,index) {
              return adsData != null ? GestureDetector(
                onTap: (){
                  
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(AppImages.profileBg,height: 80,fit: BoxFit.fitHeight,)
                        )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width/3,
                            child: Text(adsData[index]['text_ads'],style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              Image.asset(AppImages.location,height: 15,),
                              SizedBox(width:5),
                              Container(
                                child: Text("Mobile app dev",style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(AppImages.location,height: 15,),
                              Icon(Icons.person,color: Colors.grey),
                              SizedBox(width:5),
                              Container(
                                child: Text("codility solutions"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        widthFactor: Get.width < 400 ? 2.2: 3.0,
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,height:50)
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    var json = {
                                      'ads_id' : adsData[index]['id']
                                    };
                                    // setState(() {
                                      liked = !liked;
                                    // });
                                   adsData[index]['is_favorite'] == false ?  friCont.profileAdsToFav(json,id) : friCont.profileAdsRemove(json,id);
                                  },
                                child: adsData[index]['is_favorite'] == true ? Image.asset(AppImages.redHeart,height: 25,) :  Image.asset(AppImages.blueHeart,height: 25,) 
                                ),
                                SizedBox(width:5),
                                GestureDetector(
                                  onTap: (){
                                    launch.call("tel:12345678912");
                                  },
                                child: Image.asset(AppImages.call,height: 25,)
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ): Container(
                child: Text("No Ads "),
              );

            },
          ) , 
    
    );
  }
}