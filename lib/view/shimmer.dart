
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_shimmer/flutter_shimmer.dart';
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
Widget shimmerheading() {
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
    itemCount: 1,
  );
}

Widget playStoreShimmer() {
  return  ListView.builder(
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          PlayStoreShimmer(
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
Widget shimmer4() {
  return  ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
      Shimmer.fromColors(
         baseColor: Colors.grey.shade300,
         highlightColor: Colors.grey.shade400,
         enabled: _enabled,
         child:Padding(
           padding: const EdgeInsets.only(left: 10,right: 10,),
           child: Card(
             child: Container(
               height:20,
               width: double.infinity,
               child: Container(
               ),
             ),
           ),
         ),
         // padding: EdgeInsets.only(right: 20),
         // margin: const EdgeInsets.only(left:6.0),
       ),
    itemCount:14,
  );
}
Widget friendReqShimmer() {
  return  ListView.builder(
    padding: EdgeInsets.only(top: 10),
    scrollDirection: Axis.vertical,   
    shrinkWrap: true,
    itemBuilder: (_, __) => 
    ListTileShimmer(
      isDisabledAvatar: true,
      isDisabledButton: true,
      isRectBox: true,
    ),
    itemCount:14,
  );
}
