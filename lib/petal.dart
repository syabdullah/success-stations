import 'package:flutter/material.dart';
class petalmap extends StatefulWidget {
  const petalmap({Key? key}) : super(key: key);

  @override
  _petalmapState createState() => _petalmapState();
}

class _petalmapState extends State<petalmap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(child: Container(),
      onTap: () async {
        double? result = await HuaweiMapUtils.distanceCalculator(
        start: LatLng(41.048641, 28.977033),
        end: LatLng(41.063984, 29.033135));

        setState(() {
        if (result != null) distance = result;
        });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        color: Color.fromRGBO(18, 26, 55, 1),
        textColor: Colors.white,
        splashColor: Colors.redAccent,
        padding: EdgeInsets.all(12.0),
        child: Text("Calculate"),
      ),
    );
  }
}
