import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Column(
              children: sellingPlan(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> sellingPlan() {
      List<Widget> items = [];
      for ( int i = 0; i < offerNotification.length; i++ ) {
       
      var key = offerNotification.keys.elementAt(i);
      for ( int j =0 ; j < offerNotification[key].length; j++ ) {
        print("printed values......${offerNotification[key][j]['newText']}");
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
                                      offerNotification[key][j]['searchText'], 
                                      style: TextStyle(
                                        fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal,
                                      )
                                    ),
                                    Text(
                                      offerNotification[key][j]['newText'], 
                                      style: TextStyle(
                                        fontSize: 14,fontWeight: FontWeight.bold, fontStyle:FontStyle.normal, color: offerNotification[key][j]['newText'] == 'New'? AppColors.appBarBackGroundColor: AppColors.snackBarColor,
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(height:5),
                                Container(
                                  child:Text(offerNotification[key][j]['text'],
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
                            Image.asset(offerNotification[key][j]['image'], height: 100)
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