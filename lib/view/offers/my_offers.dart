import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/styling/text_style.dart';


class OffersDetail extends StatefulWidget {
  _MyOffersDetailState createState() => _MyOffersDetailState();
}
class _MyOffersDetailState extends State<OffersDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
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
        appBar: PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: stringbar(context, "MY OFFERS" )),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/addedOffer');
                  },
                  child: Container(
                    margin:EdgeInsets.only(left:20, top: 30),
                    child: Image.asset(AppImages.plusImage, height:24)
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin:EdgeInsets.only(left:10, top: 30),
                  child: Text("addnewoffer".tr)
                ),
             
              ],
            ),
            GetBuilder<MyOffersDrawerController>(
              init: MyOffersDrawerController(),
              builder:(val){
                print(" offrerrrr controllelr${val.myofferListDrawer}");
                return  val.myofferListDrawer  !=null && val.myofferListDrawer['success'] == true  ? Column(
                  children: allOffersWidget(val.myofferListDrawer['data'])
                ):
                  Container(
                    child: Text("NO offers yet!"),
                  );
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
              child: ListTile(
                leading: Container(
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
                          allWordsCapitilize(listFavou[c]['text_ads']['en'].toString()) :'', 
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
                        allWordsCapitilize(listFavou[c]['description']['en']) : "",
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
                      child:  listFavou[c]['url'] != null ? Text(allWordsCapitilize(listFavou[c]['url']) ,
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