import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/controller/offers/user_offers_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/styling/text_style.dart';
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
  final delete = Get.put(UserOfferController());
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
        // print(" ID GET IT ${listFavou[c]['id']}");
        favrties.add(
          Container(
            height: 100,
            child:
             Card(
              child: ListTile(
                onTap: (){
                  // Get.to(MyOfferDetailMain(),arguments: listFavou[c]);
                   delete.deleteOffer(listFavou[c]['id']);

                },
                trailing: 
                    
                   Image.asset(AppImages.delete,height: 30,),
                   
               
                leading:  
                Container(
                  height: Get.height/2,
                  width: Get.width/4,
                  child: listFavou[c]['image_ads'] != null && listFavou[c]['image_ads']['url']!= null? 
                    Image.network( listFavou[c]['image_ads']['url'],
                  ):Container(
                     child: Icon(Icons.image,size: 50,),
                  )
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listFavou[c]['text_ads']['en'] !=null ? 
                          listFavou[c]['text_ads']['en'].toString() :'', 
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal,
                          )
                        ),
                        Text(
                          listFavou[c]['status'] == 1 ? "NEW": 
                          listFavou[c]['status'] == 0 ? "OLD":
                          listFavou[c]['status'] == null ? '':'',
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color:listFavou[c]['status'] == 1?  AppColors.snackBarColor: AppColors.appBarBackGroundColor,
                          )
                        )
                      ],
                    ),
                    SizedBox(height:5),
                    Container(
                      child: ReadMoreText(
                        listFavou[c]['description'] != null ?
                       listFavou[c]['description']['en'] : "",
                        style:TextStyle(color:AppColors.inputTextColor, fontSize: 13),
                        trimLines: 2,
                        colorClickableText: AppColors.appBarBackGroundColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                      ),
                    ),
                    SizedBox(height:5),
                    Container(
                      child:  listFavou[c]['url'] != null ? Text(listFavou[c]['url'] ,
                        style:TextStyle(color:AppColors.appBarBackGroundColor, fontSize: 13)
                      ): Container()
                    ),
                  ],
                ),
                 
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