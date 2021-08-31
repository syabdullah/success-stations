import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_filtering_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/view/offer_filtered.dart';
import 'package:success_stations/view/offers/home_all_offer_detail.dart';

class OfferList extends StatefulWidget {
  _OfferListState createState() => _OfferListState();
}
 
class _OfferListState extends State<OfferList> {

 final contByCatOffer = Get.put(OfferCategoryController());
 final banner = Get.put(BannerController());
  var json;
  int slctedInd = 0;
  onSelected(int index) {
    setState(() => slctedInd = index);
  }
  var listtype = 'list';
  final offerFilterCont = Get.put(OffersFilteringController());
  final offeCont = Get.put(MyOffersDrawerController());
  var selectedIndex = 0;
  var id;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  var bottomSheetCategory =0;
  Color  filterCategoryColor = Colors.blue;
  var selectedIndexListing = 0;
  var status;
  var category;
  var statusFiltered;
  var start;
  var end;
  var filterID;
  var usertype;
  List<String> itemsList = [
    "old".tr,
    "New".tr,
  ];
  
  GetStorage box = GetStorage ();
  
  var cardHeight;
  var cardwidth;
  @override
   void initState() {
    // offerFilterCont.offerFilter(json);
    banner.bannerController();
    super.initState();
    usertype = box.read('user_type');
  }
  // void dispose() {
  //   offerFilterCont.offerFilter(json);
  //   //banner.bannerController();
  //   super.dispose();

  // }
  
  Widget build(BuildContext context) {
    cardwidth = MediaQuery.of(context).size.width / 3.3;
    cardHeight = MediaQuery.of(context).size.height / 3.6;
    return Scaffold(
      body: Column(
        children: [
        topWidget(),
        GetBuilder<OfferCategoryController>(
          init: OfferCategoryController(),
          builder: (val) {
            return val.offerDattaTypeCategory !=null && val.offerDattaTypeCategory['data'] !=null ? subOffers(val.offerDattaTypeCategory['data']):
            Container();
          },
        ),
        GetBuilder<OfferCategoryController>(
        init: OfferCategoryController(),
          builder: (val) {
            return  val.iDBasedOffers !=null &&  val.iDBasedOffers['data'] !=null && val.iDBasedOffers['success'] == true? 
              allUsers(val.iDBasedOffers['data']): 
              contByCatOffer.resultInvalid.isTrue && val.iDBasedOffers['success'] == false ?  
              Container(
                margin:EdgeInsets.only(top:Get.height/3),
                child: Center(
                  child: Text(
                    contByCatOffer.iDBasedOffers['errors'],
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ):Container();
              // );
            }
          ),
        ]
      )
    );
  }

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
               filteringCategory();
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Image.asset(AppImages.filter, height: 15),
                    SizedBox(width: 5),
                    Text(
                      "filter".tr,
                      style: TextStyle(color: Colors.grey[700]),
                    ), 
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //Get.toNamed('/adPostingScreen');
              },
              child:  usertype == 2 ? Container() :
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset(AppImages.plusImage, height: 24)),
            )
          ],
        ),
      ],
    );
  }

 

  idSended() {
    var createFilterjson = {
      'type': filteredIDCate,
      'status': statusFiltered == 'New'? 1 : 0,
    };
    print("Sended Data.......!!!!!!!!!CREATEDFILTEREDJSON................$createFilterjson");
    offerFilterCont.offerFilter(createFilterjson);
  }

  var filteredIDCate;
   filteringCategory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.0), topRight: Radius.circular(45.0)
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: StatefulBuilder(
            builder:(
              BuildContext context, void Function(void Function()) setState) {
                return SafeArea(
                  child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: Container(
                      margin: EdgeInsets.only(top: 10,left:20, right:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left:10),
                                  child: Text("filter".tr,
                                    style: TextStyle(
                                      fontSize: 20, color: Colors.black
                                    )
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(right:20),
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close)
                                  )
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height*0.04),
                          Text("category".tr, style: TextStyle(fontSize: 15)),
                          GetBuilder<OfferCategoryController>(
                            init: OfferCategoryController(),
                            builder: (data) {
                              return  data.offerDattaTypeCategory != null  && data.offerDattaTypeCategory['data'] !=null?  
                              Container(
                                height: Get.height/10,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.offerDattaTypeCategory['data'].length,
                                  itemBuilder:(BuildContext ctxt, int index){
                                    return Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                bottomSheetCategory = index;
                                                filteredIDCate =  data.offerDattaTypeCategory['data'][index]['id'];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                border: Border.all(color: Colors.blue),
                                                color: bottomSheetCategory == index ? filterCategoryColor  : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0.0, 1.0),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                              padding: EdgeInsets.all(10.0),
                                              child: data.offerDattaTypeCategory['data'] != null
                                              ? Text( data.offerDattaTypeCategory['data'][index]['category_name']['en'],
                                                style: TextStyle(
                                                  color: bottomSheetCategory == index ? Colors.white  : Colors.blue,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ): Container()
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ): Container();
                            },
                          ),
                          Text("status".tr, style: TextStyle(fontSize: 15)),
                          SizedBox(height: 10),
                          Container(
                            height: Get.height*0.05,
                            child: new ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: itemsList.length,
                              itemBuilder: (
                                BuildContext ctxt, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState((){
                                        onSelected(index);
                                        statusFiltered = itemsList[index];
                                        // ignore: unnecessary_statements
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left:20),
                                      width: Get.width / 5,
                                      height: Get.height/2,
                                      decoration: BoxDecoration(
                                        // ignore: unnecessary_null_comparison
                                        color: slctedInd != null && slctedInd == index
                                          ? Colors.blue
                                          : Colors.white, //Colors.blue[100],
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5)
                                          )
                                      ),
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(itemsList[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: slctedInd == index
                                            ? Colors.white
                                            : Colors.blue)),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height:30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      color: Colors.grey[100],
                                      child: Container(
                                        width: Get.width / 4,
                                        child: Center(
                                          child: Text('reset'.tr,
                                            style: TextStyle(
                                              color: AppColors.inputTextColor
                                            )
                                          )
                                        )
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      }
                                    ),
                                  ),
                                  Container(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      color: Colors.blue,
                                      child: Container(
                                        width: Get.width / 4,
                                        child: Center(
                                          child: Text("apply".tr,
                                            style: TextStyle( color: Colors.white)
                                          )
                                        )
                                      ),
                                      onPressed: filteredIDCate  == null  && statusFiltered == null? null  :() {
                                        idSended();
                                        Get.off(FilteredCategoryResult());
                                      }
                                    ),
                                  ),
                                ],
                              )
                            ],
                      ),
                    )
                  ),
                );
              }
            ),
          );
        }
      );
    }
 
  Widget allUsers(listFavou){
    return Container(
      height: Get.height / 1.7,
      child: GridView.builder(
        // padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 90, bottom: 10),
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
            // childAspectRatio: 
        ),
        itemCount: listFavou.length,
        itemBuilder: (BuildContext context, int c) {
          return  GestureDetector(
            onTap:(){
              Get.to(HomeAllOfferDEtailPage(),arguments:listFavou[c]);

            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                          ),
                          child: Container(
                            height: Get.height * 0.18,
                            width: Get.height * 0.18,
                            child: listFavou[c]['image_ads'] != null &&listFavou[c]['image_ads']['url'] != null
                            ? FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                listFavou[c]['image_ads']['url'],
                              ),
                            ): FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.image,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
                Container(
                  child: Text(
                    listFavou[c]['text_ads']['en'] != null? listFavou[c]['text_ads']['en'].toString(): '',
                    style:TextStyle(fontSize: 13, color: Colors.black)
                  )
                )
              ],
            ),
          );
        }),
    );
}


  //  myAddGridView(listFavou) {
  //   // List<Widget> favrties = [];
  //   // if (listFavou != null || listFavou.length != null) {
  //   //   for (int c = 0; c < listFavou.length; c++) {
  //       // favrties.add(
  //         // SingleChildScrollView(
  //           Container(
  //             // width: Get.width / 1.10,
  //             height: Get.height / 3.3,
  //             child: GridView.builder(
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisSpacing: 10,
  //                 mainAxisSpacing: 20,
  //                 crossAxisCount: 2,
  //                 childAspectRatio: 1.0
  //                 ),
  //               // crossAxisCount: 2,
  //                itemCount: listFavou.length,
  //               itemBuilder: (BuildContext context, int c) {
  //                 return Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.all(10),
  //                       child: Card(
  //                         elevation: 1,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(15.0),
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.only(
  //                                 topLeft: Radius.circular(10),
  //                                 topRight: Radius.circular(10),
  //                                 bottomLeft: Radius.circular(10),
  //                                 bottomRight: Radius.circular(10)
  //                               ),
  //                               child: Container(
  //                                 height: Get.height * 0.18,
  //                                 width: Get.height * 0.18,
  //                                 child: listFavou[c]['image_ads'] != null &&listFavou[c]['image_ads']['url'] != null
  //                                 ? FittedBox(
  //                                   fit: BoxFit.cover,
  //                                   child: Image.network(
  //                                     listFavou[c]['image_ads']['url'],
  //                                   ),
  //                                 ): FittedBox(
  //                                   fit: BoxFit.cover,
  //                                   child: Icon(
  //                                     Icons.image,
  //                                     color: Colors.grey[400],
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         listFavou[c]['text_ads']['en'] != null? listFavou[c]['text_ads']['en'].toString(): '',
  //                         style:TextStyle(fontSize: 13, color: Colors.black)
  //                       )
  //                     )
  //                   ],
  //                 );
  //               })
  //             );
  //           // ),
  //         // )
  //       // );
  //   //   }
  //   // }
  //   // return favrties;
  // }
 var offerBYID;
  var ind1 = 0;
  Widget subOffers(dataListedCateOffer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, index) {
              if(ind1 == 0){
                offerBYID =dataListedCateOffer[index]['id'];
                print(".........!!!!!!!!!..............offer BY ID.........$offerBYID");
                contByCatOffer.categorrOfferByID(dataListedCateOffer[index]['id']);

              }
              ++ind1;
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          offerBYID = dataListedCateOffer[index]['id'];
                          print(".......!!!!!!!!!!!! stState by tapping..........$offerBYID");
                          contByCatOffer.categorrOfferByID(dataListedCateOffer[index]['id']);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue),
                          color: selectedIndex == index ? selectedColor: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          dataListedCateOffer[index]['category_name']['en'],
                          style: TextStyle(
                            color: selectedIndex == index? Colors.white : Colors.blue,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

