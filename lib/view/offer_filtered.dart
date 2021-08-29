import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/styling/colors.dart';

class OfferFiltered extends StatefulWidget {
  @override
  _OfferFilteredState createState() => _OfferFilteredState();
}

class _OfferFilteredState extends State<OfferFiltered> {

  allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
 
  var lang;
  var userId;
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar:AppBar(title: Text("FILTERED RESULTS",),
        backgroundColor: AppColors.appBarBackGroundColor,),
        body: GetBuilder<OffersFilteringController> ( 
          init: OffersFilteringController(),
          builder: (value){
            return value.offerFilterCreate !=null && value.offerFilterCreate['data'] !=null ? 
            Column(
              children:allOffersfiltered(
              value.offerFilterCreate['data']) 
            ):Container();
          },
        ) 
      ),
    );
  }
 var catID;

  
   List<Widget> allOffersfiltered(listFilterOffer) {
    List<Widget> favrties = [];
    if( listFilterOffer !=null || listFilterOffer.length !=null){
      for(int c = 0 ; c < listFilterOffer.length; c++ ){
        favrties.add(
          Card(
            child: Container(
              child: ListTile(
                leading: Container(
                  height: Get.height/2,
                  width: Get.width/4,
                  child: listFilterOffer[c]['image_ads'] != null && listFilterOffer[c]['image_ads']['url']!= null? 
                    Image.network( listFilterOffer[c]['image_ads']['url'],
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
                          listFilterOffer[c]['text_ads']['en'] !=null ? 
                          allWordsCapitilize(listFilterOffer[c]['text_ads']['en'].toString()) :'', 
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal,
                          )
                        ),
                        Text(
                          listFilterOffer[c]['status'] == 1 ? "NEW": 
                          listFilterOffer[c]['status'] == 0 ? "OLD":
                          listFilterOffer[c]['status'] == null ? '':'',
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color:listFilterOffer[c]['status'] == 1?  AppColors.snackBarColor: AppColors.appBarBackGroundColor,
                          )
                        )
                      ],
                    ),
                    SizedBox(height:5),
                    Container(
                      child: ReadMoreText(
                        listFilterOffer[c]['description'] != null ?
                        allWordsCapitilize(listFilterOffer[c]['description']['en']) : "",
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
                      child:  listFilterOffer[c]['url'] != null ? Text(allWordsCapitilize(listFilterOffer[c]['url']) ,
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