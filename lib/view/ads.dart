import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:success_stations/controller/all_add_controller.dart';
import 'package:success_stations/controller/categories_controller.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/controller/rating_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/ad_view_screen.dart';
import 'package:success_stations/view/auth/my_adds/all_ads.dart';
import 'package:success_stations/view/auth/offer_list.dart';

List<String> imgList = [];

class AdsView extends StatefulWidget {
  _AdsViewState createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final catCont = Get.put(CategoryController());
  final addescontrollRefresh = Get.put(MyAddsController());
  final ratingcont = Get.put(RatingController());
  final banner = Get.put(BannerController());
  var userType;
  GetStorage box = GetStorage();
  var lang ,address, newv, accounType; var isVisible = true ;

  @override
  void initState() {
    super.initState();
    isVisible = box.read('upgrade');
    catCont.getCategoryNames();
    addescontrollRefresh.myAddsCategory();
    catCont.getCategoryTypes();
    banner.bannerController();
    lang = box.read('lang_code');
    address = box.read('address');
    newv = box.read('updare');
    userType = box.read('user_type');
    accounType = box.read('account_type');
  }

  @override
  Widget build(BuildContext context) { 
    lang = box.read('lang_code');
    return Stack(
      children: [
        ListView(
          children: [            
              GetBuilder<BannerController>(
                init: BannerController(),
                builder: (data){
                  imgList = [];
                  return data.bannerData == null || data.bannerData['message'] == "Unauthenticated" ? 
                  Center(heightFactor: 1, child: CircularProgressIndicator()):  Column(
                    children: [
                      carosalImage(data.bannerData['data']),
                    ],
                  );
                }),
             featureTextAdded("advertisingCategories".tr,"all".tr),
             GetBuilder<CategoryController>(
              init: CategoryController(),
              builder: (dat){
                return  advertisingList(Get.height/5.6,Get.width/3.7,Get.width < 420 ? Get.height/7.5: Get.height/7.5,dat.datacateg);
                }
              ),
             featureTextAdded("FeaturedAds".tr,"all".tr), 
              GetBuilder<MyAddsController>(
                init: MyAddsController(),
                builder: (data){ 
                  return data.isLoading == false && data.addsListCategory != null ?  featuredAdsList(data.addsListCategory['data']) : Container();
                }
              ),
              text('specialofer'.tr,"all".tr),
                GetBuilder<OfferController>(
                init: OfferController(),
                builder: (data){
                  return data.offerDataList != null ? 
                   offerList(Get.height/4.3,Get.width/2.9,Get.width < 420 ?Get.height/5.9: Get.height/6.1,data.offerDataList['data']): Container();
                }),
          ],
        ),
        userType == 2 || isVisible == false ? Container() : userType !=2 && accounType == 'Free'? upgradeBnner() : Container()
      ],
    );
  }

  Widget upgradeBnner (){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:4.0),
      child: Visibility(
        visible: isVisible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Container(
          margin: EdgeInsets.only(top:5),
          height: Get.height/10,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.red
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:10,left:10,right: 10),
            child: Row(
              children: [
                Container(
                  width: Get.width/1.2,
                  child: Text(
                    "payme".tr,style: TextStyle(color: Colors.white),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isVisible = false;
                    });
                    box.write('upgrade', isVisible);
                    newv = box.read('upgrade');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30,left:10),
                    child: Icon(
                      Icons.close,color: Colors.white,
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carosalImage(data) { 
    for(int i=0; i < data.length; i++) {
      imgList.add(data[i]['image']['url']);
    }
    return imgList.length != 0 ? Column(
      children: [
        CarouselSlider(
          items: imgList
          .map<Widget>((item) => 
            Container(
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover,),
                ],
              ),
            )
          ).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            reverse: false,
            viewportFraction: 1,
            aspectRatio: 1.8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
        ),
        imgList.length == 0 ? 
        Container(
          child: Text("No Image added yet!"),
        ):
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 20.0,
                height: 4.0,
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.appBarBackGroundColor)
                  .withOpacity(_current == entry.key ? 0.9 : 0.4
                )
              ),
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
           margin: EdgeInsets.only(left:10,right: 10,),
          child: Text(text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.grey[700]),
          )
        ),
        GestureDetector(
          onTap: () {
            Get.to(OfferList(),arguments: 100);
          },
          child: Container(
            margin: EdgeInsets.only(right:10,left: 10),
            child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey[700]))
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
          margin: EdgeInsets.only(left:10,right: 10),
          child: Text(text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.grey[700]),
          )
        ),
        GestureDetector(
          onTap: () {
            Get.to(AllAdds(),arguments: ['cat',1]);
          },
          child: Container(
            margin: EdgeInsets.only(right:10,left: 10),
            child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.grey[700]))
          ),
        )
      ],
    );
  }
  advertisingList(conHeight,imageW,imageH,data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      height: conHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data != null ?  data.length : 0,
        itemBuilder: (BuildContext context,index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(AllAdds(),arguments:['cat',data[index]['id']]);
                },
                child: Card(
                  elevation: 5,
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
                width: imageW,
                child: Center(
                  child: Text(data[index]['category'][lang] != null  ? data[index]['category'][lang] : data[index]['category'][lang]==null ? data[index]['category']['en']:'',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.grey)),
                ),
              )
            ],
          );
        }
      ),
    );
  }
  offerList(conHeight,imageW,imageH,data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      height: conHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context,index) {
          return Column(
            children: [
              Card(
                elevation: 5,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: imageW,
                    height: imageH,
                    child:data[index]['media'].length != 0 && data[index]['media'][0]['url'] != null ? Image.network(data[index]['media'][0]['url'],fit: BoxFit.cover,) : Container(
                       child: Icon(Icons.image,size: 50,),
                    )
                  ),
                ),
              ),
              Container(
                width: 100,
                child: Text(
                  data[index]['text_ads'][lang] != null ?
                  data[index]['text_ads'][lang].toString():  data[index]['text_ads'][lang]  == null ?  data[index]['text_ads']['en'].toString():'',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.grey)
                ),
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
      margin: EdgeInsets.symmetric(horizontal: 7),
      height: Get.width < 400 ? Get.height/3.55 : Get.width < 420 ? Get.height/3.4: Get.height/4.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context,index) {
          var doubleval = double.parse(data[index]['price']);
          var price = doubleval.toInt();
          return 
          GestureDetector(
            onTap: () {
              Get.to(AdViewScreen(),arguments:data[index]['id']);
            },
            child: Card(
              elevation: 3,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: Container(
                      width: Get.width < 420 ? Get.width/2.2: Get.width/2.3,
                      height: Get.width < 420 ? Get.height/7.0:  Get.height/9.5,
                      child: data[index]['image'].length != 0 ? Image.network(data[index]['image'][0]['url'],fit: BoxFit.cover,): Container(
                        child: Icon(Icons.image,size: 50,),
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(                   
                      margin: EdgeInsets.only(top:5,),
                      child: Text(data[index]['title'][lang] != null ? data[index]['title'][lang]: data[index]['title']['ar'] == null  ? data[index]['title']['en']:'',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                    ),
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [   
                       Row(
                    children: [
                      Container(
                          margin: lang == 'ar' ?  EdgeInsets.only(top:5,right: 5):  EdgeInsets.only(top:5,left: 5),
                          child: data[index]
                          ['is_rated'] ==
                            false
                          ? RatingBar.builder(
                            initialRating:
                            data[index]['rating'].toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18.0,
                            itemBuilder: (context, _) =>
                                Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                             
                              var ratingjson = {
                                'ads_id':
                                    data[index]
                                        ['id'],
                                'rate': rating
                              };
                             
                              ratingcont
                                  .ratings(ratingjson);
                            },
                          )
                        : RatingBar.builder(
                            initialRating:
                            data[index]['rating'].toDouble(),
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 22.5,
                            itemBuilder: (context, _) =>
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // ratingcont.getratings(allDataAdds[index]['id']);
                            },
                          )
                      )
                    ],
                  ),                  
                      Container(
                        margin: lang == 'ar' ?  EdgeInsets.only(right: 5):  EdgeInsets.only(left: 5),
                        width: Get.width/2.3,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Image.asset(AppImages.location,height: 13, color:Colors.grey[600],)
                                ),                        
                                Container(
                                  width: Get.width/4.9,
                                  margin: EdgeInsets.only(left:5),
                                  child: data[index]['city'] !=null?  Text(data[index]['city']['city'],
                                  style: TextStyle(fontSize: 13,color:Colors.grey[600])
                                  ): Container()
                                ),
                                
                              ],
                            ),                         
                          ],
                        ),
                      ),
                      Container(
                         margin: lang == 'ar' ?  EdgeInsets.only(right: 5):  EdgeInsets.only(left: 10),
                        child: data[index]['price'] !=null ? Text(
                          'SAR: $price',style: TextStyle(fontSize: 13,color:AppColors.appBarBackGroundColor),
                        ): Container()
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
