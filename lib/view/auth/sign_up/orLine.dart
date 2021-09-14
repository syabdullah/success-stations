import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {

    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 17.0, right: 17.0),
            child: Divider(
              color: Colors.grey,
              height: height,
            )),
      ),

      Text(label,style: TextStyle(color: Colors.grey,fontSize: 20),),

      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 17.0, right: 17.0),
            child: Divider(
              color: Colors.grey,
              height: height,
            )),
      ),
    ]);
  }
}