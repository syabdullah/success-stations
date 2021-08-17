import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/offer_list_controller.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';

class OffersDetail extends StatefulWidget {
  _MyOffersDetailState createState() => _MyOffersDetailState();
}
class _MyOffersDetailState extends State<OffersDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> offerNotification =  {
  "recent": [
    { 
      "image": "assets/images/illustration@3x.png",
      "searchText": "John Doe",
      "newText": "New",
      "text": "Selling plan name displayed in the cart and during checkout. It's recommended that this name includes the frequency of deliveries",
      "urlLink":"anyUrlYouCanPlacehere"
      
    },
    { 
      "image": "assets/images/illustration@3x.png",
      "searchText": "offer Title",
      "newText": "New",
      "text": "Selling plan name displayed in the cart and during checkout. It's recommended that this name includes the frequency of deliveries",
      "urlLink":"anyUrlYouCanPlacehere"
      
    },
    {
      "image": "assets/images/illustration@3x.png",
      "searchText": "Offer Title",
      "newText": "Used",
      "text": "Label in the plan selector on the product page",
      "urlLink":"anyUrlYouCanPlacehere"
      
    },
    {
      "image": "assets/images/illustration@3x.png",
      "searchText": "Sheeza Tariq",
      "newText": "New",
      "text": "Label in the plan selector on the product page",
      "urlLink":"anyUrlYouCanPlacehere"
      
    },
    {
      "image": "assets/images/illustration@3x.png",
      "searchText": "Afifa Basra",
      "newText": "New",
      "text": "Label in the plan selector on the product page",
      "urlLink":"anyUrlYouCanPlacehere"
      
    },
    
  ],
  
};
  var listtype = 'list';
  var mediaList ;
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      key: _scaffoldKey,
      appBar: AppBar(backgroundColor:AppColors.appBarBackGroundColor,title: Text('MY OFFER'),centerTitle: true,),

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
                  child: Text("Add New Offer")
                ),
             
              ],
            ),
            GetBuilder<OfferController>(
              init: OfferController(),
              builder:(val){
                return val.isLoading == true ? Container() : Column(
                  children: allOffersWidget(val.offerDataList),
                );
              },
            )
            
          ],
        ),
      ),
    );
  }

  List<Widget> allOffersWidget(dataListOffer) {
    List<Widget> items = [];
    if(dataListOffer['data'] !=null ){
      for ( int i = 0; i < dataListOffer['data'].length; i++ ) {
        if( dataListOffer['data'][i]['user']['media'].length !=null){
          for(int med =0; med < dataListOffer['data'][i]['user']['media'].length; med++){
            // print("mdia lengyth.....${dataListOffer['data'][i]['media']}");
            mediaList = dataListOffer['data'][i]['user']['media'][med]['url'];
          }
          
        
        
        items.add( 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:10),
              Column(
                children: [
                  Container(
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          ListTile(
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [ 
                                    Text(
                                      dataListOffer['data'][i]['text_ads']['en'] !=null ? 
                                      dataListOffer['data'][i]['text_ads']['en'].toString():'', 
                                      style: TextStyle(
                                        fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal,
                                      )
                                    ),
                                    Text (
                                      dataListOffer['data'][i]['status'] == 1 ? "NEW": 
                                      dataListOffer['data'][i]['status'] == 0 ? "OLD":
                                      dataListOffer['data'][i]['status'] == null ? '':'',
                                      style: TextStyle(
                                        fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color:dataListOffer['data'][i]['status'] == 1?  AppColors.snackBarColor: AppColors.appBarBackGroundColor,
                                      )
                                    )
                                  ],
                                ),
                                SizedBox(height:5),
                                Container(
                                  child:Text(dataListOffer['data'][i]['description'] != null ?
                                   dataListOffer['data'][i]['description']['en'] : "",
                                  style:TextStyle(color:AppColors.inputTextColor, fontSize: 13) )
                                ),
                                SizedBox(height:5),
                                Container(
                                  child: Text( "anyUrlYouCanPlacehere", 
                                  style:TextStyle(color:AppColors.appBarBackGroundColor, fontSize: 13) )
                                )
                              ],
                            ),
                            leading:
                            Image.network(mediaList !=null ? mediaList :"")
                          ),
                          SizedBox(height:10)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        );
      }
    }

    }

   
    return items;
  }
  myAddGridView() {
    return Container(
      width: Get.width / 1.10,
      height: Get.height / 0.3,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(50, (index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left:10),
                child:  Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        child: Container(
                          child: Image.asset('assets/images/coppsule.png',fit: BoxFit.fitHeight)
                        )
                      )
                    ],
                  ),
                )
              ),
              Container(child:Text("Offer 1", style: TextStyle(fontSize: 13, color:Colors.grey[300])))
            ],
          );
        })
      ),
    );
  }
}