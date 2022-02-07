import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/app_bar.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/get_size.dart';
import 'package:success_stations/styling/images.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Column(
              children: [
                Container(
                    child: idIdId != null &&
                            idIdId['image'] != null &&
                            idIdId['image']['url'] != null
                        ? Image.network(idIdId['image']['url'],
                            height: Get.height / 2, fit: BoxFit.fitHeight)
                        : Container()),
                Column(
                  children: [
                    Container(
                      height: Get.height / 3.3,
                      child: Card(
                        elevation: 2.0,
                        child: Column(
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
                                  Row(children: [
                                    SizedBox(width: Get.width * 0.015),
                                    Image.asset(AppImages.callerImage,
                                        height: Get.height * 0.035),
                                    SizedBox(width: Get.width * 0.015),
                                    GestureDetector(
                                        onTap: () {},
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
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 14),
                                child: Text("coun".tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400]))),
                            space10,
                            Container(
                                margin: EdgeInsets.only(left: 14, right: 10),
                                alignment: Alignment.topLeft,
                                child: idIdId['country'] != null
                                    ? Text(
                                        idIdId['country']['name'][lang] != null
                                            ? idIdId['country']['name'][lang]
                                            : idIdId['country']['name'][lang] ==
                                                    null
                                                ? idIdId['country']['name']
                                                    ['en']
                                                : '',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      )
                                    : Container()),
                            space50,
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 14),
                                child: Text("descrip".tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400]))),
                            space10,
                            Container(
                                margin: EdgeInsets.only(left: 14, right: 10),
                                alignment: Alignment.topLeft,
                                child: idIdId['description'] != null
                                    ? Text(
                                        idIdId['description'][lang] != null
                                            ? idIdId['description'][lang]
                                            : idIdId['description'][lang] ==
                                                    null
                                                ? idIdId['description']['en']
                                                : '',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      )
                                    : Container()),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
