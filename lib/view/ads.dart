


import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/auth/my_adds/category_ads.dart';
import 'package:success_stations/view/home_offer.dart';


  List<String> imgList = [];

class AdsView extends StatefulWidget {
  _AdsViewState createState() => _AdsViewState();
}
class _AdsViewState extends State<AdsView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
    final catCont = Get.put(CategoryController());
     final addescontrollRefresh = Get.put(MyAddsController());

    allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
  
  final banner = Get.put(BannerController());
  GetStorage box = GetStorage();
  var lang;
  var address;
   @override
  void initState() {
    super.initState();
    catCont.getCategoryNames();
    addescontrollRefresh.myAddsCategory();
    catCont.getCategoryTypes();
    banner.bannerController();
    lang = box.read('lang_code');
    address = box.read('address');
  }
  @override
  Widget build(BuildContext context) { 
    return ListView(
      padding: EdgeInsets.symmetric(horizontal:20),
      children: [
          Container(
            margin: EdgeInsets.only(top:5),
            height: Get.height/10,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.red
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("You are using the free version please upgrade your package to full access",style: TextStyle(color: Colors.white),),
            ),

          ),

          GetBuilder<BannerController>(
            init: BannerController(),
            builder: (data){
              imgList = [];
              return data.bannerData == null || data.bannerData['message'] == "Unauthenticated." ? 
              Center(heightFactor: 2, child: CircularProgressIndicator()):  Column(
                children: [
                  carosalImage(data.bannerData['data']),
                ],
              );
            }),
         featureTextAdded("advertisingCategories".tr,"all".tr),
         GetBuilder<CategoryController>(
          init: CategoryController(),
          builder: (dat){
            return  advertisingList(Get.height/5.5,Get.width/4,Get.width < 420 ? Get.height/7.0: Get.height/7.5,dat.datacateg);
            }
          ),
         featureTextAdded("FeaturedAds".tr,"all".tr), 
          GetBuilder<MyAddsController>(
            init: MyAddsController(),
            builder: (data){ 
              return data.addsCategoryArray.length != 0  ?  featuredAdsList(data.addsCategoryArray) : Container();
            }
          ),
            text('specialofer'.tr,"all".tr),
            GetBuilder<OfferController>(
            init: OfferController(),
            builder: (data){
              return data.offerDataList != null ? 
               offerList(Get.height/4.5,Get.width/2.9,Get.width < 420 ?Get.height/5.5: Get.height/6.2,data.offerDataList['data']): Container();
            }),
      ],
    );
  }
  Widget carosalImage(data) { 
    // if(banner != null){
      for(int i=0; i < data.length; i++) {
        imgList.add(data[i]['image']['url']);
      }
    print(imgList);
    return imgList.length != 0 ? Column(
      children: [
        CarouselSlider(
          
          items: imgList
          .map<Widget>((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                ],
              )
            ),
          ),
        )).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            reverse: false,
            viewportFraction: 0.9*1.1,
            aspectRatio: 1.8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
        ),
        imgList.length == 0 ? 
        Container(child: Text("No Image added yet!"),):
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 20.0,
                height: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.appBarBackGroundColor)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    ):
    Container(
      height: Get.height/4.5,
      margin: EdgeInsets.all(20),
      child: Text("No Banners Here!"),
    );  
  }

  Widget text(text1,text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.grey),
          )
        ),
        GestureDetector(
          onTap: () {
            Get.to(HomeAllFeature());
          },
          child: Container(
            margin: EdgeInsets.only(right:10),
            child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey))
          ),
        )
      ],
    );
  }
  Widget featureTextAdded(text1,text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.grey),
          )
        ),
        GestureDetector(
          onTap: () {
            Get.to(CatAdds());
          },
          child: Container(
            margin: EdgeInsets.only(right:10),
            child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey))
          ),
        )
      ],
    );
  }
  advertisingList(conHeight,imageW,imageH,data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: conHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context,index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(CatAdds(),arguments:data[index]['id']);
                },
                child: Card(
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: imageW,
                      height: imageH,
                      child:data[index]['media'].length != 0 ? Image.network(data[index]['media'][0]['url'],fit: BoxFit.cover,) : Container(
                         child: Icon(Icons.image,size: 50,),
                      )
                      //  Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(data[index]['category'][lang] != null || data[index]['category'] != null ? data[index]['category'][lang]:'',style: TextStyle(color: AppColors.grey)),
              )
            ],
          );
        }
      ),
    );
  }
  offerList(conHeight,imageW,imageH,data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: conHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context,index) {
          return Column(
            children: [
              Card(
                elevation: 3,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: imageW,
                    height: imageH,
                    child:data[index]['media'].length != 0 ? Image.network(data[index]['media'][0]['url'],fit: BoxFit.cover,) : Container(
                       child: Icon(Icons.image,size: 50,),
                    )
                    //  Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                  ),
                ),
              ),
              Container(
                child: Text(data[index]['text_ads']['en'] != null ? data[index]['text_ads']['en']:'',style: TextStyle(color: AppColors.grey)),
              )
            ],
          );
        }
      ),
    );
  }
   var tttt;
  featuredAdsList(data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: Get.width < 420 ? Get.height/3.5: Get.height/4.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context,index) {
          return 
          GestureDetector(
            onTap: () {
              Get.to(AdViewScreen(),arguments:data[index]['id']);
            },
            child: Card(
              elevation: 1,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: Container(
                      width: Get.width < 420 ? Get.width/2.3: Get.width/2.3,
                      height: Get.width < 420 ? Get.height/7.0:  Get.height/7.5,
                      child: data[index]['image'].length != 0 ? Image.network(data[index]['image'][0]['url'],fit: BoxFit.cover,): Container(
                        child: Icon(Icons.image,size: 50,),
                      )
                      //  Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top:5,left: 5),
                    child: Text(data[index]['title'][lang] != null ? allWordsCapitilize(data[index]['title'][lang]):'',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: Get.width/2.3,
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top:6,left: 5),
                              child: Image.asset(AppImages.location,height: 15, color:Colors.grey[600],)
                            ),
                        
                         Container(
                              margin: EdgeInsets.only(top:6,left:5),
                              child: data[index]['city'] !=null?  Text(data[index]['city']['city'],
                              ): Container()
                            ),
                        // SizedBox(width:2),
                       
                         ],
                        ),
                         Container(
                          margin: EdgeInsets.only(top:6,right: 3),
                          child: data[index]['price'] !=null ? Text(
                           'SAR:${data[index]['price']}',style: TextStyle(fontSize: 13),
                          ): Container()
                        ),
                      ],
                    ),
                  ), 
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: Icon(Icons.person,color:Colors.grey[600]),
                      ),
                      SizedBox(width:5),
                      Container(
                        margin: EdgeInsets.only(top:6, left: Get.height*0.000),
                        child: Text(allWordsCapitilize(data[index]['contact_name']),style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),               
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
