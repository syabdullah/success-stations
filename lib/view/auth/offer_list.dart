import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/banner_controller.dart';
import 'package:success_stations/controller/offers/offer_category_controller.dart';
import 'package:success_stations/controller/offers/offer_list_controller.dart';
import 'package:success_stations/styling/images.dart';

class OfferList extends StatefulWidget {
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  final banner = Get.put(BannerController());
  void initState() {
    // TODO: implement initState
    banner.bannerController();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> offerGrid = {
    "Name": [
      {
        "searchText": "Subscribe and Save - delivered every week",
        "text":
            "Selling plan name displayed in the cart and during checkout. It's recommended that this name includes the frequency of deliveries",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
      {
        "searchText": "1 week",
        "text": "Label in the plan selector on the product page",
      },
    ],
  };
  List<String> litems = [
    'Categoryt A',
    'Categoryt 1',
    'Categoryt 2',
    'Categoryt 3',
    'Categoryt 4',
    'Categoryt 5'
  ];
  var listtype = 'list';
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      GetBuilder<OfferCategoryController>(
        init: OfferCategoryController(),
        builder: (val) {
          return headingUpsell(val.offeredList);
        },
      ),
      //headingUpsell(),
      GetBuilder<OfferController>(
          init: OfferController(),
          builder: (val) {
            return Expanded(
              child: val.offerDataList != null
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      children: myAddGridView(val.offerDataList['data']),
                    )
                  : Container(),
            );
          })
    ])

        //Expanded(child:myAddGridView(),)

        );
  }

  List<Widget> myAddGridView(listFavou) {
    print(".........listFavou.......!!!!!......!!!!.......${listFavou.length}");
    List<Widget> favrties = [];
    if (listFavou != null || listFavou.length != null) {
      for (int c = 0; c < listFavou.length; c++) {
        favrties.add(Container(
          width: Get.width / 1.10,
          height: Get.height / 0.3,
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(listFavou.length, (c) {
                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
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
                                      bottomRight: Radius.circular(10)),
                                  child: Container(
                                    height: Get.height * 0.18,
                                    child: listFavou[c]['image_ads'] != null &&
                                            listFavou[c]['image_ads']['url'] !=
                                                null
                                        ? Image.network(
                                            listFavou[c]['image_ads']['url'],
                                            fit: BoxFit.fitHeight)
                                        : Container(width: Get.width/2, child: Icon(Icons.image,size: 50,),),
                                  ))
                            ],
                          ),
                        )),
                    Container(
                        child: Text(
                            listFavou[c]['text_ads']['en'] != null
                                ? listFavou[c]['text_ads']['en'].toString()
                                : '',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)))
                  ],
                );
              })),
        ));
      }
    }
    return favrties;
  }

  Widget headingUpsell(List dataListedCateOffer) {
    print("....!!!!...qqq..qqq...qqq.....$dataListedCateOffer");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 9.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataListedCateOffer.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue),
                          color: selectedIndex == index
                            ? selectedColor
                            : Colors.white,
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
                            color: selectedIndex == index
                              ? Colors.white
                              : Colors.blue,
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
