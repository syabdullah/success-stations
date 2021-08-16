import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:readmore/readmore.dart';
import 'package:success_stations/view/drawer_screen.dart';

class NotificationPage extends StatefulWidget {
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> offerNotification =  {
  "recent".tr: [
    { 
      "image": "assets/images/coppsule.png",
      "searchText": "John Doe",
      "text": "Selling plan name displayed in the cart and during checkout. It's recommended that this name includes the frequency of deliveries",
      
    },
    { 
      "image": "assets/images/coppsule.png",
      "searchText": "john Doe",
      "text": "Selling plan name displayed in the cart and during checkout. It's recommended that this name includes the frequency of deliveries",
      
    },
    
  ],
  "oldernoti".tr: [
    {
      "image": "assets/images/coppsule.png",
      "searchText": "Sheeza Tariq",
      "text": "Label in the plan selector on the product page",
      
    },
    {
      "image": "assets/images/coppsule.png",
      "searchText": "Sheeza Tariq",
      "text": "Label in the plan selector on the product page",
      
    },
    {
     "image": "assets/images/coppsule.png",
      "searchText": "Sheeza Tariq",
      "text": "Label in the plan selector on the product page",
      
    },
  ], 
  
};
List<String> litems = ['Categoryt A', 'Categoryt 1', 'Categoryt 2','Categoryt 3', 'Categoryt 4', 'Categoryt 5'];
  var listtype = 'list';
  var selectedIndex = 0;
  var grid = AppImages.gridOf;
  Color selectedColor = Colors.blue;
  Color listIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      key: _scaffoldKey,
      appBar:  PreferredSize( preferredSize: Size.fromHeight(70.0),
      child: appbar(_scaffoldKey,context,AppImages.appBarLogo, AppImages.appBarSearch)),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child: AppDrawer(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: sellingPlan(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> sellingPlan() {
      String formattedDate =DateFormat.jm().format(DateTime.now());
      print(formattedDate); 
      List<Widget> items = [];
      for ( int i = 0; i < offerNotification.length; i++ ) {
      var key = offerNotification.keys.elementAt(i);
      for ( int j =0 ; j < offerNotification[key].length; j++ ) {
        items.add( 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              j == 0 ? 
              Container(
                margin: EdgeInsets.only(left: 20,top:10, right: 12),
                child:Text(key,  
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ): Container(),
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
                                    GestureDetector(
                                    onTap: () {},
                                      child: Icon(Icons.cancel, color: Colors.grey,))
                                  ],
                                ),
                                SizedBox(height:5),
                                Container(
                                  // width: 160,
                                  // margin: EdgeInsets.only(bottom:10),
                                  child: ReadMoreText(  
                                  
                                    offerNotification[key][j]['text'],
                                    trimLines: 2,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'See More',
                                    // color: Colors.black
                                    trimExpandedText: 'Show less',
                                    style:TextStyle(color:AppColors.inputTextColor, fontSize: 13) ,
                                  ),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Image.asset(offerNotification[key][j]['image'], height: 30)
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            alignment: Alignment.topRight,
                            child:Text(
                              formattedDate
                            )
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