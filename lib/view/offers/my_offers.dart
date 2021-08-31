import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';
import 'package:success_stations/view/offers/add_offers.dart';
import 'package:success_stations/view/offers/all_offer_detail.dart';


class OffersDetail extends StatefulWidget {
  _MyOffersDetailState createState() => _MyOffersDetailState();
}
class _MyOffersDetailState extends State<OffersDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final putData  = Get.put(MyOffersDrawerController());
  bool errorCheck = true;

  // allWordsCapitilize (String str) {
  //   return str.toLowerCase().split(' ').map((word) {
  //     String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
  //     return word[0].toUpperCase() + leftText;
  //   }).join(' ');
  // }
  @override
  void initState() {
    putData.drawerMyOffer();
    
    super.initState();
  }
  
  var listtype = 'list';
  var mediaList ;
  var selectedIndex = 0;
  var favourImage;
  var imageUploaded;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      key: _scaffoldKey,
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch),
       ),
       drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child: AppDrawer(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(AddOffersPage());
                  },
                  child: Container(
                    margin:EdgeInsets.only(left:20, top: 30),
                    child: Image.asset(AppImages.plusImage, height:24)
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin:EdgeInsets.only(left:10, top: 30),
                  child: Text("addnewoffer".tr)
                ),
             
              ],
            ),
            SizedBox(height:20),
            GetBuilder<MyOffersDrawerController>(
              init: MyOffersDrawerController(),
              builder:(val){
                return  val.isLoading == true ? CircularProgressIndicator(): val.myofferListDrawer !=null  && val.myofferListDrawer['data'] !=null ? Column(
                  children: allOffersWidget(val.myofferListDrawer['data'])
                ):
                putData.resultInvalid.isTrue &&val.myofferListDrawer['success'] == false ? 
                Container(
                  margin: EdgeInsets.only(top: Get.height/ 4),
                  child: Center(
                    child: Text(
                    putData.myofferListDrawer['errors'], style:TextStyle(fontSize: 25)),
                  )):Container();
              },
            )
          ],
        ),
      ),
    );
  }
  List<Widget> allOffersWidget(listFavou) {
    List<Widget> favrties = [];
    if( listFavou !=null || listFavou.length !=null){
      for(int c = 0 ; c < listFavou.length; c++ ){
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
                          height: Get.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(MyOfferDetailMain(), arguments: listFavou[c]);

                              },
                              child: listFavou[c]['image'] !=null &&  listFavou[c]['image']['url']!=null? 
                              Image.network(
                                listFavou[c]['image']['url'],
                                width: Get.width / 4,
                                fit: BoxFit.fill,
                              )
                              : Container(width: Get.width / 4,
                                child: Icon(
                                  Icons.image,size: 50,
                                ),
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
                            Row(
                              children: [
                                Container(
                                  child: listFavou[c]['text_ads']['en']!=null ?  Text(
                                   listFavou[c]['text_ads']['en'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ):Container(),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top:5),
                              child: listFavou[c]['url']!=null  ?  
                              Text(
                                listFavou[c]['url'], style:TextStyle(color:Colors.blue)
                              ):Container()
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          listFavou[c]['status'] == 1 ? "NEW": 
                          listFavou[c]['status'] == 0 ? "OLD":
                          listFavou[c]['status'] == null ? '':'',
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color:listFavou[c]['status'] == 1?  AppColors.snackBarColor: AppColors.appBarBackGroundColor,
                          )
                        )
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child:  Image.asset(AppImages.edit, height: 30)
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset(AppImages.delete, height: 30)
                            ),
                          ],
                        )
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
      return favrties;
    }
  }


  List<Widget> dataempty(listFavou) {
    List<Widget> favrties = [];
    if( listFavou ==null || listFavou.length ==null){
      for(int c = 0 ; c < listFavou.length; c++ ){
        favrties.add(
          Card(
            child: Container(
              child:Text("No Offers Yet!") 
            )
          )
          );
        }
      }
      return favrties;
    
  }