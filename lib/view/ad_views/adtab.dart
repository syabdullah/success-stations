import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/text_style.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AdListTab extends StatefulWidget {
  const AdListTab({Key? key}) : super(key: key);

  @override
  _AdListTabState createState() => _AdListTabState();
}

class _AdListTabState extends State<AdListTab> {
  final friCont = Get.put(FriendsController());
  final controller = Get.put(AddBasedController());
  final addsController = Get.put(FriendsController());
  var id;
  var userId;
  var indId;
  bool liked = false;
  var contactNmbr;
  GetStorage box = GetStorage();


  @override
  void initState() {
    
     id = Get.arguments;
    // controller.addedAllAds();
      //  addsController.profileAds(indId);
    userId = box.read('user_id');
    indId = box.read('selectedUser');
    friCont.profileAds(id);
    print(" User Ads $id");
    
    indId = Get.arguments;
       super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FriendsController>(
        init: FriendsController(),
        builder: (val) {
          //print("....here in buider.......${val.userAds['id]}"),
          return val.isLoading == true
              ? Center(child: CircularProgressIndicator())
              : val.userAds != null && val.userAds['data'] != null
                  ? adList(val.userAds['data'])
                  : Container(child: Center(child: Text("No Ads Yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),))); //: myAddGridView(val.cData['data']);
        },
      ),
    );
  }

  var catID;
  Widget adList(allDataAdds) {
    //print("........WWWWWW...WWW........$id");
    return Container(
      height: Get.height,
      child: ListView.builder(
         physics: NeverScrollableScrollPhysics(),
        
        itemCount: allDataAdds.length,
        itemBuilder: (BuildContext context, index) {
          print(
              "........-------=ratingggggggggg=====---------......${allDataAdds[index]['id']}");
          return GestureDetector(
            onTap: ()=> Get.to(AdViewScreen(), arguments: allDataAdds[index]['id']),
            child: Card(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Center(
                          child:
                           Container(
                            
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(40)) ),
                              height: Get.height / 4,
                              
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                    child:
                                        allDataAdds[index]['image'].length !=
                                                0
                                            ? ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              child: Image.network(
                                                  allDataAdds[index]['image'][0]
                                                      ['url'],
                                                  width: Get.width / 5,
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
                                    
                                    //  Image.asset(
                                    //   AppImages.profileBg,
                                    //   width: Get.width/4
                                    // ),
                                    ),
                              )),
                        
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Container(
                                  child: Text(
                                    //"",
                                    allDataAdds[index]['title']['en']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height:5),
                              
                              Container(
                                //flex: 2,
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_sharp,
                                        color: Colors.grey),
                                    Container(
                                      // margin:EdgeInsets.only(left:29),
                                      child: Text(
                                        allDataAdds[index]['city']['city'] !=
                                                null
                                            ? allDataAdds[index]['city']
                                                ['city']
                                            : '',
                                        style: TextStyle(
                                            color: Colors.grey[300]),
                                      ),
                                    ),
                                    Text(
                                      ",",
                                      style:
                                          TextStyle(color: Colors.grey[300]),
                                    ),
                                    Container(
                                      // margin:EdgeInsets.only(left:29),
                                      child: Text(
                                        allDataAdds[index]['country']
                                                    ['name'] !=
                                                null
                                            ? allDataAdds[index]['country']
                                                ['name']
                                            : '',
                                        style: TextStyle(
                                            color: Colors.grey[300]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                //flex: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.person, color: Colors.grey),
                                    Container(
                                      // margin:EdgeInsets.only(left:29),
                                      child: Text(
                                        allDataAdds[index]['contact_name'] !=
                                                null
                                            ? allDataAdds[index]
                                                ['contact_name']
                                            : '',
                                        style: TextStyle(
                                            color: Colors.grey[300]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ),
                      ],
                    ),
                    //SizedBox(height: 20),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.person))),
                        Container(
                            // width: Get.width/4,
                            // height: Get.height/5.5,
                            child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(".......QQQQ...QQQQ>...qqqq....$indId");
                                print(
                                    "....add id...${allDataAdds[index]['id']}");
                                print(
                                    ".......user id...!!!!...!!!....$indId");
                                var json = {
                                  'ads_id': allDataAdds[index]['id']
                                };
                                liked = !liked;
                                print(
                                    "..................-----------$catID.........${allDataAdds[index]['is_favorite']}");
                                allDataAdds[index]['is_favorite'] == false
                                    ? friCont.profileAdsToFav(json, indId)
                                    : friCont.profileAdsRemove(json, indId);
          
                                // addsController.addedByIdAddes(json, indId);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(right: 2),
                                  child: allDataAdds[index]['is_favorite'] ==
                                          false
                                      ? Image.asset(AppImages.blueHeart,
                                          height: 20)
                                      : Image.asset(AppImages.redHeart,
                                          height: 20)),
                            ),
                            GestureDetector(
                                onTap: () {
                                  // _makingPhoneCall();
                                  // var contactNmbr =
                                  //     allDataAdds[index]['telephone'];
                                  launch(
                                      "tel:${allDataAdds[index]['telephone']}");
                                  // if(text == AppString.fav) {
                                  //   Get.toNamed('/favourities');
                                  //   } else {
          
                                  //launch("tel:${data['phone']}");
                                  //}
                                },
                                child:
                                    Image.asset(AppImages.call, height: 20)),
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
      ),
    );
  }

  _makingPhoneCall() async {
    var url = 'tel:$contactNmbr';
   contactNmbr == null? url='':url = 'tel:$contactNmbr';
    
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget filter() {
    return InkWell(
      onTap: () {
        // _showModal();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[300],
        ),
        width: Get.width / 5,
        margin: EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  //_showModal();
                },
                child: Image.asset(
                  AppImages.filter,
                  height: 15,
                )),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                //_showModal();
              },
              child: Text('filter'.tr,
                  style: AppTextStyles.appTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppColors.darkgrey)),
            )
          ],
        ),
      ),
    );
  }

}
