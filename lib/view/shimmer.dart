import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_shimmer/flutter_shimmer.dart';

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
