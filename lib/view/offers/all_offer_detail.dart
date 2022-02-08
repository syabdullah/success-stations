import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/view/messages/chatting_page.dart';

class MyOfferDetailMain extends StatefulWidget {
  _MyAllOffersDetailState createState() => _MyAllOffersDetailState();
}

class _MyAllOffersDetailState extends State<MyOfferDetailMain> {
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
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     child: Row(
      //       children: [
      //         GestureDetector(
      //           onTap: () => Get.back(),
      //           child: Container(
      //             margin: EdgeInsets.only(left:10, top:5),
      //             child: Icon(Icons.arrow_back,
      //               color: Colors.white, size: 25
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //   ),
      //   backgroundColor: AppColors.whitedColor),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Stack(
              children: [
                Container(
                    child: idIdId != null &&
                            idIdId['image'] != null &&
                            idIdId['image']['url'] != null
                        ? Image.network(idIdId['image']['url'],
                            width: Get.width,
                            height: Get.height / 2, fit: BoxFit.fill,)
                        : Container()),
                Padding(
                  padding: lang == 'ar' ? EdgeInsets.only(right: Get.width * 0.04,top: Get.width * 0.1):EdgeInsets.only(left: Get.width * 0.04,top: Get.width * 0.1),
                  child: InkWell(child: Image.asset(AppImages.roundedBack,height: 35,),
                  onTap: (){
                    Get.back();
                  },),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: Get.height < 700
                      ? Get.height * 0.065
                      : Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: AppColors.outline, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(Get.width * 0.01 ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 21.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.asset(AppImages.man),
                          )
                    ),
                      ),
                      Padding(
                        padding: lang == 'ar' ?  EdgeInsets.only(left: Get.width * 0.30) :  EdgeInsets.only(right: Get.width * 0.30),
                        child: Text("View Profile",style: TextStyle(fontSize: 16,color: Color(0xFF898989)),),
                      ),
                      Row(children: [
                        // SizedBox(width: Get.width * 0.015),
                        Image.asset(AppImages.callerImage,
                            height: Get.height * 0.035),
                        SizedBox(width: Get.width * 0.015),
                        GestureDetector(
                            onTap: () {
                              // Get.toNamed('/inbox');
                            },
                            child: Image.asset(AppImages.chating,
                                height: Get.height * 0.045)),
                        SizedBox(width: Get.width * 0.015),
                        Image.asset(AppImages.whatsapp,
                            height: Get.height * 0.035),
                        SizedBox(width: Get.width * 0.015),
                      ])
                    ],
                  ),
                ),
                space50,
                Padding(
                  padding:  EdgeInsets.all(Get.width * 0.03),
                  child: Text("""There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look eve........"""),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
