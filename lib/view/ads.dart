
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/all_category_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';


   List<String> imgList = [];

class AdsView extends StatefulWidget {
  _AdsViewState createState() => _AdsViewState();
}
class _AdsViewState extends State<AdsView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  
  final banner = Get.put(BannerController());
   @override
  void initState() {
    super.initState();
    banner.bannerController();
  }
  @override
  Widget build(BuildContext context) { 
    // print("........${Get.width}");
    return ListView(
      padding: EdgeInsets.symmetric(horizontal:20),
      children: [
          GetBuilder<BannerController>(
            init: BannerController(),
            builder: (data){
              print(data.bannerData);
              imgList = [];
              if(data.bannerData['data'] != null){
              for(int i=0; i < data.bannerData['data'].length; i++) {
                imgList.add(data.bannerData['data'][i]['image']['url']);
              }
              }
              return data.bannerData != null ?carosalImage(imgList) : 
                  Center(heightFactor: 2, child: CircularProgressIndicator());
            }),
         text("advertisingCategories".tr,"all".tr),
         GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (dat){
             print(dat.datacateg);
              return dat.datacateg != null ?  advertisingList(Get.height/5.5,Get.width/4,Get.width < 420 ? Get.height/7.0: Get.height/7.5,dat.datacateg) : Container();
            }
          ),
         text("FeaturedAds".tr,"all".tr), 
         GetBuilder<MyAddsController>(
            init: MyAddsController(),
            builder: (data){ 
              //  print("....................................${data.addsCategoryArray.length}");
              return data.addsCategoryArray.length != 0 ?  featuredAdsList(data.addsCategoryArray) : Container();
            }),
         text('specialofer'.tr,"all".tr),
         GetBuilder<OfferController>(
            init: OfferController(),
            builder: (data){
              return data.offerDataList != null ?  offerList(Get.height/4.5,Get.width/2.9,Get.width < 420 ?Get.height/5.5: Get.height/6.2,data.offerDataList['data']): Container();
            }),
           
         
      ],
    );
  }
  // Widget myList(){
  //   return ListView.builder(itemBuilder: itemBuilder)
  // }
  Widget carosalImage(data) { 
    print(imgList);
    return data.length != 0 ? Column(
      children: [
        CarouselSlider(
          items: data
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
            viewportFraction: 0.9*1.1,
            aspectRatio: 1.8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
        ),
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
        Container(
          margin: EdgeInsets.only(right:10),
          child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey))
        )
      ],
    );
  }

  advertisingList(conHeight,imageW,imageH,data) {
    print("-----------------111111111....,,,${data.length}");
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
                    child:data[index]['media'].length != 0 ? Image.network(data[index]['media'][0]['url']) : 
                     Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                  ),
                ),
              ),
              Container(
                child: Text(data[index]['text_ads']['en'] != null || data[index]['text_ads'] != null ? data[index]['text_ads']['en']:'',style: TextStyle(color: AppColors.grey)),
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
          //  print("-----------------111111111....,,,${data[index]}");
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
                    child:data[index]['media'].length != 0 ? Image.network(data[index]['media'][0]['url']) : 
                     Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
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

  featuredAdsList(data) {
    // print("..................>$data");
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: Get.width < 420 ? Get.height/3.6: Get.height/4.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext,index) {
          return 
          Card(
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
                    width: Get.width < 420 ? Get.width/2.4: Get.width/2.3,
                    height: Get.width < 420 ? Get.height/7.0:  Get.height/7.5,
                    child: data[index]['image'].length != 0 ? Image.network(data[index]['image'][0]['url'],fit: BoxFit.fill,): 
                     Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top:6,left: 10),
                  child: Text(AppString.titleHere,style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: Get.width/2.3,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:6,left: 10),
                        child: Image.asset(AppImages.location,height: 15)
                      ),
                      SizedBox(width:5),
                      Container(
                        margin: EdgeInsets.only(top:6),
                        child: Text("location",style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400)),
                      ),
                      Spacer(flex: 2),
                      Container(
                         margin: EdgeInsets.only(right:6),
                        child: Text("SAR 99",textAlign: TextAlign.end,style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),  
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:6,left: 5),
                      child: Icon(Icons.person,color:AppColors.grey),
                      // child: Image.asset(AppImages.location,height: 15)
                    ),
                    SizedBox(width:5),
                    Container(
                      margin: EdgeInsets.only(top:6),
                      child: Text("Username",style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),               
              ],
            ),
          );
        }
      ),
    );
  }
}
