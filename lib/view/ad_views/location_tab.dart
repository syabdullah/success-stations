import 'package:flutter/material.dart';
import 'package:success_stations/styling/images.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({ Key? key }) : super(key: key);

  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          filter()
        ],
      ),
    );
  }
}

Widget filter(){
  return Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    ),
    child: Row(
     children: [ Image.asset(AppImages.filter)],
    ),
  );
}