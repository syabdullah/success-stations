import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/controller/all_Adds_category_controller.dart';
import 'package:success_stations/controller/friends_controloler.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/controller/rating_controller.dart';
import 'package:success_stations/controller/user_drafted_controller.dart';
import 'package:success_stations/styling/colors.dart';

class FilteredCategoryResult extends StatefulWidget {
  _FilteredCtaegPageState createState() => _FilteredCtaegPageState();
}

class _FilteredCtaegPageState extends State<FilteredCategoryResult> {
  final getData= Get.put(DraftAdsController());
   final adContr = Get.put(OffersFilteringController());
  final frindCont = Get.put(FriendsController());
    allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  final ratingFilteringController = Get.put(RatingController());
  var lang;
  bool liked = false;
  var userId;
  GetStorage box = GetStorage();
  @override

  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("FILTERED RESULTS",),
      backgroundColor: AppColors.appBarBackGroundColor,),
      body: GetBuilder<OffersFilteringController> ( 
        init: OffersFilteringController(),
        builder: (value) { 
          return value.isLoading == true ?Container():value.offerFilterCreate !=null  && value.offerFilterCreate['data']!=null ? 
          draftedlist(value.offerFilterCreate['data'] ):
          adContr.resultInvalid.isTrue && value.offerFilterCreate['success'] == false ?  
           Container(
            margin: EdgeInsets.only(top: Get.height/10),
            child: Center(
              child: Text(
                adContr.offerFilterCreate['errors'], style:TextStyle(fontSize: 25)
              ),
            ) 
          ):Container();
        }
      )
    );
  }

 var catAddID;
 Widget draftedlist(filteredAdds) {
  return ListView.builder(
      itemCount: filteredAdds.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          // onTap: () {
          //   Get.to(AdViewScreen(), arguments: allDataAdds[index]['id']);
          // },
          child:  Card(
            child: Container(
              child: ListTile(
                leading: Container(
                  height: Get.height/2,
                  width: Get.width/4,
                  child: filteredAdds[index]['image_ads'] != null &&  filteredAdds[index]['image_ads']['url']!= null? 
                    Image.network(  filteredAdds[index]['image_ads']['url'],
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
                           filteredAdds[index]['text_ads']['en'] !=null ? 
                          allWordsCapitilize( filteredAdds[index]['text_ads']['en'].toString()) :'', 
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal,
                          )
                        ),
                        Text(
                          filteredAdds[index]['status'] == 1 ? "NEW": 
                          filteredAdds[index]['status'] == 0 ? "OLD":
                          filteredAdds[index]['status'] == null ? '':'',
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color: filteredAdds[index]['status'] == 1?  AppColors.snackBarColor: AppColors.appBarBackGroundColor,
                          )
                        )
                      ],
                    ),
                    SizedBox(height:5),
                    Container(
                      child: ReadMoreText(
                         filteredAdds[index]['description'] != null ?
                        allWordsCapitilize( filteredAdds[index]['description']['en']) : "",
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
                      child:   filteredAdds[index]['url'] != null ? Text(allWordsCapitilize( filteredAdds[index]['url']) ,
                        style:TextStyle(color:AppColors.appBarBackGroundColor, fontSize: 13)
                      ): Container()
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }
}