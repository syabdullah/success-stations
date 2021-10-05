import 'package:animated_widgets/generated/i18n.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer() {
  return  ListView.builder(
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          ListTileShimmer(
            isDarkMode: false,
            // padding: EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(left:6.0),
          ),
        ],
      ),
    itemCount: 20,
  );
}
 bool _enabled = true;

Widget shimmer2() {
  return  ListView.builder(
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
         Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade400,
            enabled: _enabled,
            child:Card(
              child: Container(
                height:200,
                width: double.infinity,
              ),
            ),
            // padding: EdgeInsets.only(right: 20),
            // margin: const EdgeInsets.only(left:6.0),
          ),
        ],
      ),
    itemCount: 1,
  );
}

Widget shimmer3() {
  return  ListView.builder(
    
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
      Shimmer.fromColors(
         baseColor: Colors.grey.shade300,
         highlightColor: Colors.grey.shade400,
         enabled: _enabled,
         child:Padding(
           padding: const EdgeInsets.all(8.0),
           child: Card(
             child: Container(
               height:120,
               width: double.infinity,
               child: Container(
                 height: 30,
               ),
             ),
           ),
         ),
         // padding: EdgeInsets.only(right: 20),
         // margin: const EdgeInsets.only(left:6.0),
       ),
    itemCount:1,
  );
}
