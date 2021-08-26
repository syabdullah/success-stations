import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/utils/routes.dart';
import 'package:success_stations/utils/skalton.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendProfile extends StatefulWidget {
  _FriendProfileState createState() => _FriendProfileState();
}
class _FriendProfileState extends State<FriendProfile> with AutomaticKeepAliveClientMixin<FriendProfile> {
 late TabController _controller;
  int selectedIndex = 0;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  final controller = Get.put(AddBasedController());
  final controllerCat = Get.put(CategoryController());
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
        body: 
           
            GetBuilder<FriendsController>(
              init: FriendsController(),
              builder:(val) { 
                print("----------././././///-----${val.friendProfileData}");
                return val.friendProfileData == null || val.userAds == null ? SingleChildScrollView( 
                  child:Container(
                    margin: EdgeInsets.only(top: 20),
                  child: viewCardLoading(context))) : val.friendProfileData['success'] == false && val.friendProfileData['errors'] == 'No Profile Available' ? Container(
                    child: Center(child: Text(val.friendProfileData['errors'])),
                  ):  Column(
                  children: [        
                    profileDetail(val.friendProfileData['data']),
                    tabs(),
                    general(val.friendProfileData['data'],),
                  ],
                );
              }
            ),
          
      ),
    );
  } 

var image;
  Widget profileDetail(data) { 
    print("..........DAATTAAA.....$data");
  if(data['image'] != null) {
    image = data['image'][0]['url'];
  }
    return Stack(
      children: [         
        Container(
          height: Get.height/2.5,
          width: Get.width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30)),
            child: Container(
              color: Colors.grey,
            ),
            // child: Image.asset(AppImages.profileBg,fit: BoxFit.fill)
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
            margin: EdgeInsets.only(left:10.0,right:10.0,top:Get.height/8.5),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child:
                data['image'] == null ? 
                Image.asset(AppImages.person):
                Image.network(
                  data['image']['url'] 
                ),
              )
            )
          ),
        ),
            Container(
              margin: EdgeInsets.only(top:10),
              child: Text(data['name'],style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            //  Container(
            //    margin: EdgeInsets.only(top:6),
            //   child: Text("Mobile Developer",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
            // ),
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
  Widget general(data) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top:20,left: 20),
                              child: Text(AppString.name,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15,top: 5),
                              child: Text(data['name'],style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              
                              margin: EdgeInsets.only(top:20,left: 20),
                              child: Text(AppString.mobile,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,left: 15,top: 5),
                              child: Text(data['mobile'] != null ? data['mobile'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ),               
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top:25,),
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
                                margin: EdgeInsets.only(bottom:20,left: 20,top: 5),
                              child: Text(data['degree'] != null ? data['degree'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ),               
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top:25,right: 20,),
                              child: Text(AppString.university,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20,top:5),
                              child: Text(data['university'] != null ? data['university']['name'] : '',style: TextStyle(fontWeight: FontWeight.w600)),
                            ), 
                            Container(
                              margin: EdgeInsets.only(top:20,right: 20,),
                              child: Text(AppString.smester,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom:20,top: 5,right: 20,),
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
          Stack(
            children: [
                Container(
                  margin: EdgeInsets.only(top:50),
                  child: GetBuilder<AddBasedController>(
                  init: AddBasedController(),
                  builder: (val){
                    print("mejmej me j mje ${val.cData}");
                  return val.cData != null && val.cData['success'] == true  ?  myAddsList(val.cData['data']) : ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: Get.height/4),
                        child: Center(child: Text("No ads yet",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  );
              },
            ),
                ), 
               GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (data){
              return data.isLoading == true ? CircularProgressIndicator(): addsCategoryWidget(data.datacateg);

            },
          ),
            // 
            ],
          )
          // Text("Hello")
          //  myAddsList(data),
          // myAddsList(allDataAdds),
       
        ],
      ),
    ); 
  }

  Widget ads(adsData) {
    return ListView.builder(
          itemCount: adsData != null ? adsData.length:0,
          itemBuilder: (BuildContext context,index) {
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
                        child: adsData[index]['image'].length != 0 ? Image.network(adsData[index]['image'][0]['url'],height: 80,fit: BoxFit.fitHeight) : Container(
                          height: Get.height/8,
                          child: Icon(Icons.image,size: 50,))
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width/3,
                          child: Text(adsData[index]['title']['en'],style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          children: [
                            Image.asset(AppImages.person,height: 15,),
                            SizedBox(width:5),
                            Container(
                              child: Text(adsData[index]['contact_name'],style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.location,height: 15,),
                            // Icon(Icons.person,color: Colors.grey),
                            SizedBox(width:5),
                            Container(
                              child: adsData[index]['address'] != null ? Text(adsData[index]['address']):Text(""),
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
                            borderRadius: BorderRadius.circular(30),
                            child: image != null ? Image.network(image) : Image.asset(AppImages.person,fit: BoxFit.fill,height:30)
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
                                 adsData[index]['is_favorite'] == false ?  friCont.profileAdsToFav(json,id) : friCont.profileAdsRemove(json, id);
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
        );
  }
  Widget myAddsList(allDataAdds) {
     print("...................>>$allDataAdds");
    return ListView.builder(
      itemCount: allDataAdds.length,
      itemBuilder: (BuildContext context,index) {
       
        return GestureDetector(
          onTap: () {
            Get.to(AdViewScreen(),arguments: allDataAdds[index]['id']);
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
                              child:  allDataAdds[index]['media'].length != 0 ?
                              Image.network(allDataAdds[index]['media'][0]['url'],fit: BoxFit.fill,width: Get.width/4,height: Get.height/4,) :
                              Container(
                                width: Get.width/4,
                                 child: Icon(Icons.image,size: 50,),
                              )
                              // Image.asset(
                              //   AppImages.profileBg
                              // ),
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
                                  allDataAdds[index]['title']['en'] != null ? 
                                  allDataAdds[index]['title']['en']:'',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:FontWeight.bold
                                  ),
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
                                // flex : 2,
                                child:  Row(
                                  children: [
                                  Icon(Icons.person, color:Colors.grey),
                                  Container(
                                    // margin:EdgeInsets.only(left:29),
                                    child: Text(
                                      allDataAdds[index]['contact_name']!= null ? allDataAdds[index]['contact_name']: '',
                                      style: TextStyle(
                                        color: Colors.grey[300]
                                      ),
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

                      Container(
                        child:
                        GetBuilder<FriendsController>(
                          init: FriendsController(),
                          builder: (val){
                            return
                            Row(
                              children: [ 
                                GestureDetector(
                                  onTap: () {
                                    var json = {
                                        'ads_id' : allDataAdds[index]['id']
                                      };
                                      // setState(() {
                                        liked = !liked;
                                      // });
                                      allDataAdds[index]['is_favorite'] == false ?  friCont.profileAdsToFav(json,id) : friCont.profileAdsRemove(json, id);
                                      controller.addedAllAds();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right:5),
                                    child: allDataAdds[index]['is_favorite'] == false ? Image.asset(AppImages.blueHeart,height: 25,): Image.asset(AppImages.redHeart,height:30)
                                  ),
                                ),
                                Image.asset(AppImages.call, height: 25),
                              ],
                            );
                          })
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
   Widget addsCategoryWidget(listingCategoriesData){
    print("CCCCCCCCC______${listingCategoriesData.length}");
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
                        child: listingCategoriesData != null ?  Text(
                          listingCategoriesData[index]['category']['en'] != null ? listingCategoriesData[index]['category']['en']:'',
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




