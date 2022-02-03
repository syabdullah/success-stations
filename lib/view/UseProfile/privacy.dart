import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:success_stations/controller/aboutController.dart';
import 'package:success_stations/styling/colors.dart';

import '../shimmer.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

List<String> title = [
  "Direct Call        ",
  "Whatsapp        ",
  "chat                    ",
  "Show number",
  "Show Email     ",
];

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back)),
            centerTitle: true,
            title: Text('privacy'.tr),
            backgroundColor: AppColors.whitedColor),
        body: GetBuilder<ContentManagmentController>(
            init: ContentManagmentController(),
            builder: (val) {
              return val.aboutData != null
                  ? about(val.aboutData['data'])
                  : shimmer4();
            }));
  }
}

Widget about(data) {
  // return
  // Container(
  //   child: ListView.builder(
  //   itemCount:  data.length!= null ? data.length : Container(),
  //   // ignore: non_constant_identifier_names
  //   itemBuilder: (BuildContext,index) {
  //     return index == 4 ?
  //       Column(
  //         children: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
  //           child:Html(data: data[index]['page_text'])
  //          ),
  //        ],
  //       ):Container();
  //     }
  //    ),
  // );
  return Column(
    children: [
      Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                  child: Center(
                      child: Text("Contact Info",
                          style: TextStyle(fontSize: 16)))),
            ),
            Padding(
              padding: EdgeInsets.only(right: 38.0),
              child: Container(
                  child: Center(
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(

          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Center(
                        child: Text(title[index],
                            style: TextStyle(fontSize: 16))),
                  ),
                   VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Center(
                      child: Text(
                    "Any One – friends - Disable",
                    style: TextStyle(
                        fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 5,
        ),
      )
    ],
  );
}
