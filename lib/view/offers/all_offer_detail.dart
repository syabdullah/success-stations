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
  var lang;

  @override
  void initState() {
    idIdId = Get.arguments;
    lang = box.read('lang_code');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final space50 = SizedBox(height: getSize(20, context));
     final space10 = SizedBox(height: getSize(10, context));
    return Scaffold( 
      key: _scaffoldKey,
      appBar:PreferredSize( preferredSize: Size.fromHeight(70.0),
        child: appbar(_scaffoldKey,context,AppImages.appBarLogo,AppImages.appBarSearch,1),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
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
                  child:  idIdId !=null && idIdId['image'] !=null && idIdId['image']['url'] !=null ? 
                  Image.network(idIdId['image']['url'], height:Get.height/2, fit:BoxFit.fitHeight ):Container(
                    child: Icon(Icons.image,size: 50,),
                  )
                ),
                Column(
                  children: [     
                    Container(
                      height: Get.height/3.3,
                      child: Card(
                        elevation: 2.0,
                        margin: lang=='en'?EdgeInsets.only(left:19,right:19):EdgeInsets.only(left:19,right:19),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/1,
                              color: AppColors.appBarBackGroundColor,
                              padding: EdgeInsets.only(top:10,bottom:15,left: 15),
                              child: idIdId !=null && idIdId['url'] !=null ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( idIdId['url'] ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right:10),
                                      child: Icon(Icons.arrow_forward_ios,color: Colors.white,))
                                  ],
                                ):Container()
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
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

}

    