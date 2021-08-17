
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/all_category_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';


  final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class AdsView extends StatefulWidget {
  _AdsViewState createState() => _AdsViewState();
}
class _AdsViewState extends State<AdsView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  
  @override
  Widget build(BuildContext context) {
    print("........${Get.width}");
    return ListView(
      padding: EdgeInsets.symmetric(horizontal:20),
      children: [
         carosalImage(),
         text("advertisingCategories".tr,"all".tr),
         GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (data){
              return data.datacateg != null ?  advertisingList(Get.height/5.5,Get.width/4,Get.width < 420 ? Get.height/7.0: Get.height/7.5,data.datacateg) : Container();
            }),
         text("FeaturedAds".tr,"all".tr), 
         GetBuilder<MyAddsController>(
            init: MyAddsController(),
            builder: (data){ 
              return featuredAdsList(data.addsCategoryArray);
            }),
         text('specialofer'.tr,"all".tr),
         GetBuilder<CategController>(
            init: CategController(),
            builder: (data){
              return data.dataListing != null ?  advertisingList(Get.height/4.5,Get.width/2.9,Get.width < 420 ?Get.height/5.5: Get.height/6.2,data.dataListing['data']): Container();
            })
         
      ],
    );
  }

  Widget carosalImage() {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
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
    // print("-----------------$data");
    return Container(
      margin: EdgeInsets.symmetric(vertical:15),
      height: conHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext,index) {
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
                    child: Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
                  ),
                ),
              ),
              Container(
                child: Text(data[index]['category']['en'],style: TextStyle(color: AppColors.grey)),
              )
            ],
          );
        }
      ),
    );
  }

  featuredAdsList(data) {
    print("..................>$data");
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
                    child: Image.network(data[index]['image'][0]['url'],fit: BoxFit.fill,)
                    //  Image.asset(AppImages.profileBg,fit: BoxFit.fill,)
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

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();