import 'package:clippy_flutter/trapezoid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/controller/offers/my_offer_controller.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/drawer_screen.dart';


class MyOfferDetailMain extends StatefulWidget {
  _MyAllOffersDetailState createState() => _MyAllOffersDetailState();
}
class _MyAllOffersDetailState extends State<MyOfferDetailMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final putData  = Get.put(MyOffersDrawerController());
  
  var idIdId;

  @override
  void initState() {
    idIdId = Get.arguments;
    print(".....................IF IF ID.......>$idIdId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: getSize(20, context));
     final space10 = SizedBox(height: getSize(10, context));
    return Scaffold( 
      key: _scaffoldKey,
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor: AppColors.botomTiles
        ),
        child: AppDrawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:20),
            Container(
              child: Column(
              children: [
                Container(
                  width: Get.width/1.1,
                  child: Image.network(idIdId['image']['url']!=null ?idIdId['image']['url']:'', height:Get.height/2, fit:BoxFit.fitHeight )
                ),
                Column(
                  children: [     
                    Container(
                      height: Get.height/3.3,
                      child: Card(
                        elevation: 2.0,
                        margin: EdgeInsets.only(left:20,right:20),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/1,
                              color: AppColors.appBarBackGroundColor,
                              padding: EdgeInsets.only(top:10,bottom:15,left: 15),
                                child: Text(idIdId['url'] !=null ? idIdId['url'] :''
                                ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                                ),
                            ),
                            space50,
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left:14),
                                child: Text("DESCRIPTION:", style:TextStyle(fontSize:14, color:Colors.grey[400]))
                              ),
                              space10,
                              Container(
                                  margin: EdgeInsets.only(left:14, right:10),
                                alignment: Alignment.topLeft,
                                child:idIdId['description']!=null  &&idIdId['description']['en']!=null ?   Text(
                                  idIdId['description']['en'], style:TextStyle(color:Colors.black, fontSize: 14), 
                                ):Container()
                              ),

                              
                            ],
                          ),
                          ),
                        )  ,
                        // SizedBox(height:40)  
                      ],
                    )
                    // Row(
                    //   children: [
                    //     Container(
                    //       height:Get.height *0.04,
                    //       color:Colors.blue,
                    //       width: Get.width/1.3,
                    //       child: Container(
                    //         margin:EdgeInsets.only(left:12,top:3),
                    //         child:  idIdId !=null && idIdId['url'] !=null ? Text(
                    //           idIdId['url'], style:TextStyle(color:Colors.white, fontSize: 14), 
                    //         ):Container()
                    //       )
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //   height:Get.height *0.04,
                    //   width: Get.width/1.3,
                    //   child: Container(
                    //     margin:EdgeInsets.only(top:3),
                    //     child: Text("DESCRIPTION:",
                    //       style:TextStyle(color:Colors.black, fontSize: 16), 
                    //     )
                    //   )
                    // ),
                    // Container(
                    //   height:Get.height *0.04,
                    //   width: Get.width/1.3,
                    //   child: Container(
                    //     margin:EdgeInsets.only(top:3),
                    //     child:idIdId['description']!=null  &&idIdId['description']['en']!=null ?   Text(
                    //       idIdId['description']['en'], style:TextStyle(color:Colors.black, fontSize: 14), 
                    //     ):Container()
                    //   )
                    // ),
                    
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

}

    